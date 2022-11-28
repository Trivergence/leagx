import 'package:flutter/material.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/widgets/text_widget.dart';

import '../../constants/dimens.dart';

// ignore: must_be_immutable
class DropDownFormWidget extends StatelessWidget {
  final String? defaultGender;
  final ValueChanged onChanged;
  final String? Function(String?)? validator;

  DropDownFormWidget({ Key? key, required this.defaultGender, required this.onChanged, this.validator }) : super(key: key);
  late Map<String,String> listOfGender;

  @override
  Widget build(BuildContext context) {
    initializeData();
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
          hintText: loc.profileProfileInfoHintGender,
          hintStyle: const TextStyle(color: AppColors.colorWhite, fontSize: Dimens.textRegular, fontWeight: FontWeight.normal),
          prefixIcon: Container(
          width: Dimens.textFieldPrefixWidth,
          padding: const EdgeInsets.only(left: 10.0),
          alignment: Alignment.centerLeft,
          child: const Icon(Icons.perm_contact_cal, color: AppColors.colorWhite, size: 25,),
        ),
          focusedErrorBorder: focusedErrorBorder,),
            items: [
              DropdownMenuItem<String>(
                      value: "male",
                      child: TextWidget(text: listOfGender["male"]!)
                    ),
              DropdownMenuItem<String>(
                      value: "female",
                      child: TextWidget(text: listOfGender["female"]!)
                    )
            ],
            onChanged: onChanged,
            validator: validator,
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

  void initializeData() {
    listOfGender = {
      "male": loc.profileProfileInfoMale,
      "female": loc.profileProfileInfoFemale,
    };
  }
}