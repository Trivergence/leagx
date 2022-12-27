import 'package:leagx/core/utility.dart';
import 'package:leagx/models/dashboard/fixture.dart';
import 'package:leagx/models/prediction.dart';
import 'package:flutter/material.dart';

import '../components/fixture_vs_widget.dart';
import 'components/live_match_widget.dart';
import 'components/offline_match_widget.dart';

class MatchView extends StatelessWidget {
  final Fixture matchDetails;
  final Prediction? prediction;

  const MatchView({
    Key? key,
    required this.matchDetails,
    required this.prediction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            FixtureVsWidget(matchDetails: matchDetails),
            // if(!Utility.isMatchOver(matchDetails.matchStatus!)) IconContainer(
            //   height: SizeConfig.height * 7,
            //   title: loc.faqsTxtFrequentlyAskedQuestions,
            // ),
            matchDetails.matchLive == "1" ||
                    Utility.isMatchOver(matchDetails.matchStatus!)
                ? LiveMatchWidget(
                    matchDetails: matchDetails,
                    prediction: prediction,
                  )
                : OfflineMatchWidget(
                    matchDetails: matchDetails,
                    prediction: prediction,
                  )
          ],
        ),
      ),
    );
  }
}
