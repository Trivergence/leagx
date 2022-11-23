import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:leagx/models/dashboard/fixture.dart';
import 'package:leagx/models/prediction.dart';
import 'package:leagx/ui/util/app_dialogs/fancy_dialog.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:leagx/ui/util/validation/validation_utils.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:leagx/view_models/fixture_view_model.dart';
import 'package:leagx/ui/widgets/ai_widgets/ai_widgets.dart' as main_widget;
import 'package:provider/provider.dart';

import '../../../../../constants/assets.dart';
import '../../../../../constants/colors.dart';
import '../../../../../core/utility.dart';
import '../../../../../models/user_summary.dart';
import '../../../../widgets/icon_container.dart';
import '../../../../widgets/main_button.dart';
import '../../components/detail_tile.dart';
import '../../components/match_prediction_tile.dart';

// ignore: must_be_immutable
class LiveMatchWidget extends StatelessWidget {
  final Fixture matchDetails;
  final Prediction? prediction;
  LiveMatchWidget({
    Key? key, required this.matchDetails, required this.prediction,
  }) : super(key: key);

  BuildContext? _context;
  List<Statistic> statistics =[];
  @override
  Widget build(BuildContext context) {
    _context = context;
    statistics = matchDetails.statistics;
    return Column(
      children: [
        matchDetails.matchLive == "1" ? const main_widget.Animation():
        !Utility.isMatchOver(matchDetails.matchStatus!) ? Image.asset(
          Assets.stadiumImage,
          width: SizeConfig.width * 100,
          height: SizeConfig.height * 25,
          fit: BoxFit.cover,
        ) : const SizedBox.shrink(),
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
              UIHelper.verticalSpaceLarge
          ],
        ),
        if(ValidationUtils.isValid(prediction)) MatchPredictionTile(
          homeTeamName: prediction!.match.firstTeamName,
          awayTeamName: prediction!.match.secondTeamName,
          homeScore: prediction!.firstTeamScore ?? 0,
          awayScore: prediction!.secondTeamScore ?? 0,
        ),
        if(statistics.isEmpty) UIHelper.verticalSpaceXL,
        if (!ValidationUtils.isValid(prediction)) SizedBox(
            child: MainButton(text: loc.fixtureDetailsMatchBtnPredict, onPressed: _showSheet)),
        UIHelper.verticalSpaceMedium
      ],
    );
  }

  void _showSheet() {
    _context!
        .read<FixtureDetailViewModel>()
        .predictMatch(context: _context!, matchDetails: matchDetails);
  }
}
