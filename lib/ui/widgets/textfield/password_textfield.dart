import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/validation/validation_utils.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputAction inputAction;
  final String? Function(String?)? validator;
  const PasswordTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.inputAction=TextInputAction.done, this.validator,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      textController: widget.controller,
      isObscure: isObscure,
      hint: widget.hint,
      inputAction: widget.inputAction,
      validator: widget.validator,
      prefix: const IconWidget(
        iconData: Icons.lock_outline,
      ),
      suffix: GestureDetector(
        child: IconWidget(
          iconData: isObscure
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
        onTap: () {
          setState(() => isObscure = !isObscure);
        },
      ),
    );
  }
}
