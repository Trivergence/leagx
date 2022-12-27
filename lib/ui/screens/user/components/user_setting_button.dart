import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class UserSettingButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const UserSettingButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56.0,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.colorWhite.withOpacity(0.17),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: title,
              textSize: 16.0,
            ),
            const IconWidget(
              iconData: Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    );
  }
}
