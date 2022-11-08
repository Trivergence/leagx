import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:leagx/constants/app_constants.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/models/user_summary.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/base_widget.dart';
import 'package:leagx/ui/screens/wallet/components/card_info.dart';
import 'package:leagx/ui/util/app_dialogs/fancy_dialog.dart';
import 'package:leagx/ui/util/app_dialogs/form_dialog.dart';
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

import '../../../constants/enums.dart';
import '../../../core/network/internet_info.dart';
import '../../widgets/text_widget.dart';
import 'components/bank_info.dart';
import 'components/payout_footer.dart';

// ignore: must_be_immutable
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
            //model.showVerificationDialog(context);
          });
        },
        builder: (context, PayoutViewModel model,_ ) {
        _dashBoardViewModel = context.read<DashBoardViewModel>();
        userSummary = _dashBoardViewModel.userSummary;
        _payoutViewModel = model;
        _context = context;
        getData();
        return !_payoutViewModel!.busy ? Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: loc.payoutTxtTotalAmount,
                        textSize: Dimens.textMedium,
                        fontWeight: FontWeight.bold,
                      ),
                      TextWidget(
                        text: (userSummary != null
                          ? userSummary!.coinEarned!
                              .round()
                              .toString()
                          : "0.0") +
                      "\$",
                        textSize: Dimens.textMedium)
                    ],
                  ),
                ),
                if (listOfExtAccounts.isNotEmpty && _payoutViewModel!.isPayoutAvailble)
                  SizedBox(
                      width: 200,
                      child: MainButton(
                          text: loc.payoutBtnWithdraw,
                          onPressed: _withdraw)),
                UIHelper.verticalSpaceLarge,
                if (listOfExtAccounts.isNotEmpty && _payoutViewModel!.isPayoutAvailble)
                  listOfExtAccounts.first.object == "bank_account"
                      ? BankInfoWidget(
                          bankName: bankName,
                          currency: currency,
                          routingNumber: routingNumber,
                          last4: last4)
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: loc.payoutTxtAttachedCard,
                                textSize: 27,
                                fontWeight: FontWeight.w700,
                                textAlign: TextAlign.start,
                              ),
                              UIHelper.verticalSpaceSmall,
                              CardInfoWidget(
                                last4: listOfExtAccounts.first.last4!,
                                expMonth: listOfExtAccounts
                                    .first.expMonth!
                                    .toString(),
                                expYear: listOfExtAccounts
                                    .first.expYear!
                                    .toString(),
                              ),
                            ],
                          ),
                        ),
                if (listOfExtAccounts.isEmpty && _payoutViewModel!.isPayoutAvailble)
                  MainButton(
                      text: loc.payoutBtnAddBank, onPressed: _addBank)
              ],
            ),
           if(!_payoutViewModel!.isPayoutAvailble) const PayoutFooter(), 
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
    FormDialog.show(
    context: _context!, 
    type: DialogType.payout,
    title: loc.payoutDialogTitle, 
    body: loc.payoutDialogBody,
    negativeBtnTitle: loc.payoutDialogBtnNegative, 
    positiveBtnTitle: loc.payoutDialogBtnPositive, 
    onPositiveBtnPressed: (enteredAmount, withdrawType) async {
      bool isConnected = await InternetInfo.isConnected();
      if(isConnected) {
        String withdrawAmount;
        switch(withdrawType) {
          case WithdrawType.minimum:
            withdrawAmount = AppConstants.minimumWithdraw.toString();
            break;
          case WithdrawType.maximum:
            withdrawAmount = userSummary!.coinEarned!.round().toString();
            break;
          case WithdrawType.custom:
            withdrawAmount = enteredAmount;
            break;
        }
        if (double.parse(withdrawAmount).round() <= userSummary!.coinEarned!.round() ) {
          Loader.showLoader();
          bool isTransfered = await _payoutViewModel!.transferToUser(withdrawAmount);
          if (isTransfered == true) {
            PayoutModel? payoutModel = await _payoutViewModel!.payoutMoney(
                    withdrawAmount, currency!, listOfExtAccounts.first.id!);
            if(payoutModel != null) {
              bool success = await _payoutViewModel!.withdrawCoins(
                amountInDollars: withdrawAmount, 
                payoutToken: payoutModel.id);
              if(success == true) {
                FancyDialog.showSuccess(
                  context: _context!,
                  title: loc.payoutDialogTxtSuccessTitle,
                  onOkPressed: () async => await _payoutViewModel!.updateCoins(_dashBoardViewModel),
                  description: "${loc.payoutDialogTxtSuccessDesc} $withdrawAmount\$");
              } else {
                ToastMessage.show(loc.somethingWentWrong, TOAST_TYPE.error);
              }
              Loader.hideLoader();
            }
          } else {
            Loader.hideLoader();
          }
          } else {
            ToastMessage.show(loc.payoutTxtLessCoins, TOAST_TYPE.error);
          }
      }
     }
    );
  }
}