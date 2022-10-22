import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/models/user_summary.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/base_widget.dart';
import 'package:leagx/ui/util/app_dialogs/payout_dialog.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/loading_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:leagx/view_models/payout_view_model.dart';
import 'package:payments/models/express_account.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../widgets/text_widget.dart';

class PayoutScreen extends StatelessWidget {
  PayoutScreen({ Key? key }) : super(key: key);

  PayoutViewModel? _payoutViewModel;
  BuildContext? _context;
  List<Datum> listOfExtAccounts =[];
  String? bankName;
  String? currency;
  String? last4;
  String? routingNumber;
  UserSummary? userSummary;

  @override
  Widget build(BuildContext context) {
    _context = context;
    userSummary = context.read<DashBoardViewModel>().userSummary;
    return Scaffold(
      appBar: AppBarWidget(title: "Payout"),
      body: BaseWidget<PayoutViewModel>(
        create: false,
        model: context.read<PayoutViewModel>(),
        onModelReady: (PayoutViewModel model) async {
          SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
            await model.initializeData();
          });
        },
        builder: (context, PayoutViewModel model,_ ) {
        _payoutViewModel = model;
        _context = context;
        getData();
        return !_payoutViewModel!.busy ? Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal : 15.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const TextWidget(text: "Total Amount", textSize: Dimens.textMedium, fontWeight: FontWeight.bold,),
              TextWidget(text: (userSummary != null ? userSummary!.coinEarned.toString() : "0.0") + "\$", textSize: Dimens.textMedium)
            ],),
          ),
          if (listOfExtAccounts.isNotEmpty) SizedBox(
            width: 200,
            child: MainButton(text: "Withdraw", onPressed: _withdraw)),
          UIHelper.verticalSpaceLarge,
          if (listOfExtAccounts.isNotEmpty) Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: Card(
                color: AppColors.textFieldColor,
                elevation: 15,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)
              )
            ),
            child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                  child: Row(
                    children:  [
                       const Icon(Icons.account_balance, size: 40,),
                       UIHelper.horizontalSpaceSmall,
                       Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                                TextWidget(text: bankName!),
                                UIHelper.horizontalSpaceSmall,
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                    color: AppColors.colorBackground,
                                    child: TextWidget(text: currency!, textSize: Dimens.textXS,),
                                  ),
                                ),
                              UIHelper.horizontalSpaceSmall,
                              const CircleAvatar(
                                radius: 10,
                                backgroundColor: AppColors.colorGreen,
                                child: Center(child: Icon(
                                  Icons.done, 
                                  color: AppColors.colorWhite, 
                                  size: 10,)))
                             ],
                           ),
                           Row( children: [
                                TextWidget(text: routingNumber!,textSize: Dimens.textSmall,),
                                UIHelper.horizontalSpaceSmall,
                                TextWidget(text: "****  " + last4!),
                              ],
                            ),
                         ],
                       ),
                    ],
                  ),
            ),
            ),
          ),
          if(listOfExtAccounts.isEmpty) MainButton(text: "Add Bank", onPressed: _addBank)
        ],
      )
      : const LoadingWidget();
        },
        )
    );
  }

  Future<void> _addBank() async {
    String? linkUrl = await _payoutViewModel!.addBank();
    if(linkUrl != null) {
      Navigator.pushNamed(_context!, Routes.addPayoutDetails, arguments: linkUrl).then((_) {
        _payoutViewModel!.initializeData();
      });
    }
  }

  void getData() {
    if(_payoutViewModel!.expressAccount != null) {
      listOfExtAccounts = _payoutViewModel!.expressAccount!.externalAccounts!.data;
      if(listOfExtAccounts.isNotEmpty) {
        last4 = listOfExtAccounts.first.last4;
        bankName = listOfExtAccounts.first.bankName;
        routingNumber = listOfExtAccounts.first.routingNumber;
        currency = listOfExtAccounts.first.currency!.toUpperCase();
      }
    }
  }

  void _withdraw() async {
    PayoutDialog.show(context: _context!, 
    title: "Withdraw", 
    body: "Enter amount", 
    negativeBtnTitle: "Cancel", 
    positiveBtnTitle: "Withdraw", 
    onPositiveBtnPressed: (amount) async {
      bool isTransfered = await _payoutViewModel!.transferToUser(amount);
        if (isTransfered == true) {
          bool success = await _payoutViewModel!.payoutMoney(amount, currency!, listOfExtAccounts.first.id!);
          if(success == true) {
            AwesomeDialog(
              context: _context!,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              title: "Completed Successfully",
              btnOkOnPress: () {
              },
            ).show();
          }
        }
    });
  }
}