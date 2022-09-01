import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
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
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 44.0,
          decoration: BoxDecoration(
            gradient: AppColors.blackishGradient,
          ),
          child: Center(
            child: isTapped
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 8.0),
                    decoration: const BoxDecoration(
                      color: AppColors.colorBackground,
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                    ),
                    child: TextWidget(
                      text: title.toUpperCase(),
                      color: AppColors.colorWhite,
                      textSize: 14.0,
                    ),
                  )
                : TextWidget(
                    text: title.toUpperCase(),
                    color: AppColors.colorWhite.withOpacity(0.5),
                    textSize: 14.0,
                  ),
          ),
        ),
      ),
    );
  }
}
