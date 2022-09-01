import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData? iconData;
  final String? imageAsset;
  final Widget? trailing;
  final String text;
  final VoidCallback onTap;
  const SettingsTile(
      {Key? key,
      this.iconData,
      this.imageAsset,
      required this.onTap,
      required this.text,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: SizeConfig.width * 100,
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          gradient: AppColors.blackishGradient,
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Row(
          children: [
            iconData != null
                ? Icon(
                    iconData!,
                  )
                : imageAsset != null
                    ? Image.asset(imageAsset!)
                    : const SizedBox(),
            UIHelper.horizontalSpace(18.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: text,
                    textSize: Dimens.textSmall,
                  ),
                  trailing != null
                      ? trailing!
                      : const IconWidget(
                          iconData: Icons.arrow_forward_ios,
                          size: 16.0,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
