import 'package:flutter/material.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/models/user_summary.dart';
import 'package:leagx/ui/screens/base_widget.dart';
import 'package:leagx/ui/util/app_dialogs/confirmation_dialog.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/loading_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:leagx/view_models/wallet_view_model.dart';
import 'package:provider/provider.dart';

import '../../../constants/dimens.dart';
import '../../../core/network/internet_info.dart';
import '../../util/locale/localization.dart';
import 'components/card_info.dart';
import 'components/wallet_widget.dart';

// ignore: must_be_immutable
class WalletScreen extends StatelessWidget {
  WalletScreen({ Key? key }) : super(key: key);

  late WalletViewModel _walletViewModel;
  UserSummary? _userSummary;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    _userSummary = context.select<DashBoardViewModel, UserSummary?>(
        (dasboardModel) => dasboardModel.userSummary);
    return BaseWidget<WalletViewModel>(
      create: false,
      model: context.read<WalletViewModel>(), 
      onModelReady: (WalletViewModel walletModel) async {
        // SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
        //   await walletModel.getUserPaymentMethods();
        // });
      },
      builder: (context, WalletViewModel walletModel, _) {
        _walletViewModel = walletModel;
      return  Container(
      child: !walletModel.busy ? SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children:  [
            TextWidget(
              text: loc.walletTxtWallet.toUpperCase(),
              fontWeight: FontWeight.w600,
              letterSpace: 4,
              textSize: Dimens.textRegular,
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpaceSmall,
            WalletWidget(userSummary: _userSummary),
            UIHelper.verticalSpaceSmall,
            if(walletModel.getPayementMethods.isNotEmpty) TextWidget(
              text: loc.walletTxtAttachedMethod.toUpperCase(), 
              fontWeight: FontWeight.w600,
              letterSpace: 4,
              textSize: Dimens.textRegular),
            UIHelper.verticalSpace(5.0),
            walletModel.getPayementMethods.isEmpty 
            ? MainButton(
              text: loc.walletBtnaddMethod, 
              onPressed: _addPaymentMethod)
            :  Column(
              children: [
                CardInfoWidget(
                  last4: walletModel
                                        .getPayementMethods.first.card!.last4!,
                  expMonth: walletModel.getPayementMethods
                                        .first.card!.expMonth!
                                        .toString(),
                  expYear: walletModel
                                        .getPayementMethods.first.card!.expYear!
                                        .toString(),
                ),
                TextButton(
                  onPressed: _showConfirmationDialog, 
                  child: TextWidget(
                   text : loc.walletBtnRemove,
                   color: AppColors.colorRed,
                   fontWeight: FontWeight.w600,)),
            ],
          ),
          UIHelper.verticalSpaceLarge,
        ]),
      )
      : const LoadingWidget(),
    );
      }, 
      );
  }

  Future<void> _addPaymentMethod() async {
    bool isConnected = await InternetInfo.isConnected();
    if(isConnected == true) {
      await _walletViewModel.addPaymentMethod();
    }
  }

  _showConfirmationDialog() {
    ConfirmationDialog.show(
        context: _context,
        title: loc.walletRemoveDialogTitle,
        body: loc.walletRemoveDialogBody,
        negativeBtnTitle: loc.walletRemoveDialogBtnNegative,
        positiveBtnTitle: loc.walletRemoveDialogBtnPositive,
        onPositiveBtnPressed: (dialogContext) => _removeCard(dialogContext));
  }

  Future<void> _removeCard(BuildContext context) async {
    bool isConnected = await InternetInfo.isConnected();
    if(isConnected == true){
    Navigator.of(context).pop();
    await _walletViewModel.removePaymentMethod();
    }
  }
}

