import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/assets.dart';
import '../../../../../constants/colors.dart';
import '../../../../widgets/icon_container.dart';
import '../../../../widgets/main_button.dart';
import '../../components/detail_tile.dart';
import '../../components/match_prediction_tile.dart';
import '../../components/prediction_bottom_sheet.dart';

class LiveMatchWidget extends StatelessWidget {
  LiveMatchWidget({
    Key? key,
  }) : super(key: key);

  BuildContext? _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Column(
      children: [
        Image.asset(
          Assets.stadiumImage,
          width: SizeConfig.width * 100,
          height: SizeConfig.height * 25,
          fit: BoxFit.cover,
        ),
        IconContainer(
          height: SizeConfig.height * 7,
          title: "Match Details",
        ),
        Column(
          children: const [
            DetailTile(
              title: 'Shooting',
              tileColor: AppColors.colorBackground,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(
              title: 'Attacks',
              tileColor: AppColors.textFieldColor,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(
              title: 'Possession %',
              tileColor: AppColors.colorBackground,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(
              title: 'Red cards',
              tileColor: AppColors.textFieldColor,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(
              title: 'Yellow cards',
              tileColor: AppColors.colorBackground,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(
              title: 'Corners',
              tileColor: AppColors.textFieldColor,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(
              title: 'Offsides',
              tileColor: AppColors.colorBackground,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(
              title: 'Passes',
              tileColor: AppColors.textFieldColor,
              leftValue: 200,
              rightValue: 100,
            ),
          ],
        ),
        const MatchPredictionTile(),
        SizedBox(
            width: SizeConfig.width * 90,
            child: MainButton(text: "Predict", onPressed: _showSheet)),
        UIHelper.verticalSpaceMedium
      ],
    );
  }

  void _showSheet() {
    showModalBottomSheet(
        context: _context!,
        backgroundColor: AppColors.colorBackground,
        builder: (context) {
          return PredictionSheetWidget(
              onSubmit: (context) =>
                  Navigator.pushNamed(context, Routes.chooseAnExpert));
        });
  }
}
