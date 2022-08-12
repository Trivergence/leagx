import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_border_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class LeaderScreen extends StatelessWidget {
  const LeaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 24.0),
      child: Row(
        children: [
          GradientBorderWidget(
            width: 20.0,
            height: 20.0,
            isCircular: true,
            gradient: AppColors.grayishGradient,
            text: '2',
            textSize: 12.0,
            onPressed: () {},
          ),
          UIHelper.horizontalSpace(15.0),
          GradientBorderWidget(
            width: 44.0,
            height: 44.0,
            isCircular: true,
            imageUrl: 'https://i.pravatar.cc/300',
            onPressed: () {},
            gradient: AppColors.orangishGradient,
          ),
          UIHelper.horizontalSpace(15.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const[
                  TextWidget(text:'David J.P'),
                  TextWidget(text:'99.5%', color: AppColors.colorGreen,textSize: 18.0,),
                ],
              ),
              UIHelper.verticalSpace(10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  TextWidget(text:'20 predictions',textSize: 14.0,color: AppColors.colorWhite.withOpacity(0.5),),
                  const TextWidget(text:'99.5%', textSize: 18.0,),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
