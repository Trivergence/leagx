import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/text_widget.dart';

class TeamVsWidget extends StatelessWidget {
  final String teamName;
  final String groupPosition;
  final String image;
  const TeamVsWidget({
    Key? key, required this.teamName, required this.groupPosition, required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageWidget(
          imageUrl: image,),
        TextWidget(text: teamName),
        UIHelper.verticalSpaceSmall,
        TextWidget(text: groupPosition,
        textSize: Dimens.textXS,
        color: AppColors.colorGrey,),
      ]
    );
  }
}

