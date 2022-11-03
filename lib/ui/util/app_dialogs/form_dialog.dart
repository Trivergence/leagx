import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/constants/enums.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/ui/validation_helper.dart';
import 'package:leagx/ui/widgets/textfield/textfield_widget.dart';

import '../../../constants/colors.dart';
import '../../widgets/text_widget.dart';
import '../ui/keyboardoverlay.dart';

class FormDialog {
  static void show(
      {required BuildContext context,
      required DialogType type,
      required String title,
      required String body,
      required String negativeBtnTitle,
      required String positiveBtnTitle,
      required Function(String) onPositiveBtnPressed}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return type == DialogType.payout ? PayoutDialogWidget(
            title: title, 
            body: body, 
            negativeBtnTitle: negativeBtnTitle,
            positiveBtnTitle: positiveBtnTitle, 
            onPositiveBtnPressed : onPositiveBtnPressed)
          : AddCoinsDialogWidget(
            title: title,
            body: body,
            negativeBtnTitle: negativeBtnTitle,
            positiveBtnTitle: positiveBtnTitle,
            onPositiveBtnPressed: onPositiveBtnPressed)
          ;
      });
  }
}

class PayoutDialogWidget extends StatefulWidget {
  final String title;
  final String body;
  final String negativeBtnTitle;
  final String positiveBtnTitle;
  final Function(String) onPositiveBtnPressed;
  const PayoutDialogWidget({
    Key? key, 
    required this.title, 
    required this.body, 
    required this.negativeBtnTitle, 
    required this.positiveBtnTitle, 
    required this.onPositiveBtnPressed, 
  }) : super(key: key);

  @override
  State<PayoutDialogWidget> createState() => _PayoutDialogWidgetState();
}

class _PayoutDialogWidgetState extends State<PayoutDialogWidget> {
  TextEditingController amountController = TextEditingController();
  final FocusNode _fieldNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late BuildContext _context;
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    var keyboardVisibilityController = KeyboardVisibilityController();
    startNodeListener(keyboardVisibilityController);
    super.initState();
  }

   @override
  void dispose() {
    if (Platform.isIOS) {
      keyboardSubscription.cancel();
      _fieldNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
          TextWidget(text: widget.body),
          UIHelper.verticalSpaceSmall,
          SizedBox(
            height: 50,
            child: TextFieldWidget(
              inputType: TextInputType.number,
              inputAction: TextInputAction.done,
              textController: amountController,
              listOfFormaters: [FilteringTextInputFormatter.digitsOnly],
              validator: (text) => ValidationHelper.validateAmount(text),
              prefix: 
              const TextWidget(text: "\$", fontWeight: FontWeight.bold, textSize: Dimens.textMedium,)
             ),
          )
        ],),
      ),
      backgroundColor: AppColors.colorBackground,
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(widget.negativeBtnTitle),
        ),
        TextButton(
          onPressed: _withdraw,
          child: Text(widget.positiveBtnTitle),
        ),
      ],
    );
  }

  void _withdraw() {
    if(_formKey.currentState!.validate()) {
      Navigator.of(_context).pop();
      widget.onPositiveBtnPressed(amountController.text);
    }
  }
  
  void startNodeListener(KeyboardVisibilityController keyboardVisibilityController) {
     _fieldNode.addListener(
      () {
        if (_fieldNode.hasFocus) {
          startkeyboardListener(keyboardVisibilityController);
        } else {
          if (Platform.isIOS) {
            keyboardSubscription.cancel();
            KeyboardOverlay.removeOverlay();
          }
        }
      },
    );
  }

    void startkeyboardListener(
      KeyboardVisibilityController keyboardVisibilityController) {
    if (Platform.isIOS) {
      keyboardSubscription = keyboardVisibilityController.onChange.listen(
        (visible) {
          if (visible) {
            KeyboardOverlay.showOverlay(context);
          } else {
            KeyboardOverlay.removeOverlay();
          }
        },
      );
    }
  }
}

class AddCoinsDialogWidget extends StatefulWidget {
  final String title;
  final String body;
  final String negativeBtnTitle;
  final String positiveBtnTitle;
  final Function(String) onPositiveBtnPressed;
  const AddCoinsDialogWidget({
    Key? key,
    required this.title,
    required this.body,
    required this.negativeBtnTitle,
    required this.positiveBtnTitle,
    required this.onPositiveBtnPressed,
  }) : super(key: key);

  @override
  State<AddCoinsDialogWidget> createState() => _AddCoinsDialogWidgetState();
}

class _AddCoinsDialogWidgetState extends State<AddCoinsDialogWidget> {
  TextEditingController amountController = TextEditingController();
  final FocusNode _fieldNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late StreamSubscription<bool> keyboardSubscription;

  late BuildContext _context;

    @override
  void initState() {
    var keyboardVisibilityController = KeyboardVisibilityController();
    startNodeListener(keyboardVisibilityController);
    super.initState();
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      keyboardSubscription.cancel();
      _fieldNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(text: widget.body),
            UIHelper.verticalSpaceSmall,
            SizedBox(
              height: 50,
              child: TextFieldWidget(
                inputType: TextInputType.number,
                inputAction: TextInputAction.done,
                focusNode: _fieldNode,
                textController: amountController,
                listOfFormaters: [FilteringTextInputFormatter.digitsOnly],
                validator: (text) => ValidationHelper.validateAmount(text),
              ),
            )
          ],
        ),
      ),
      backgroundColor: AppColors.colorBackground,
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(widget.negativeBtnTitle),
        ),
        TextButton(
          onPressed: _withdraw,
          child: Text(widget.positiveBtnTitle),
        ),
      ],
    );
  }

  void _withdraw() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(_context).pop();
      widget.onPositiveBtnPressed(amountController.text);
    }
  }
    void startNodeListener(KeyboardVisibilityController keyboardVisibilityController) {
     _fieldNode.addListener(
      () {
        if (_fieldNode.hasFocus) {
          startkeyboardListener(keyboardVisibilityController);
        } else {
          if (Platform.isIOS) {
            keyboardSubscription.cancel();
            KeyboardOverlay.removeOverlay();
          }
        }
      },
    );
  }

    void startkeyboardListener(
      KeyboardVisibilityController keyboardVisibilityController) {
    if (Platform.isIOS) {
      keyboardSubscription = keyboardVisibilityController.onChange.listen(
        (visible) {
          if (visible) {
            KeyboardOverlay.showOverlay(context);
          } else {
            KeyboardOverlay.removeOverlay();
          }
        },
      );
    }
  }
}
