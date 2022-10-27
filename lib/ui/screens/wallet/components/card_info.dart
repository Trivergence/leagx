import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../view_models/wallet_view_model.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/text_widget.dart';

class CardInfoWidget extends StatelessWidget {
  final WalletViewModel walletModel;
  const CardInfoWidget({
    Key? key,
    required this.walletModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.textFieldColor,
      elevation: 15,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              const Icon(Icons.payment),
              UIHelper.horizontalSpaceSmall,
              TextWidget(
                  text: UIHelper.bullet 
                  + UIHelper.bullet 
                  + UIHelper.bullet 
                  + UIHelper.bullet + " " 
                  + UIHelper.bullet 
                  + UIHelper.bullet
                  + UIHelper.bullet 
                  + UIHelper.bullet + " "
                  + UIHelper.bullet 
                  + UIHelper.bullet 
                  + UIHelper.bullet 
                  + UIHelper.bullet + " "
                  + walletModel.getPayementMethods.first.card!.last4!),
            ],
          ),
          UIHelper.horizontalSpaceSmall,
          TextWidget(
              text: walletModel.getPayementMethods.first.card!.expMonth!
                      .toString() +
                  "/" +
                  walletModel.getPayementMethods.first.card!.expYear!
                      .toString())
        ]),
      ),
    );
  }
}
