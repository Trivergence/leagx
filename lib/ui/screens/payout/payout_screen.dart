import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/base_widget.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/loading_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/view_models/payout_view_model.dart';
import 'package:payments/models/express_account.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../widgets/text_widget.dart';

class PayoutScreen extends StatelessWidget {
  PayoutScreen({ Key? key }) : super(key: key);

  late PayoutViewModel _payoutViewModel;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Payout"),
      body: BaseWidget<PayoutViewModel>(
        model: context.read<PayoutViewModel>(), 
        onModelReady: (PayoutViewModel model) async {
          SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
            await model.initializeData();
          });
        },
        builder: (context, PayoutViewModel model,_ ) {
        _payoutViewModel = model;
        _context = context;
        return !_payoutViewModel.busy ? Column(
        children: [
          SizedBox(
            width: 200,
            child: MainButton(text: "Withdraw", onPressed: () {})),
          UIHelper.verticalSpaceLarge,
          if (_payoutViewModel.expressAccount!.externalAccounts!.data.isNotEmpty) Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                                TextWidget(text: _payoutViewModel.expressAccount!.externalAccounts!.data.first.bankName!),
                                UIHelper.horizontalSpaceSmall,
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                    color: AppColors.colorBackground,
                                    child: TextWidget(text: _payoutViewModel.expressAccount!
                                        .externalAccounts!.data.first.currency!.toUpperCase(), textSize: Dimens.textXS,),
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
                                TextWidget(text: _payoutViewModel.expressAccount!
                                                .externalAccounts!.data.first.routingNumber!,textSize: Dimens.textSmall,),
                                UIHelper.horizontalSpaceSmall,
                                TextWidget(text: "****  " + _payoutViewModel
                                  .expressAccount!
                                  .externalAccounts!
                                  .data
                                  .first.last4!),
                              ],
                            ),
                         ],
                       ),
                    ],
                  ),
            ),
            ),
          ),
          MainButton(text: "Add Bank", onPressed: _addBank)
        ],
      )
      : const LoadingWidget();
        },
        )
    );
  }

  Future<void> _addBank() async {
    String? linkUrl = await _payoutViewModel.addBank();
    if(linkUrl != null) {
      Navigator.pushNamed(_context, Routes.addPayoutDetails, arguments: linkUrl).then((_) {
        _payoutViewModel.initializeData();
      });
    }
  }
}