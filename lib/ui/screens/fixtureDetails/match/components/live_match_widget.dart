import 'package:leagx/models/dashboard/events.dart';
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
  final Events matchDetails; 
  LiveMatchWidget({
    Key? key, required this.matchDetails,
  }) : super(key: key);

  BuildContext? _context;
  List<Statistic> statistics =[];
  @override
  Widget build(BuildContext context) {
    _context = context;
    statistics = matchDetails.statistics;
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
            for(int i = 0; i < statistics.length; i++) DetailTile(
                title: statistics[i].type,
                tileColor: i % 2 ==0?AppColors.colorBackground : AppColors.textFieldColor,
                leftValue: statistics[i].home,
                rightValue: statistics[i].away,
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
