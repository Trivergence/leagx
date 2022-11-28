import 'package:flutter/material.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/constants/enums.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';

import '../../../constants/colors.dart';
import '../../widgets/text_widget.dart';
import '../locale/localization.dart';

class PaymentMethodDialog {
  static void show({required BuildContext context,
   required String title, 
   required String negativeBtnTitle,
   required String positiveBtnTitle,
   required Function(BuildContext, PaymentType) onPositiveBtnPressed
   } ) {
    showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return PaymentMethodDialogWidget(
        title: title,
        negativeBtnTitle: negativeBtnTitle,
        positiveBtnTitle: positiveBtnTitle,
        onPositiveBtnPressed: onPositiveBtnPressed,
      );
    });
  }
}

class PaymentMethodDialogWidget extends StatefulWidget {
  final String title;
  final String negativeBtnTitle;
  final String positiveBtnTitle;
  final Function(BuildContext, PaymentType) onPositiveBtnPressed;


  const PaymentMethodDialogWidget({
    Key? key, 
    required this.title, 
    required this.negativeBtnTitle, 
    required this.positiveBtnTitle, 
    required this.onPositiveBtnPressed,
  }) : super(key: key);

  @override
  State<PaymentMethodDialogWidget> createState() => _PaymentMethodDialogWidgetState();
}

class _PaymentMethodDialogWidgetState extends State<PaymentMethodDialogWidget> {
  PaymentType selectedType = PaymentType.wallet;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextWidget(
        text: widget.title,
        fontWeight: FontWeight.w700,
        textSize:  Dimens.textMedium,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              setState(() {
                selectedType = PaymentType.wallet;
              });
            },
            tileColor: AppColors.textFieldColor,
            title: TextWidget(text : loc.choosePlanDialogSelectWallet),
            trailing: selectedType == PaymentType.wallet ? const Icon(Icons.done, 
             color: AppColors.primaryColorDark,) : null,
          ),
          UIHelper.verticalSpaceSmall,
          ListTile(
            onTap: () {
              setState(() {
                selectedType = PaymentType.card;
              });
            },
            tileColor: AppColors.textFieldColor,
            title: TextWidget(text: loc.choosePlanDialogSelectCard),
            trailing: selectedType ==
                PaymentType.card ? const Icon(Icons.done, color: AppColors.primaryColorDark,) : null,
          )
        ],
      ),
      backgroundColor: AppColors.colorBackground,
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(widget.negativeBtnTitle),
        ),
        TextButton(
          onPressed: () => widget.onPositiveBtnPressed(context, selectedType),
          child: Text(widget.positiveBtnTitle),
        ),
      ],
    );
  }
}