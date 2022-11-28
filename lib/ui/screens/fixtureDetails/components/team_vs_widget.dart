import 'package:flutter/material.dart';
import 'package:leagx/ui/util/size/size_config.dart';

import '../../../../constants/assets.dart';
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
          imageUrl: image,
          placeholder: Assets.icTeamAvatar
        ),
        SizedBox(
          width: SizeConfig.width * 20,
          height: 40,
          child: Center(child: TextWidget(text: teamName,
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
          ))),
        UIHelper.verticalSpaceSmall,
        TextWidget(text: groupPosition,
        textSize: Dimens.textXS,
        color: AppColors.colorGrey,),
      ]
    );
  }
}

