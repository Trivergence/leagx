import 'package:leagx/models/dashboard/events.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/fixture_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/assets.dart';
import '../../../../../constants/colors.dart';
import '../../../../widgets/icon_container.dart';
import '../../../../widgets/main_button.dart';
import '../../components/detail_tile.dart';
import '../../components/match_prediction_tile.dart';

class LiveMatchWidget extends StatelessWidget {
  final Fixture matchDetails; 
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
        if(matchDetails.statistics.isNotEmpty) IconContainer(
          height: SizeConfig.height * 7,
          title: loc.fixtureDetailsMatchTxtMatchDetails,
        ),
        Column(
          children:  [
            for(int i = 0; i < statistics.length; i++) DetailTile(
                title: statistics[i].type,
                tileColor: i % 2 == 0 ?AppColors.colorBackground : AppColors.textFieldColor,
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
    _context!.read<FixtureDetailViewModel>().showPredictionSheet(_context!, matchDetails);
    // showModalBottomSheet(
    //     context: _context!,
    //     backgroundColor: AppColors.colorBackground,
    //     builder: (context) {
    //       return PredictionSheetWidget(
    //           matchDetails: matchDetails,
    //           onSubmit: (context) =>
    //               Navigator.pushNamed(context, Routes.chooseAnExpert));
    //     });
  }
}
