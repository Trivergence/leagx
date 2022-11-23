import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:leagx/ui/widgets/gradient/gradient_widget.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../util/size/size_config.dart';
import '../../../widgets/text_widget.dart';

class ScorePicker extends StatefulWidget {
  final Function(int) onChanged;
  final int initialScore;
  final bool isSelected;
  const ScorePicker({
    Key? key, required this.onChanged,required this.initialScore, required this.isSelected,
  }) : super(key: key);

  @override
  State<ScorePicker> createState() => _ScorePickerState();
}

class _ScorePickerState extends State<ScorePicker> {
  List<int> totalScores = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
  int currentIndex= 0;

  @override
  void initState() {
    currentIndex = widget.initialScore;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          //border: Border.all(color: AppColors.colorDarkGrey, width: 2),
          borderRadius: BorderRadius.circular(10),
          color: widget.isSelected ? AppColors.colorPink : AppColors.colorDarkGrey
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
          initialPage: widget.initialScore,
          onPageChanged: (value, _) {
            widget.onChanged(value);
            setState(() {
              currentIndex = value;
            });
          }
        ),
        
        items: [
          for(int i = 0; i < totalScores.length ; i++) Center(
            child: i == currentIndex ? TextWidget(text: totalScores[i].toString(),
                 textSize: Dimens.textMedium,
                 fontWeight: FontWeight.bold,
                 color: AppColors.colorPink,
                 )
            : TextWidget(
                text: totalScores[i].toString(),
                textSize: Dimens.textRegular,
                fontWeight: FontWeight.w400,
              ),
          )
        ]
        // totalScores.map((score) {
        //   return Builder(
        //     builder: (BuildContext context) {
        //       return TextWidget(text: score.toString(),
        //        textSize: Dimens.textRegular,
        //        fontWeight: FontWeight.w400,
        //        );
        //     },
        //   );
        // }).toList(),
        ),
      ),
    );
  }
}