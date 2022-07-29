import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData? icon;
  final String? hint;
  final String label;

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
  final Function validator;
  final Function? onEditingComplete;
  final Widget? suffix;
  final Widget? prefix;
  final bool? enabled;
  final bool? readOnly;
  final VoidCallback? onTap;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _labelBar(),
          UIHelper.verticalSpaceSmall,
          TextFormField(
            controller: textController,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            onEditingComplete: () => onEditingComplete!(),
            onChanged: onChanged,
            autofocus: autoFocus,
            validator: (text) => validator(text),
            textInputAction: inputAction,
            obscureText: isObscure,
            maxLines: maxLines,
            onTap: onTap,
            enabled: enabled,
            readOnly: readOnly!,
            keyboardType: inputType,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
                hintText: hint ?? label,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: hintColor),
                counterText: '',
                icon: isIcon ? Icon(icon, color: iconColor) : null,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: hint,
                enabledBorder: enabledBorder,
                disabledBorder: disabledBorder,
                focusedBorder: focusedBorder,
                errorStyle: const TextStyle(color: Colors.red),
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
          )
        ],
      ),
    );
  }

  const TextFieldWidget({
    Key? key,
    this.icon,
    required this.textController,
    this.inputType,
    this.hint,
    required this.label,
    this.isObscure = false,
    this.isIcon = false,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
    required this.validator,
    this.onEditingComplete,
    this.suffix,
    this.prefix,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
  }) : super(key: key);

  Widget _labelBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          text: label,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  //Styles
  OutlineInputBorder get enabledBorder => const OutlineInputBorder(
        borderSide: BorderSide(
          width: Dimens.inputBoarderWidth,
          color: AppColors.colorHint,
        ),
      );

  OutlineInputBorder get disabledBorder => const OutlineInputBorder(
        borderSide: BorderSide(
          width: Dimens.inputBoarderWidth,
          color: AppColors.colorHint,
        ),
      );

  OutlineInputBorder get focusedBorder => const OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.colorPrimary,
          width: Dimens.inputBoarderWidth,
        ),
      );
  OutlineInputBorder get errorBorder => const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: Dimens.inputBoarderWidth,
        ),
      );

  OutlineInputBorder get focusedErrorBorder => const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      );
}