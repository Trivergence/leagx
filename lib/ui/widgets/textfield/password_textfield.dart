import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/widgets/icon_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  const PasswordTextField(
      {Key? key, required this.controller, required this.hint})
      : super(key: key);

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
      validator: () {},
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
