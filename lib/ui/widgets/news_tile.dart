import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/dimens.dart';
import '../screens/dashboard/components/news/components/tick_widget.dart';
import '../screens/dashboard/components/news/news.dart';
import '../util/ui/ui_helper.dart';
import 'gradient_border_widget.dart';
import 'text_widget.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl;
  final String postedBy;
  final String when;
  final String desc;
  final bool isApproval;
  const NewsTile({
    Key? key, required this.imageUrl, required this.postedBy, required this.when,required this.desc, this.isApproval = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      margin: const EdgeInsets.only(right: 16.0, left: 16, bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        gradient: AppColors.blackishGradient,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Column(
          children: [
            GradientBorderWidget(
            width: 35.0,
            height: 35.0,
            isCircular: true,
            imageUrl: imageUrl,
            onPressed: () {},
            gradient: AppColors.orangishGradient,
          ),
          ],
        ),
        UIHelper.horizontalSpace(10),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                TextWidget(text: postedBy),
                TextWidget(text: when,
                textSize: Dimens.textXS,
                color: isApproval == true ? AppColors.colorCyan : AppColors.colorYellow,)
              ],),
              UIHelper.verticalSpace(11),
              Row(
                children: [
                Expanded(
                  child: TextWidget(
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w300,
                  textSize: Dimens.textXS,
                  color: AppColors.colorWhite.withOpacity(0.7),
                  text: desc)),
                if (isApproval) UIHelper.horizontalSpace(9),
                if (isApproval) const TickWidget(isApproved: false)
              ],)
            ],
          ),
        )
      ],),
    );
  }
}