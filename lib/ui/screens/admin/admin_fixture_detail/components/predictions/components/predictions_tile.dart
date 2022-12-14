import 'package:flutter/material.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/gradient/gradient_border_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';

class PredictionsTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String teamOneDetails;
  final String teamTwoDetails;

  const PredictionsTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.teamOneDetails,
    required this.teamTwoDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        gradient: AppColors.blackishGradient,
      ),
      child: Row(
        children: [
          GradientBorderWidget(
            width: 44.0,
            height: 44.0,
            isCircular: true,
            imageUrl: imageUrl,
            onPressed: () {},
            gradient: AppColors.orangishGradient,
            isBorderSolid: true,
          ),
          UIHelper.horizontalSpace(15.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(text: title),
                Column(
                  children: [
                    TextWidget(
                      text: teamOneDetails.toUpperCase(),
                      color: AppColors.colorCyan,
                      textSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                    TextWidget(
                      text: teamTwoDetails.toUpperCase(),
                      color: AppColors.colorYellow,
                      textSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
