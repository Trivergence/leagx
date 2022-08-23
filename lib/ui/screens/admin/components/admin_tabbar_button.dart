import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AdminTabBarButton extends StatelessWidget {
  final bool isTapped;
  final VoidCallback onTap;
  final String title;
  const AdminTabBarButton(
      {Key? key,
      required this.title,
      required this.isTapped,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Flexible(
        child: Container(
          height: 44.0,
          decoration: BoxDecoration(
            gradient: AppColors.blackishGradient,
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: isTapped ? AppColors.colorBackground : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(14.0)),
              ),
              child: TextWidget(
                text: title.toUpperCase(),
                color: AppColors.colorWhite.withOpacity(0.5),
                textSize: 14.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
