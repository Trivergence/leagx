import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:flutter/material.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/dimens.dart';
import '../../../../../widgets/gradient_border_widget.dart';
import '../../../../../widgets/text_widget.dart';

class ExpandedLeaderTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int numberOfPrediciton;
  final String successRate;
  const ExpandedLeaderTile({
    Key? key, required this.imageUrl, required this.title, required this.numberOfPrediciton,required this.successRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
        gradient: AppColors.blackishGradient,
      ),
      child: Center(
        child: Column(
          children: [
             Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                top: -10,
                //left: 10,
                child: Image.asset(Assets.icSmallCrown)),
              GradientBorderWidget(
                width: 60.0,
                height: 60.0,
                isCircular: true,
                imageUrl: imageUrl,
                onPressed: () {},
                gradient: AppColors.orangishGradient,
              ),
              
             ],),
             TextWidget(text: title, fontWeight: FontWeight.w600,),
             TextWidget(text: "$numberOfPrediciton predictions", textSize: Dimens.textSmall, color: AppColors.colorWhite.withOpacity(0.5),),
             TextWidget(text: "Win $successRate%", color: AppColors.colorGreen,textSize: Dimens.textSmall),

        ],
     ),
      ),
    );
  }
}
