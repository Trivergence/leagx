import 'package:flutter/material.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:provider/provider.dart';

import '../../models/dashboard/events.dart';
import '../../models/match_args.dart';
import '../../routes/routes.dart';
import '../../view_models/dashboard_view_model.dart';
import 'dashboard/components/fixture_widget.dart';

class UpcomingMatches extends StatelessWidget {
  UpcomingMatches({ Key? key }) : super(key: key);
  List<Events> upcomingMatches = [];
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
          return FixtureWidget(
            leagueName: upcomingMatches[index].leagueName,
            teamOneFlag: upcomingMatches[index].teamHomeBadge,
            teamOneName: upcomingMatches[index].matchHometeamName,
            teamTwoFlag: upcomingMatches[index].teamAwayBadge,
            teamTwoName: upcomingMatches[index].matchAwayteamName,
            scheduledTime: upcomingMatches[index].matchTime,
            isLive: upcomingMatches[index].matchLive == "1",
            teamOneScore: upcomingMatches[index].matchHometeamScore,
            teamTwoScore: upcomingMatches[index].matchAwayteamScore,
            onTap: () => Navigator.pushNamed(context, Routes.fixtureDetails,
                arguments: MatchArgs(
                  matchId: upcomingMatches[index].matchId,
                  liveStatus: upcomingMatches[index].matchLive == "1",
                  leagueName: upcomingMatches[index].leagueName,
                )),
          );
        }),
      ));
  }
}