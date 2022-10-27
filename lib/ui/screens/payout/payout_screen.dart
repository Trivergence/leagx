import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/models/user_summary.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/base_widget.dart';
import 'package:leagx/ui/util/app_dialogs/fancy_dialog.dart';
import 'package:leagx/ui/util/app_dialogs/payout_dialog.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/loading_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:leagx/view_models/payout_view_model.dart';
import 'package:payments/models/express_account.dart';
import 'package:payments/models/payout_model.dart';
import 'package:provider/provider.dart';

import '../../../core/network/internet_info.dart';
import '../../widgets/text_widget.dart';
import 'components/bank_info.dart';

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
  late DashBoardViewModel _dashBoardViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: loc.payoutTxtPayout),
      body: BaseWidget<PayoutViewModel>(
        create: false,
        model: context.read<PayoutViewModel>(),
        onModelReady: (PayoutViewModel model) async {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
            await model.initializeData();
          });
        },
        builder: (context, PayoutViewModel model,_ ) {
        _dashBoardViewModel = context.read<DashBoardViewModel>();
        userSummary = _dashBoardViewModel.userSummary;
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
              TextWidget(text: loc.payoutTxtTotalAmount, textSize: Dimens.textMedium, fontWeight: FontWeight.bold,),
              TextWidget(text: (userSummary != null 
              ? userSummary!.coinEarned!.round().toString()
              : "0.0") + "\$", textSize: Dimens.textMedium)
            ],),
          ),
          if (listOfExtAccounts.isNotEmpty) SizedBox(
            width: 200,
            child: MainButton(text: loc.payoutBtnWithdraw, onPressed: _withdraw)),
          UIHelper.verticalSpaceLarge,
          if (listOfExtAccounts.isNotEmpty) BankInfoWidget(bankName: bankName, 
              currency: currency,
              routingNumber: routingNumber, 
              last4: last4),
          if(listOfExtAccounts.isEmpty) MainButton(text: loc.payoutBtnAddBank, onPressed: _addBank)
        ],
      )
      : const LoadingWidget();
        },
        )
    );
  }

  Future<void> _addBank() async {
    bool isConnected = await InternetInfo.isConnected();
    if (isConnected) {
      String? linkUrl = await _payoutViewModel!.addBank();
      if(linkUrl != null) {
        Navigator.pushNamed(_context!, Routes.addPayoutDetails, arguments: linkUrl).then((_) {
          _payoutViewModel!.initializeData();
        });
      }
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
    title: loc.payoutDialogTitle, 
    body: loc.payoutDialogBody,
    negativeBtnTitle: loc.payoutDialogBtnNegative, 
    positiveBtnTitle: loc.payoutDialogBtnPositive, 
    onPositiveBtnPressed: (amount) async {
      bool isConnected = await InternetInfo.isConnected();
      if(isConnected) {
        // if (double.parse(amount) <= double.parse(userSummary!.coinEarned.toString())) {
        if (double.parse(amount).round() <= userSummary!.coinEarned!.round() ) {
          Loader.showLoader();
          bool isTransfered = await _payoutViewModel!.transferToUser(amount);
          if (isTransfered == true) {
            PayoutModel? payoutModel = await _payoutViewModel!.payoutMoney(amount, currency!, listOfExtAccounts.first.id!);
            if(payoutModel != null) {
              bool success = await _payoutViewModel!.withdrawCoins(
                amountInDollars: amount, 
                payoutToken: payoutModel.id);
              if(success == true) {
                FancyDialog.showSuccess(
                  context: _context!,
                  title: loc.payoutDialogTxtSuccessTitle,
                  onOkPressed: () async => await _payoutViewModel!.updateCoins(_dashBoardViewModel),
                  description: "${loc.payoutDialogTxtSuccessDesc} $amount\$");
              } else {
                ToastMessage.show(loc.somethingWentWrong, TOAST_TYPE.error);
              }
              Loader.hideLoader();
            }
          } else {
            Loader.hideLoader();
          }
          //TODO localization
          } else {
            ToastMessage.show("You don't have enough coins", TOAST_TYPE.error);
          }
      // } else {
      //   ToastMessage.show("You don't have enough coins", TOAST_TYPE.msg);
      // }
      }
     }
    );
  }
}