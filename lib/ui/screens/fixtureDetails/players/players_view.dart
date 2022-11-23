import 'package:leagx/models/prediction.dart';
import 'package:flutter/material.dart';
import 'package:leagx/ui/screens/fixtureDetails/players/components/player_tile.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/view_models/fixture_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors.dart';
import '../../../../models/dashboard/fixture.dart';
import '../../../../models/players.dart';
import '../../../util/size/size_config.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../util/validation/validation_utils.dart';
import '../../../widgets/icon_container.dart';
import '../../../widgets/main_button.dart';
import '../components/fixture_vs_widget.dart';
import '../components/match_prediction_tile.dart';

// ignore: must_be_immutable
class PlayersView extends StatelessWidget {
  final Fixture matchDetails;
  final Prediction? prediction;
  PlayersView({
    Key? key, required this.matchDetails, required this.prediction,
  }) : super(key: key);

  BuildContext? _context;
  late List<Player> awayPlayer;
  late List<Player> homePlayer;
  late FixtureDetailViewModel _fixtureModel;

  @override
  Widget build(BuildContext context) {
    _fixtureModel = context.watch<FixtureDetailViewModel>();
    awayPlayer = _fixtureModel.awayTeamPlayers;
    homePlayer = _fixtureModel.homeTeamPlayers;
    _context = context;
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          children: [
            FixtureVsWidget(matchDetails: matchDetails),
            if (awayPlayer.isNotEmpty && homePlayer.isNotEmpty) Column(
              children: [
                IconContainer(
                  height: SizeConfig.height * 7,
                  title: loc.fixtureDetailsPlayersTxtTeamPlayers,
                ),
                Column(
                  children:  [
                    for(int i = 0; i < getLength(); i++) PlayerTile(
                      tileColor: i % 2 == 0
                              ? AppColors.colorBackground
                              : AppColors.textFieldColor,
                      playerOneName: homePlayer[i].playerName,
                      playerOneImg: homePlayer[i].playerImage,
                      playerTwoName: awayPlayer[i].playerName,
                      playerTwoImg: awayPlayer[i].playerImage)
                  ],
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            if(ValidationUtils.isValid(prediction)) MatchPredictionTile(
              homeTeamName: prediction!.match.firstTeamName,
              awayTeamName: prediction!.match.secondTeamName,
              homeScore: prediction!.firstTeamScore ?? 0,
              awayScore: prediction!.secondTeamScore ?? 0,
            ),
            if (!ValidationUtils.isValid(prediction)) MainButton(text: loc.fixtureDetailsMatchBtnPredict, onPressed: _showSheet),
          ],
        ),
      ),
    );
  }

  void _showSheet() {
   _fixtureModel.predictMatch(context: _context!, matchDetails: matchDetails);
  }

  int getLength() {
    if(homePlayer.length <= awayPlayer.length) {
      return homePlayer.length >= 11 ? 11 : homePlayer.length;
    } else {
      return awayPlayer.length >= 11 ? 11 : awayPlayer.length;
    }
  }
}
