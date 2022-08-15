import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/constants/font_family.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/icon_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final IconData? icon;
  final String? hint;
  final bool isIcon;
  final TextInputType? inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color iconColor;
  final ValueChanged? onFieldSubmitted;
  final TextInputAction? inputAction;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: inputAction,
      onTap: onTap,
      keyboardType: inputType,
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(color: AppColors.colorWhite),
      decoration: InputDecoration(
          contentPadding: padding,
          fillColor: AppColors.colorBlack.withOpacity(0.2),
          filled: true,
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: AppColors.colorWhite,
                fontFamily: FontFamily.openSans,
                fontWeight: FontWeight.w400,
              ),
          counterText: '',
          icon: isIcon ? Icon(icon, color: iconColor) : null,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: hint,
          labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: AppColors.colorWhite,
                fontFamily: FontFamily.openSans,
                fontWeight: FontWeight.w400,
              ),
          errorStyle: const TextStyle(color: Colors.red),
          enabledBorder: enabledBorder,
          disabledBorder: disabledBorder,
          focusedBorder: focusedBorder,
          errorBorder: errorBorder,
          suffixIcon: Container(
                  width: Dimens.textFieldSuffixWidth,
                  alignment: Alignment.center,
                  child: const Icon(Icons.search,color: AppColors.colorWhite,),
                ),
          errorMaxLines: 3,
          focusedErrorBorder: focusedErrorBorder,
          ),
          
    );
  }

  const SearchTextField({
    Key? key,
    this.icon,
    required this.textController,
    this.inputType,
    this.hint,
    this.isIcon = false,
    this.padding = const EdgeInsets.only(left: 20),
    this.iconColor = Colors.grey,
    this.onFieldSubmitted,
    this.inputAction,
    this.onTap,
  }) : super(key: key);

  //Styles
  OutlineInputBorder get enabledBorder =>  OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.colorWhite.withOpacity(0.1),
          width: 1.5
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      );

  OutlineInputBorder get disabledBorder => OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.colorWhite.withOpacity(0.1),
          width: 1.5
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      );

  OutlineInputBorder get focusedBorder => OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.colorWhite.withOpacity(0.1),
          width: 1.5
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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