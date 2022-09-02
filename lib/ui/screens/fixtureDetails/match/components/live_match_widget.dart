import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/util/locale/localization.dart';
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
          title: loc.fixtureDetailsMatchTxtMatchDetails,
        ),
        Column(
          children:  [
            DetailTile(
              title: loc.fixtureDetailsMatchTxtShooting,
              tileColor: AppColors.colorBackground,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(
              title: loc.fixtureDetailsMatchTxtAttacks,
              tileColor: AppColors.textFieldColor,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(
              title: '${loc.fixtureDetailsMatchTxtPossession} %',
              tileColor: AppColors.colorBackground,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(
              title: loc.fixtureDetailsMatchTxtRedCards,
              tileColor: AppColors.textFieldColor,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(
              title: loc.fixtureDetailsMatchTxtYellowCards,
              tileColor: AppColors.colorBackground,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(
              title: loc.fixtureDetailsMatchTxtCorners,
              tileColor: AppColors.textFieldColor,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(
              title: loc.fixtureDetailsMatchTxtOffsides,
              tileColor: AppColors.colorBackground,
              leftValue: 8,
              rightValue: 10,
            ),
            DetailTile(
              title: loc.fixtureDetailsMatchTxtPasses,
              tileColor: AppColors.textFieldColor,
              leftValue: 200,
              rightValue: 100,
            ),
          ],
        ),
        const MatchPredictionTile(),
        SizedBox(
            width: SizeConfig.width * 90,
            child: MainButton(text: loc.fixtureDetailsMatchBtnPredict, onPressed: _showSheet)),
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
