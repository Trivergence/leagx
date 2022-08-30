import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/constants/font_family.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData? icon;
  final String? hint;
  final bool isObscure;
  final bool isIcon;
  final TextInputType? inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final String? Function(String?)? validator;
  final VoidCallback? onEditingComplete;
  final Widget? suffix;
  final Widget? prefix;
  final bool? enabled;
  final bool? readOnly;
  final VoidCallback? onTap;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      autofocus: autoFocus,
      validator:validator,
      textInputAction: inputAction,
      obscureText: isObscure,
      maxLines: maxLines,
      onTap: onTap,
      enabled: enabled,
      readOnly: readOnly!,
      keyboardType: inputType,
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(color: AppColors.colorWhite),
      decoration: InputDecoration(
          fillColor: AppColors.textFieldColor,
          filled: true,
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                color:hintColor,
                fontFamily: FontFamily.openSans,
                fontWeight: FontWeight.w400,
              ),
          counterText: '',
          icon: isIcon ? Icon(icon, color: iconColor) : null,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          // labelText: hint,
          // labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
          //       color: AppColors.colorWhite.withOpacity(0.3),
          //       fontFamily: FontFamily.openSans,
          //       fontWeight: FontWeight.w400,
          //     ),
          errorStyle: const TextStyle(color: Colors.red),
          border: InputBorder.none,
          enabledBorder: enabledBorder,
          disabledBorder: disabledBorder,
          focusedBorder: focusedBorder,
          errorBorder: errorBorder,
          errorMaxLines: 3,
          focusedErrorBorder: focusedErrorBorder,
          suffixIcon: suffix == null
              ? null
              : Container(
                  width: Dimens.textFieldSuffixWidth,
                  padding: const EdgeInsets.only(right: 10.0),
                  alignment: Alignment.center,
                  child: suffix,
                ),
          prefixIcon: prefix == null
              ? null
              : Container(
                  width: Dimens.textFieldPrefixWidth,
                  padding: const EdgeInsets.only(left: 10.0),
                  alignment: Alignment.centerLeft,
                  child: prefix,
                )),
    );
  }

  const TextFieldWidget({
    Key? key,
    this.icon,
    required this.textController,
    this.inputType,
    this.hint,
    this.isObscure = false,
    this.isIcon = false,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = AppColors.colorHint,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
    this.validator,
    this.onEditingComplete,
    this.suffix,
    this.prefix,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
  }) : super(key: key);

  //Styles
  OutlineInputBorder get enabledBorder => const OutlineInputBorder(
        // borderSide: BorderSide(
        //   width: Dimens.inputBoarderWidth,
        //   color: AppColors.colorHint,
        // ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      );

  OutlineInputBorder get disabledBorder => const OutlineInputBorder(
        // borderSide: BorderSide(
        //   width: Dimens.inputBoarderWidth,
        //   color: AppColors.colorHint,
        // ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      );

  OutlineInputBorder get focusedBorder => const OutlineInputBorder(
        // borderSide: BorderSide(
        //   color: AppColors.colorPrimary,
        //   width: Dimens.inputBoarderWidth,
        // ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      );
  OutlineInputBorder get errorBorder => const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: Dimens.inputBoarderWidth,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      );

  OutlineInputBorder get focusedErrorBorder => const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      );
}
