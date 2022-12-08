import 'package:leagx/models/dashboard/fixture.dart';
import 'package:leagx/models/live_match.dart';
import 'package:leagx/models/prediction.dart';
import 'package:leagx/ui/screens/fixtureDetails/components/stream_widget.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:leagx/ui/util/validation/validation_utils.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/view_models/fixture_view_model.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../constants/colors.dart';
import '../../../../../core/utility.dart';
import '../../../../widgets/divider_widget.dart';
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
  LiveMatch? _liveMatch;
  @override
  Widget build(BuildContext context) {
    _context = context;
    statistics = matchDetails.statistics;
    _liveMatch = context.read<FixtureDetailViewModel>().liveMatch;
    return Column(
      children: [
        matchDetails.matchLive == "1" 
        || Utility.isMatchOver(matchDetails.matchStatus!) ? Column(
          children: [
            const DividerWidget(),
            matchDetails.matchLive == "1" &&
            _liveMatch != null &&
            _liveMatch!.url.isNotEmpty
              ? StreamWidget(
              child: WebView(
                initialUrl: _liveMatch!.url,
                javascriptMode: JavascriptMode.unrestricted,
             )
          )
          : _liveMatch != null && _liveMatch!.url.isEmpty &&
                matchDetails.matchLive == "1" &&
                !Utility.isMatchOver(matchDetails.matchStatus!) 
            ? StreamWidget(
              child: Center(
                child: TextWidget(
                    text: loc.fixtureDetailsMsgStreamNotAvailable,
                    textAlign: TextAlign.center,
                    color: AppColors.colorYellow,),
              ),
            )
            : _liveMatch == null && matchDetails.matchLive == "1"
                ? StreamWidget(
                  child: Center(
                    child: TextWidget(
                        text: loc.fixtureDetailsMsgStreamError,
                          textAlign: TextAlign.center,
                          color: AppColors.colorYellow,
                    ),
                  ),
                )
                : const SizedBox.shrink(),
         ],
        )
        : const SizedBox.shrink(),
        if(matchDetails.statistics.isNotEmpty) IconContainer(
          height: SizeConfig.height * 7,
          title: loc.fixtureDetailsMatchTxtMatchDetails,
        ),
        Column(
          children:  [
            for(int i = 0; i < statistics.length; i++) DetailTile(
                title: statistics[i].type,
                tileColor: i % 2 == 0 ?AppColors.colorBackground : AppColors.textFieldColor,
                leftValue: statistics[i].home.isEmpty ? "0" : statistics[i].home,
                rightValue: statistics[i].away.isEmpty ? "0" : statistics[i].away,
              ),
              UIHelper.verticalSpaceLarge
          ],
        ),
        if(ValidationUtils.isValid(prediction)) MatchPredictionTile(
          homeTeamName: prediction!.match.firstTeamName,
          awayTeamName: prediction!.match.secondTeamName,
          homeScore: prediction!.firstTeamScore ?? 0,
          awayScore: prediction!.secondTeamScore ?? 0,
          isLocked: prediction!.expertId != null && Utility.isPredictionPending(prediction!.status),
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
