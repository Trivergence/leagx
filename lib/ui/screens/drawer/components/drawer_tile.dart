import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData? icon;
  final String? imageAsset;

  final String title;
  final VoidCallback onTap;
  const DrawerTile({
    Key? key,
    this.icon,
    this.imageAsset,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: IconWidget(
        iconData: icon,
        imageAsset: imageAsset,
        color: AppColors.colorWhite.withOpacity(0.70),
      ),
      title: TextWidget(
        text: title,
        color: AppColors.colorWhite.withOpacity(0.70),
        textAlign: TextAlign.start,
      ),
    );
  }
}
