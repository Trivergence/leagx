import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/models/user_summary.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/base_widget.dart';
import 'package:leagx/ui/util/app_dialogs/confirmation_dialog.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/loading_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:leagx/view_models/wallet_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/network/internet_info.dart';
import '../../util/locale/localization.dart';
import 'components/card_info.dart';
import 'components/wallet_widget.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({ Key? key }) : super(key: key);

  late WalletViewModel _walletViewModel;
  UserSummary? userSummary;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    userSummary = context.read<DashBoardViewModel>().userSummary;
    return BaseWidget<WalletViewModel>(
      create: false,
      model: context.read<WalletViewModel>(), 
      onModelReady: (WalletViewModel walletModel) async {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
          await walletModel.getData();
        });
      },
      builder: (context, WalletViewModel walletModel, _) {
        _walletViewModel = walletModel;
      return  Scaffold(
      appBar: AppBarWidget(),
      body: !walletModel.busy ? SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:  [
            TextWidget(
            text: loc.walletTxtWallet, 
            textSize: 30, 
            fontWeight: FontWeight.bold,),
            UIHelper.verticalSpaceSmall,
            WalletWidget(userSummary: userSummary),
            if(walletModel.getPayementMethods.isNotEmpty) TextWidget(text: loc.walletTxtAttachedCard, textSize: 27,
            fontWeight: FontWeight.w700),
            UIHelper.verticalSpaceSmall,
            //if(walletModel.getPayementMethods.isEmpty) const TextWidget(text: "No card added yet"),
            UIHelper.verticalSpaceSmall,
            walletModel.getPayementMethods.isEmpty 
            ? MainButton(text: loc.walletBtnaddMethod, onPressed: _addPaymentMethod)
            :  Column(
              children: [
                CardInfoWidget(
                  walletModel: walletModel,
                ),
                TextButton(
                  onPressed: _showConfirmationDialog, 
                  child: TextWidget(text : loc.walletBtnRemove, color: AppColors.colorRed,)),
            ],
          ),
          UIHelper.verticalSpaceLarge,
          MainButton(
            text: loc.walletBtnPayout,
            onPressed: () async {
              bool isConnected = await InternetInfo.isConnected();
              if(isConnected) {
                Navigator.of(context).pushNamed(Routes.payout);
              }
            }
          ),
        ]),
      )
      : const LoadingWidget(),
    );
      }, 
      );
  }

  Future<void> _addPaymentMethod() async {
    bool isConnected = await InternetInfo.isConnected();
    if(isConnected) {
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
    if(isConnected){
    Navigator.of(context).pop();
    await _walletViewModel.removePaymentMethod();
    }
  }
}

