import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/screens/base_widget.dart';
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

  @override
  Widget build(BuildContext context) {
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
                      const TextWidget(text: "Betting Cash", 
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
                      MainButton(
                        width: 150,
                        text: "Add Funds", onPressed: () {})
                    ],
                  ),
                ),
              ),
            ),
            const TextWidget(text: "Payment Methods", textSize: 27,
              fontWeight: FontWeight.w700),
              UIHelper.verticalSpaceSmall,
            if(walletModel.paymentMethods.isEmpty) const TextWidget(text: "No Payment Method Added yet"),
            walletModel.paymentMethods.isEmpty 
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
                        TextWidget(text: "**** **** **** " + walletModel.paymentMethods.first.card!.last4!),
                      ],
                    ),
                    UIHelper.horizontalSpaceSmall,
                     TextWidget(text: walletModel
                        .paymentMethods.first.card!.expMonth!
                        .toString() +
                    "/" +
                    walletModel
                        .paymentMethods.first.card!.expYear!
                        .toString())
                ]),
          ),
          ),
          TextButton(
            onPressed: _removeCard, 
            child: const TextWidget(text : "Remove", color: AppColors.colorRed,))
              ],
            )
        ]),
      )
      : const LoadingWidget()
      ,
    );
      }, 
      );
  }

  void _addPaymentMethod() {
    _walletViewModel.addPaymentMethod();
  }

  void _removeCard() {
    _walletViewModel.removePaymentMethod();
  }
}