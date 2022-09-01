import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/font_family.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String time;
  const NotificationTile({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        gradient: AppColors.blackishGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RichText(
            text: TextSpan(
                text: "$firstText ",
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: FontFamily.raleway,
                  color: AppColors.colorWhite,
                ),
                children: [
                  TextSpan(
                    text: secondText,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.openSans,
                      fontSize: 14.0,
                      color: AppColors.colorYellow,
                    ),
                  ),
                ]),
          ),
          TextWidget(
            text: time,
            color: AppColors.colorWhite.withOpacity(0.5),
            textSize: 12.0,
          ),
        ],
      ),
    );
  }
}
