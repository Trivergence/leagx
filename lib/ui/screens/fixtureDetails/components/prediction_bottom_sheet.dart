import 'package:flutter/material.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:leagx/view_models/fixture_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors.dart';
import '../../../../models/dashboard/events.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/gradient/gradient_border_button.dart';
import '../../../widgets/gradient/gradient_widget.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/text_widget.dart';
import 'check_box_widget.dart';
import 'score_picker.dart';

class PredictionSheetWidget extends StatefulWidget {
  final Function(BuildContext) onSubmit;
  final Fixture? matchDetails;
  const PredictionSheetWidget({
    Key? key,
    required this.onSubmit, this.matchDetails,
  }) : super(key: key);

  @override
  State<PredictionSheetWidget> createState() => _PredictionSheetWidgetState();
}

class _PredictionSheetWidgetState extends State<PredictionSheetWidget> {
  BuildContext? _context;
  bool firstSelected = false;
  bool secondSelected = false;
  bool isPublic = false;
  int awayScore = 2;
  int homeScore = 1;
  late int leagueId;
  @override
  Widget build(BuildContext context) {
    _context = context;
    leagueId = getMatchId();
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 26, top: 22),
            width: 30,
            height: 3,
            color: AppColors.colorWhite.withOpacity(0.4),
          ),
          GradientWidget(
            child: TextWidget(
              text: loc.fixtureDetailsTxtPredictMatchResult,
            ),
          ),
          UIHelper.verticalSpace(34),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                TextWidget(
                text: widget.matchDetails!.matchHometeamName,
                fontWeight: FontWeight.w600,
              ),
              ScorePicker(
                initialScore: 1,
                isSelected: firstSelected,
                onChanged: (score) {
                  setState(() {
                    secondSelected = false;
                    firstSelected = true;
                    homeScore = score;
                  });
                },
              )
            ],
          ),
          UIHelper.verticalSpace(22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                TextWidget(
                text: widget.matchDetails!.matchAwayteamName,
                fontWeight: FontWeight.w600,
              ),
              ScorePicker(
                initialScore: 2,
                isSelected: secondSelected,
                onChanged: (score) {
                  setState(() {
                    secondSelected = true;
                    firstSelected = false;
                    awayScore = score;
                  });
                },
              )
            ],
          ),
          UIHelper.verticalSpace(20),
          Row(
            children: [
              CheckBoxWidget(
                onPressed: (isChecked) => isPublic = isChecked,
              ),
              UIHelper.horizontalSpace(13),
              TextWidget(
                text: loc.fixtureDetailsTxtMakeMyPredictPublic,
              ),
            ],
          ),
          UIHelper.verticalSpace(30),
          MainButton(
            text: loc.fixtureDetailsBtnSubmit,
            onPressed: _predictMatch,
          ),
          UIHelper.verticalSpace(20),
          GradientBorderButton(
            text: loc.fixtureDetailsBtnExpertAdvise,
            onPressed: () => widget.onSubmit(context),
          ),
        ],
      ),
    );
  }

  void _predictMatch() {
    _context!.read<FixtureDetailViewModel>().savePrediction(
      context: _context!,
      matchId: int.parse(widget.matchDetails!.matchId),
      leagueId: leagueId,
      homeScore: homeScore,
      awayScore: awayScore,
      awayTeamName: widget.matchDetails!.matchAwayteamName,
      homeTeamName: widget.matchDetails!.matchHometeamName,
      isPublic: isPublic
    );
  }

  int getMatchId() {
     return context.read<DashBoardViewModel>()
    .subscribedLeagues
    .where((league) => league.externalLeagueId.toString() == widget.matchDetails!.leagueId)
    .first
    .id;
  }
}
