import 'package:leagx/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:leagx/ui/util/locale/localization.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../../models/dashboard/events.dart';
import '../../../util/size/size_config.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../util/utility/date_utility.dart';
import '../../../widgets/icon_container.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/text_widget.dart';
import '../components/prediction_bottom_sheet.dart';
import '../../../widgets/score_chip.dart';
import '../components/team_vs_widget.dart';
import 'components/player_tile.dart';

class PlayersView extends StatelessWidget {
  final Events matchDetails;
  PlayersView({
    Key? key, required this.matchDetails,
  }) : super(key: key);

  BuildContext? _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                color: AppColors.textFieldColor,
                margin: const EdgeInsets.only(bottom: 10, top: 5),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TeamVsWidget(
                      teamName: matchDetails.matchHometeamName,
                      groupPosition: 'Top 1 group A',
                      image: matchDetails.teamHomeBadge,
                    ),
                    matchDetails.matchLive == "1"
                        ? Column(
                            children: [
                              ScoreChip(
                                firstScore: matchDetails.matchHometeamScore,
                                secondScore: matchDetails.matchAwayteamScore,
                              ),
                              UIHelper.verticalSpaceSmall,
                              const TextWidget(
                                text: "00:38:25",
                                color: AppColors.colorGrey,
                                textSize: Dimens.textSmall,
                              )
                            ],
                          )
                        : Column(
                            children: [
                              Image.asset(Assets.vs),
                              UIHelper.verticalSpaceSmall,
                              TextWidget(
                                text: DateUtility.getUiFormat(matchDetails.matchDate),
                                color: AppColors.colorGrey,
                                textSize: Dimens.textSmall,
                              ),
                              UIHelper.verticalSpaceSmall,
                              TextWidget(
                                text: matchDetails.matchTime,
                                color: AppColors.colorGrey,
                                textSize: Dimens.textSmall,
                              )
                            ],
                          ),
                    TeamVsWidget(
                      teamName: matchDetails.matchAwayteamName,
                      groupPosition: 'Top 2 Group B',
                      image: matchDetails.teamAwayBadge,
                    ),
                  ],
                )),
            IconContainer(
              height: SizeConfig.height * 7,
              title: loc.fixtureDetailsPlayersTxtTeamPlayers,
            ),
            Column(
              children: const [
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            SizedBox(
              width: SizeConfig.width * 90,
              child: MainButton(
                text: loc.fixtureDetailsPlayersBtnPredict,
                onPressed: _showSheet,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showSheet() {
    showModalBottomSheet(
        context: _context!,
        backgroundColor: AppColors.colorBackground,
        builder: (context) {
          return PredictionSheetWidget(
              onSubmit: (mycontext) =>
                  Navigator.pushNamed(context, Routes.chooseAnExpert));
        });
  }
}
