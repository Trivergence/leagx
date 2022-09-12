import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const LanguageTile({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: SizeConfig.width * 100,
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          gradient: AppColors.blackishGradient,
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: TextWidget(
          text: text,
          textSize: Dimens.textSmall,
        ),
      ),
    );
  }
}
