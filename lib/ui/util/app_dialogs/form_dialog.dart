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
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/colors.dart';
import '../../widgets/text_widget.dart';
import '../locale/localization.dart';
import '../models/withdraw_choice.dart';
import '../ui/keyboardoverlay.dart';

class FormDialog {
  static void show(
      {required BuildContext context,
      required DialogType type,
      required String title,
      required String body,
      required String negativeBtnTitle,
      required String positiveBtnTitle,
      required Function(String, WithdrawType) onPositiveBtnPressed}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return
              // type == DialogType.payout ?
              PayoutDialogWidget(
                  title: title,
                  body: body,
                  negativeBtnTitle: negativeBtnTitle,
                  positiveBtnTitle: positiveBtnTitle,
                  onPositiveBtnPressed: onPositiveBtnPressed)
              // : AddCoinsDialogWidget(
              //   title: title,
              //   body: body,
              //   negativeBtnTitle: negativeBtnTitle,
              //   positiveBtnTitle: positiveBtnTitle,
              //   onPositiveBtnPressed: onPositiveBtnPressed)
              ;
        });
  }
}

// ignore: must_be_immutable
class PayoutDialogWidget extends StatelessWidget {
  final String title;
  final String body;
  final String negativeBtnTitle;
  final String positiveBtnTitle;
  final Function(String, WithdrawType) onPositiveBtnPressed;
  PayoutDialogWidget({
    Key? key,
    required this.title,
    required this.body,
    required this.negativeBtnTitle,
    required this.positiveBtnTitle,
    required this.onPositiveBtnPressed,
  }) : super(key: key);

  TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late BuildContext _context;
  WithdrawType withdrawType = WithdrawType.minimum;

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
            TextWidget(
              text: body,
              textSize: Dimens.textMedium,
            ),
            RadioGroup(
              amountController: amountController,
              onRadioChanged: (type) {
                withdrawType = type;
              },
            ),
          ],
        ),
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
    if (_formKey.currentState!.validate()) {
      Navigator.of(_context).pop();
      onPositiveBtnPressed(amountController.text, withdrawType);
    }
  }
}

// class AddCoinsDialogWidget extends StatefulWidget {
//   final String title;
//   final String body;
//   final String negativeBtnTitle;
//   final String positiveBtnTitle;
//   final Function(String) onPositiveBtnPressed;
//   const AddCoinsDialogWidget({
//     Key? key,
//     required this.title,
//     required this.body,
//     required this.negativeBtnTitle,
//     required this.positiveBtnTitle,
//     required this.onPositiveBtnPressed,
//   }) : super(key: key);

//   @override
//   State<AddCoinsDialogWidget> createState() => _AddCoinsDialogWidgetState();
// }

// class _AddCoinsDialogWidgetState extends State<AddCoinsDialogWidget> {
//   TextEditingController amountController = TextEditingController();
//   final FocusNode _fieldNode = FocusNode();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   late StreamSubscription<bool> keyboardSubscription;

//   late BuildContext _context;

//     @override
//   void initState() {
//     var keyboardVisibilityController = KeyboardVisibilityController();
//     startNodeListener(keyboardVisibilityController);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     if (Platform.isIOS) {
//       keyboardSubscription.cancel();
//       _fieldNode.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _context = context;
//     return AlertDialog(
//       content: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextWidget(text: widget.body, textSize: Dimens.textMedium,),
//             UIHelper.verticalSpaceSmall,
//             SizedBox(
//               height: 50,
//               child: TextFieldWidget(
//                 inputType: TextInputType.number,
//                 inputAction: TextInputAction.done,
//                 focusNode: _fieldNode,
//                 textController: amountController,
//                 listOfFormaters: [FilteringTextInputFormatter.digitsOnly],
//                 validator: (text) => ValidationHelper.validateAmount(text),
//               ),
//             )
//           ],
//         ),
//       ),
//       backgroundColor: AppColors.colorBackground,
//       actions: <Widget>[
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: Text(widget.negativeBtnTitle),
//         ),
//         TextButton(
//           onPressed: _withdraw,
//           child: Text(widget.positiveBtnTitle),
//         ),
//       ],
//     );
//   }

//   void _withdraw() {
//     if (_formKey.currentState!.validate()) {
//       Navigator.of(_context).pop();
//       widget.onPositiveBtnPressed(amountController.text);
//     }
//   }
//     void startNodeListener(KeyboardVisibilityController keyboardVisibilityController) {
//      _fieldNode.addListener(
//       () {
//         if (_fieldNode.hasFocus) {
//           startkeyboardListener(keyboardVisibilityController);
//         } else {
//           if (Platform.isIOS) {
//             keyboardSubscription.cancel();
//             KeyboardOverlay.removeOverlay();
//           }
//         }
//       },
//     );
//   }

//     void startkeyboardListener(
//       KeyboardVisibilityController keyboardVisibilityController) {
//     if (Platform.isIOS) {
//       keyboardSubscription = keyboardVisibilityController.onChange.listen(
//         (visible) {
//           if (visible) {
//             KeyboardOverlay.showOverlay(context);
//           } else {
//             KeyboardOverlay.removeOverlay();
//           }
//         },
//       );
//     }
//   }
// }

class RadioGroup extends StatefulWidget {
  final ValueChanged onRadioChanged;
  final TextEditingController amountController;

  const RadioGroup(
      {Key? key, required this.onRadioChanged, required this.amountController})
      : super(key: key);

  @override
  State<RadioGroup> createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  WithdrawType type = WithdrawType.minimum;
  final FocusNode _fieldNode = FocusNode();
  late StreamSubscription<bool> keyboardSubscription;

  List<WithdrawChoice> listOfMethods = [
    WithdrawChoice(
      type: WithdrawType.minimum,
      name: loc.payoutDialogWithdrawTypeMinimum +
          "(${AppConstants.minimumWithdraw})",
    ),
    WithdrawChoice(
      type: WithdrawType.maximum,
      name: loc.payoutDialogWithdrawTypeMaximum,
    ),
    WithdrawChoice(
      type: WithdrawType.custom,
      name: loc.payoutDialogWithdrawTypeCustom,
    ),
  ];

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
    int maxAmount =
        context.read<DashBoardViewModel>().userSummary!.coinEarned!.round();
    return Column(
      children: [
        Column(
          children: listOfMethods
              .map((data) => RadioListTile<WithdrawType>(
                    title: data.type == WithdrawType.maximum
                        ? TextWidget(
                            text: data.name + "($maxAmount)",
                            textAlign: TextAlign.start,
                          )
                        : TextWidget(
                            text: data.name,
                            textAlign: TextAlign.start,
                          ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    groupValue: type,
                    tileColor: Colors.transparent,
                    dense: true,
                    value: data.type,
                    onChanged: (val) {
                      setState(() {
                        type = data.type;
                        widget.onRadioChanged(data.type);
                      });
                    },
                  ))
              .toList(),
        ),
        UIHelper.verticalSpaceSmall,
        TextFieldWidget(
            readOnly: type != WithdrawType.custom,
            inputType: TextInputType.number,
            inputAction: TextInputAction.done,
            textController: widget.amountController,
            listOfFormaters: [FilteringTextInputFormatter.digitsOnly],
            validator: (text) => ValidationHelper.validateAmount(text),
            prefix: const TextWidget(
              text: "\$",
              fontWeight: FontWeight.bold,
              textSize: Dimens.textMedium,
            ))
      ],
    );
  }

  void startNodeListener(
      KeyboardVisibilityController keyboardVisibilityController) {
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
