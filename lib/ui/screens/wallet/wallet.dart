import 'package:flutter/material.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/screens/base_widget.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/view_models/wallet_view_model.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<WalletViewModel>(
      create: false,
      model: context.read<WalletViewModel>(), 
      onModelReady: (WalletViewModel walletModel) async {
        await walletModel.getData();
      },
      builder: (context, WalletViewModel walletModel, _) {
      return  Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
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
            MainButton(text: "Add Payment Methods", onPressed: () {})
        ]),
      ),
    );
      }, 
      );
  }
}