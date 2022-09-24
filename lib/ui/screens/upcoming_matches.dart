import 'package:flutter/material.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:provider/provider.dart';

import '../../models/dashboard/fixture.dart';
import '../../models/match_args.dart';
import '../../routes/routes.dart';
import '../../view_models/dashboard_view_model.dart';
import 'dashboard/components/fixture_widget.dart';

class UpcomingMatches extends StatelessWidget {
  UpcomingMatches({ Key? key }) : super(key: key);
  List<Fixture> upcomingMatches = [];
  @override
  Widget build(BuildContext context) {
    DashBoardViewModel dashBoardViewModel = context.read<DashBoardViewModel>();
    upcomingMatches = dashBoardViewModel.upcomingMatches;
    return Scaffold(
      appBar: AppBarWidget(title: "Upcoming Matches"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView.builder(
        shrinkWrap: true,
        itemCount: upcomingMatches.length,
        itemBuilder: (context, index) {
          Fixture match = upcomingMatches[index];
          return FixtureWidget(
            leagueName: match.leagueName,
            teamOneFlag: match.teamHomeBadge,
            teamOneName: match.matchHometeamName,
            teamTwoFlag: match.teamAwayBadge,
            teamTwoName: match.matchAwayteamName,
            scheduledTime: match.matchTime,
            isLive: match.matchLive == "1",
            matchStatus: match.matchStatus,
            teamOneScore: match.matchHometeamScore,
            teamTwoScore: match.matchAwayteamScore,
            onTap: () => Navigator.pushNamed(context, Routes.fixtureDetails,
                arguments: MatchArgs(
                  matchId: match.matchId,
                  liveStatus: match.matchLive == "1",
                  leagueName: match.leagueName,
            )),
          );
        }),
      ));
  }
}