import 'package:flutter/material.dart';
import 'package:leagx/core/sharedpref/sharedpref.dart';
import 'package:leagx/providers/localization_provider.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/text_widget.dart';

import '../../constants/colors.dart';

class AppBarChip extends StatelessWidget {
  final String totalValue;
  final String leading;

  const AppBarChip({
    Key? key,
    required this.totalValue,
    required this.leading,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2.0),
      child: Chip(
          side: const BorderSide(),
          labelPadding: const EdgeInsets.only(right: 4),
          backgroundColor: AppColors.textFieldColor,
          avatar: TextWidget(
            text: leading,
            textSize: 15,
            fontWeight: FontWeight.bold,
          ),
          label: Row(
            children: [
              const TextWidget(
                text: "x",
                textSize: 13,
              ),
              UIHelper.horizontalSpace(2),
              TextWidget(
                text: totalValue,
                textSize: 13,
              ),
            ],
          )),
    );
  }
  
  bool isArabic() {
    String? currentLanguage = preferenceHelper.currentLanguage;
    if(currentLanguage == "en") {
      return false;
    }
    return true;
  }
}
