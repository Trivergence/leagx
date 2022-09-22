import 'package:leagx/constants/colors.dart';
import 'package:leagx/models/match_args.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/dashboard/components/home/components/analytics_widget.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/ui/screens/dashboard/components/fixture_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../models/dashboard/events.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<Events> upcomingMatches = [];

  @override
  Widget build(BuildContext context) {
    upcomingMatches = context.read<DashBoardViewModel>().upcomingMatches;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
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
                  text: loc.dashboardHomeTxtLeaders,
                  fontWeight: FontWeight.w700,
                ),
                UIHelper.verticalSpaceSmall,
                // SizedBox(
                //   height: 40.0,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 10,
                //     itemBuilder: (context, index) {
                //       return Padding(
                //         padding: const EdgeInsets.only(right: 20.0),
                //         child: GradientBorderWidget(
                //           width: 40.0,
                //           height: 40.0,
                //           isCircular: true,
                //           imageUrl: Strings().placeHolderUrl,
                //           onPressed: () {},
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AnalyticsWidget(
                  firstLabel: 'Predictions',
                  firstValue: '5.5',
                  secondLabel: 'Winning Ratio',
                  secondValue: '70.1',
                  thirdLabel: 'Earned Coin',
                  thirdValue: '400',
                ),
                 TextWidget(
                  text: loc.dashboardHomeTxtUpcomingMatches,
                  fontWeight: FontWeight.w700,
                ),
                UIHelper.verticalSpaceSmall,
                Column(
                  children: [
                    for(int i = 0; i < 3; i++) FixtureWidget(
                        leagueName: upcomingMatches[i].leagueName,
                        teamOneFlag: upcomingMatches[i].teamHomeBadge,
                        teamOneName: upcomingMatches[i].matchHometeamName,
                        teamTwoFlag: upcomingMatches[i].teamAwayBadge,
                        teamTwoName: upcomingMatches[i].matchAwayteamName,
                        scheduledTime: upcomingMatches[i].matchTime,
                        onTap: () => Navigator.pushNamed(context,
                          Routes.fixtureDetails,
                          arguments: MatchArgs(matchId: upcomingMatches[i].matchId,
                              liveStatus: upcomingMatches[i].matchLive == "1",
                              leagueName: upcomingMatches[i].leagueName,
                           )),
                      ),
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(Routes.upcomingMatches),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                    gradient: AppColors.blackishGradient,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0))),
                    child: const Center(child: TextWidget(text: "View All Matches",)),
                  ),
                )
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
