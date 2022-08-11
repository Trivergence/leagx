import 'package:flutter/material.dart';

import '../../../../../constants/assets.dart';
import '../../../../../constants/colors.dart';
import '../../../../util/ui/ui_helper.dart';
import '../../../../widgets/text_widget.dart';

class PlayerTile extends StatelessWidget {
  const PlayerTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: 
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Row(
        children: [
        Image.asset(Assets.icPlayerAvatar),
        UIHelper.horizontalSpaceSmall,
        TextWidget(text: "Messi", color: AppColors.colorYellow,),
      ],),
      Container(height: 3,width: 15,color: AppColors.colorWhite,),
      Row(
        children: [
        TextWidget(text: "Messi", color: AppColors.colorRed,),
        UIHelper.horizontalSpaceSmall,
        Image.asset(Assets.icPlayerAvatar),
      ],),
    ],)
    ,);
  }
}