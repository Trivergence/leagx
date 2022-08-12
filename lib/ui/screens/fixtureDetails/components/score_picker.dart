import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../util/size/size_config.dart';
import '../../../widgets/text_widget.dart';

class ScorePicker extends StatelessWidget {
  final Function(String) onChanged;
  final int initialScore;
  final bool isSelected;
  ScorePicker({
    Key? key, required this.onChanged,required this.initialScore, required this.isSelected,
  }) : super(key: key);

  List totalScores = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          //border: Border.all(color: AppColors.colorDarkGrey, width: 2),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.colorDarkGrey,
          gradient: isSelected ? AppColors.pinkishGradient : null
        ),
      child: Container(
        height: SizeConfig.height * 5,
        width: SizeConfig.width * 26,
        decoration: BoxDecoration(
          //border: Border.all(color: AppColors.colorDarkGrey, width: 2),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.colorBackground,
        ),
        child: CarouselSlider(
        options: CarouselOptions(
          height: 40,
          viewportFraction: 0.33,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          initialPage: initialScore,
          onPageChanged: (value, _) {
            onChanged(value.toString());
          }
        ),
        items: totalScores.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Center(
                child: TextWidget(text: i.toString(),
                 textSize: Dimens.textRegular,
                 fontWeight: FontWeight.w400,
                 ),
              );
            },
          );
        }).toList(),
        ),
      ),
    );
  }
}