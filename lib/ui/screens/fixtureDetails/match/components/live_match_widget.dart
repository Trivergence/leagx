import 'package:bailbooks_defendant/ui/util/size/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/assets.dart';
import '../../../../../constants/colors.dart';
import '../../../../widgets/icon_container.dart';
import '../../components/detail_tile.dart';
import '../../components/match_prediction_tile.dart';

class LiveMatchWidget extends StatelessWidget {
  const LiveMatchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Assets.stadiumImage,
          width: SizeConfig.width * 100,
          height: SizeConfig.height * 25,
          fit: BoxFit.cover,),
        IconContainer(height: SizeConfig.height * 7,
          title: "Match Details",),
        Column(
          children: const [
              DetailTile(title: 'Shooting',
              tileColor: AppColors.colorBackground,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(title: 'Attacks',
              tileColor: AppColors.textFieldColor,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(title: 'Possession %',
              tileColor: AppColors.colorBackground,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(title: 'Red cards',
              tileColor: AppColors.textFieldColor,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(title: 'Yellow cards',
              tileColor: AppColors.colorBackground,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(title: 'Corners',
              tileColor: AppColors.textFieldColor,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(title: 'Offsides',
              tileColor: AppColors.colorBackground,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(title: 'Passes',
              tileColor: AppColors.textFieldColor,
              leftValue: 200,
              rightValue: 100,
            ),
          ],
        ),
        MatchPredictionTile(),
      ],
    );
  }
}