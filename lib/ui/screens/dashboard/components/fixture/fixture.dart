import 'package:leagx/constants/colors.dart';
import 'package:leagx/models/subscribed_league.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/dashboard/components/home/home.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/screens/dashboard/components/fixture_widget.dart';
import 'package:leagx/ui/widgets/gradient/gradient_border_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/dashboard/fixture.dart';
import '../../../../../models/match_args.dart';
import '../../../../../view_models/dashboard_view_model.dart';
import '../../../../widgets/placeholder_tile.dart';

class FixtureScreen extends StatelessWidget {
  FixtureScreen({Key? key}) : super(key: key);
  List<Fixture> subscribedMatches = [];
  List<SubscribedLeague> subscribedLeagues = [];

  @override
  Widget build(BuildContext context) {
    DashBoardViewModel dashBoardViewModel = context.read<DashBoardViewModel>();
    subscribedMatches = dashBoardViewModel.subscribedMatches;
    subscribedLeagues = dashBoardViewModel.subscribedLeagues;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: AppColors.blackishGradient,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: loc.dashboardFixtureTxtLeagues,
                fontWeight: FontWeight.w700,
              ),
              UIHelper.verticalSpaceSmall,
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right:18.0),
                    child: GradientBorderWidget(
                      width: 40.0,
                      height: 40.0,
                      isCircular: true,
                      iconData: Icons.add,
                      onPressed: () =>
                          Navigator.of(context).pushNamed(Routes.chooseLeague),
                    ),
                  ),
                  if(subscribedLeagues.isNotEmpty) Expanded(
                    child: SizedBox(
                      height: 40.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: subscribedLeagues.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: GradientBorderWidget(
                              width: 40.0,
                              height: 40.0,
                              padding: const EdgeInsets.all(5.0),
                              isCircular: true,
                              imageUrl: subscribedLeagues[index].logo,
                              onPressed: () {},
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                ],
              ),
            ],
          ),
        ),
        subscribedMatches.isNotEmpty ? Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 TextWidget(
                  text: loc.dashboardFixtureTxtUpcomingMatches,
                  fontWeight: FontWeight.w700,
                ),
                UIHelper.verticalSpaceSmall,
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: subscribedMatches.length,
                    itemBuilder: (context, index) {
                    Fixture match = subscribedMatches[index];
                    return FixtureWidget(
                      leagueName: match.leagueName,
                      teamOneFlag: match.teamHomeBadge,
                      teamOneName: match.matchHometeamName,
                      teamTwoFlag: match.teamAwayBadge,
                      teamTwoName: match.matchAwayteamName,
                      scheduledTime: match.matchTime,
                      scheduledDate: match.matchDate,
                      isLive: match.matchLive == "1",
                      matchStatus: match.matchStatus,
                      teamOneScore: match.matchHometeamScore,
                      teamTwoScore: match.matchAwayteamScore,
                      onTap: () => Navigator.pushNamed(context, Routes.fixtureDetails,
                      arguments: MatchArgs(
                          matchId: match.matchId,
                          liveStatus: match.matchLive == "1",
                          leagueName: match.leagueName,
                        )
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ) : Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0),
          child: PlaceHolderTile(height: 80, msgText: loc.dashboardFixtureTxtEmptyList),
        ),
      ],
    );
  }
}
