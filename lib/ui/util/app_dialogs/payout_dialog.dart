import 'package:flutter/material.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/ui/validation_helper.dart';
import 'package:leagx/ui/widgets/textfield/textfield_widget.dart';

import '../../../constants/colors.dart';
import '../../widgets/text_widget.dart';

class PayoutDialog {
  static void show(
      {required BuildContext context,
      required String title,
      required String body,
      required String negativeBtnTitle,
      required String positiveBtnTitle,
      required Function(String) onPositiveBtnPressed}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return PayoutFormWidget(title: title, 
        body: body, 
        negativeBtnTitle: negativeBtnTitle, 
        positiveBtnTitle: positiveBtnTitle, onPositiveBtnPressed : onPositiveBtnPressed);
      });
  }
}

class PayoutFormWidget extends StatelessWidget {
  final String title;
  final String body;
  final String negativeBtnTitle;
  final String positiveBtnTitle;
  final Function(String) onPositiveBtnPressed;
  PayoutFormWidget({
    Key? key, required this.title, required this.body, required this.negativeBtnTitle, required this.positiveBtnTitle, required this.onPositiveBtnPressed,
  }) : super(key: key);

  TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return AlertDialog(
      title: TextWidget(
        text: title,
        fontWeight: FontWeight.w700,
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
          TextWidget(text: body),
          UIHelper.verticalSpaceSmall,
          TextFieldWidget(
            textController: amountController,
            validator: (text) => ValidationHelper.validateAmount(text),
            prefix: const TextWidget(text: "\$"),
           )
        ],),
      ),
      backgroundColor: AppColors.colorBackground,
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(negativeBtnTitle),
        ),
        TextButton(
          onPressed: _withdraw,
          child: Text(positiveBtnTitle),
        ),
      ],
    );
  }

  void _withdraw() {
    if(_formKey.currentState!.validate()) {
      Navigator.of(_context).pop();
      onPositiveBtnPressed(amountController.text);
    }
  }
}