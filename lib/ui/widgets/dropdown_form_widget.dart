import 'package:flutter/material.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/widgets/text_widget.dart';

import '../../constants/dimens.dart';

class DropDownFormWidget extends StatelessWidget {
  final String defaultGender;
  final ValueChanged onChanged;

  const DropDownFormWidget({ Key? key, required this.defaultGender, required this.onChanged }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
          iconEnabledColor: AppColors.colorWhite,
          iconDisabledColor: AppColors.colorWhite,
          dropdownColor: AppColors.textFieldColor,
          iconSize: 30,
          decoration: InputDecoration(
          fillColor: AppColors.textFieldColor,
          filled: true,
          isDense: true,
          counterText: '',
          floatingLabelBehavior: FloatingLabelBehavior.never,
          errorStyle: const TextStyle(color: Colors.red),
          border: InputBorder.none,
          enabledBorder: enabledBorder,
          disabledBorder: disabledBorder,
          focusedBorder: focusedBorder,
          errorBorder: errorBorder,
          errorMaxLines: 3,
          prefixIcon: Container(
          width: Dimens.textFieldPrefixWidth,
          padding: const EdgeInsets.only(left: 10.0),
          alignment: Alignment.centerLeft,
          child: const Icon(Icons.perm_contact_cal, color: AppColors.colorWhite, size: 25,),
        ),
          focusedErrorBorder: focusedErrorBorder,),
            items: <String>[
              'Male',
              'Female'
            ]
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: TextWidget(text: value)
                    ))
                .toList(),
            onChanged: onChanged,
            value: defaultGender,
          );
  }
  //Styles
  OutlineInputBorder get enabledBorder => const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      );

  OutlineInputBorder get disabledBorder => const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      );

  OutlineInputBorder get focusedBorder => const OutlineInputBorder(
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