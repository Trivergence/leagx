import 'package:flutter/material.dart';
import 'package:leagx/core/utility.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:provider/provider.dart';

import '../../core/network/internet_info.dart';
import '../../models/dashboard/fixture.dart';
import '../../models/match_args.dart';
import '../../routes/routes.dart';
import '../../view_models/dashboard_view_model.dart';
import '../util/locale/localization.dart';
import 'dashboard/components/fixture_widget.dart';

class UpcomingMatches extends StatelessWidget {
  UpcomingMatches({ Key? key }) : super(key: key);
  List<Fixture> upcomingMatches = [];
  @override
  Widget build(BuildContext context) {
    DashBoardViewModel dashBoardViewModel = context.read<DashBoardViewModel>();
    upcomingMatches = dashBoardViewModel.subscribedMatches;
    return Scaffold(
      appBar: AppBarWidget(title: loc.upcomingMatchesTitle),
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
            scheduledDate: match.matchDate,
            isLive: match.matchLive == "1",
            isOver: Utility.isMatchOver(match.matchStatus!),
            matchStatus: match.matchStatus,
            teamOneScore: match.matchHometeamScore,
            teamTwoScore: match.matchAwayteamScore,
            onTap: () async {
              bool isConnected = await InternetInfo.isConnected();
              if (isConnected) {
                Navigator.pushNamed(context, Routes.fixtureDetails,
                  arguments: MatchArgs(
                    matchId: match.matchId,
                    leagueName: match.leagueName,
                ));
              }
            }
          );
        }),
      ));
  }
}