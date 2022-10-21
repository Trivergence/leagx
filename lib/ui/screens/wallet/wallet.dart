import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/base_widget.dart';
import 'package:leagx/ui/util/app_dialogs/confirmation_dialog.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/loading_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/view_models/wallet_view_model.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({ Key? key }) : super(key: key);

  late WalletViewModel _walletViewModel;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return BaseWidget<WalletViewModel>(
      create: false,
      model: context.read<WalletViewModel>(), 
      onModelReady: (WalletViewModel walletModel) async {
        SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
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
            const TextWidget(
            text: "Wallet", 
            textSize: 30, 
            fontWeight: FontWeight.bold,),
            UIHelper.verticalSpaceSmall,
            SizedBox(
              height: 200,
              child: Card(
                color: AppColors.textFieldColor,
                elevation: 15,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextWidget(text: "Betting Coins", 
                       color: AppColors.colorWhite,
                       fontWeight: FontWeight.w700,
                       ),
                      UIHelper.verticalSpaceSmall,
                      Row(
                        children: const  [
                         TextWidget(text: "RS", textSize: 27, fontWeight: FontWeight.w700,),
                         UIHelper.horizontalSpaceSmall,
                         TextWidget(text: "0.00", textSize: 27, fontWeight: FontWeight.w700,
                        ),
                      ],),

                      UIHelper.verticalSpaceMedium,
                      // MainButton(
                      //   width: 150,
                      //   text: "Add Funds", onPressed: () {})
                    ],
                  ),
                ),
              ),
            ),
            const TextWidget(text: "Attached Card", textSize: 27,
            fontWeight: FontWeight.w700),
            UIHelper.verticalSpaceSmall,
            if(walletModel.getPayementMethods.isEmpty) const TextWidget(text: "No card added yet"),
            UIHelper.verticalSpaceSmall,
            walletModel.getPayementMethods.isEmpty 
            ? MainButton(text: "Add Payment Methods", onPressed: _addPaymentMethod)
            :  Column(
              children: [
                Card(
                  color: AppColors.textFieldColor,
                  elevation: 15,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)
                )
          ),
          child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.payment),
                        TextWidget(text: "**** **** **** " + walletModel.getPayementMethods.first.card!.last4!),
                      ],
                    ),
                    UIHelper.horizontalSpaceSmall,
                     TextWidget(text: walletModel
                        .getPayementMethods
                                                        .first.card!.expMonth!
                        .toString() +
                    "/" +
                    walletModel
                        .getPayementMethods
                                                        .first.card!.expYear!
                        .toString())
                ]),
          ),
          ),
          TextButton(
            onPressed: _showConfirmationDialog, 
            child: const TextWidget(text : "Remove", color: AppColors.colorRed,)),
          
            ],
          ),
          UIHelper.verticalSpaceLarge,
          MainButton(
            text: "Payout",
            onPressed: () =>
                Navigator.of(context).pushNamed(Routes.payout),
          ),
        ]),
      )
      : const LoadingWidget(),
    );
      }, 
      );
  }

  void _addPaymentMethod() {
    _walletViewModel.addPaymentMethod();
  }

  _showConfirmationDialog() {
    ConfirmationDialog.show(
        context: _context,
        title: "Confirmation",
        body: "Are you sure you want to remove this card?",
        negativeBtnTitle: "No",
        positiveBtnTitle: "Yes",
        onPositiveBtnPressed: (dialogContext) => _removeCard(dialogContext));
  }

  Future<void> _removeCard(BuildContext context) async {
    Navigator.of(context).pop();
    await _walletViewModel.removePaymentMethod();
  }
}