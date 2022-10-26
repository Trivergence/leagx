import 'package:leagx/constants/colors.dart';
import 'package:leagx/core/utility.dart';
import 'package:leagx/models/match_args.dart';
import 'package:leagx/models/user_summary.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/dashboard/components/home/components/analytics_widget.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/utility/image_utitlity.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/ui/screens/dashboard/components/fixture_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../core/network/internet_info.dart';
import '../../../../../models/dashboard/fixture.dart';
import '../../../../../models/leader.dart';
import '../../../../widgets/gradient/gradient_border_widget.dart';
import '../../../../widgets/placeholder_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<Fixture> upcomingMatches = [];
  List<Leader> listOfLeaders = [];
  UserSummary? _userSummary;

  @override
  Widget build(BuildContext context) {
    DashBoardViewModel dashBoardViewModel = context.read<DashBoardViewModel>();
    upcomingMatches = dashBoardViewModel.subscribedMatches;
    listOfLeaders = dashBoardViewModel.getLeaders;
    _userSummary = dashBoardViewModel.userSummary;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          // Container(
          //   padding: const EdgeInsets.all(16.0),
          //   decoration: BoxDecoration(
          //     gradient: AppColors.blackishGradient,
          //   ),
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //        TextWidget(
          //         text: loc.dashboardHomeTxtLeaders,
          //         fontWeight: FontWeight.w700,
          //       ),
          //       UIHelper.verticalSpaceSmall,
          //       SizedBox(
          //         height: 40.0,
          //         child: ListView.builder(
          //           scrollDirection: Axis.horizontal,
          //           itemCount: listOfLeaders.length,
          //           itemBuilder: (context, index) {
          //             Leader leader = listOfLeaders[index];
          //             return Padding(
          //               padding: const EdgeInsets.only(right: 20.0),
          //               child: GradientBorderWidget(
          //                 width: 40.0,
          //                 height: 40.0,
          //                 isCircular: true,
          //                 imageUrl: leader.profileImg,
          //                 placeHolderImg: ImageUtitlity.getRandomProfileAvatar(),
          //                 onPressed: () {},
          //               ),
          //             );
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_userSummary != null) AnalyticsWidget(
                  firstLabel: loc.dashboardHomeTxtPredictions,
                  firstValue: _userSummary!.totalPredictions.toString(),
                  secondLabel: loc.dashboardHomeTxtWiningRatio,
                  secondValue: _userSummary!
                      .predictionSuccessRate.toString() != "100.0" 
                      ? _userSummary!.predictionSuccessRate!.toStringAsFixed(1) 
                      : _userSummary!.predictionSuccessRate!.toStringAsFixed(0),
                  thirdLabel: loc.dashboardHomeTxtEarnedCoid,
                  thirdValue: _userSummary!.coinEarned!.round().toString(),
                ),
                 TextWidget(
                  text: loc.dashboardHomeTxtUpcomingMatches,
                  fontWeight: FontWeight.w700,
                ),
                UIHelper.verticalSpaceSmall,
                upcomingMatches.isNotEmpty ? Column(
                  children: [
                    for(int i = 0; i < 3; i++) FixtureWidget(
                        leagueName: upcomingMatches[i].leagueName,
                        teamOneFlag: upcomingMatches[i].teamHomeBadge,
                        teamOneName: upcomingMatches[i].matchHometeamName,
                        teamTwoFlag: upcomingMatches[i].teamAwayBadge,
                        teamTwoName: upcomingMatches[i].matchAwayteamName,
                        scheduledDate: upcomingMatches[i].matchDate,
                        scheduledTime: upcomingMatches[i].matchTime,
                        isLive: upcomingMatches[i].matchLive == "1",
                        matchStatus: upcomingMatches[i].matchStatus!,
                        isOver: Utility.isMatchOver(upcomingMatches[i].matchStatus!),
                        teamOneScore: upcomingMatches[i].matchHometeamScore,
                        teamTwoScore: upcomingMatches[i].matchAwayteamScore,
                        onTap: (leagueName) async {
                          bool isConnected = await InternetInfo.isConnected();
                          if (isConnected) {
                            Navigator.pushNamed(context,
                            Routes.fixtureDetails,
                            arguments: MatchArgs(
                              matchId: upcomingMatches[i].matchId,
                              leagueName: leagueName,
                            ));
                          }
                        }
                      ),
                  ],
                ) : PlaceHolderTile(height: 80, msgText: loc.dashboardHomeTxtEmptyList),
                if(upcomingMatches.length > 3) InkWell(
                  onTap: () => Navigator.of(context).pushNamed(Routes.upcomingMatches),
                  child: PlaceHolderTile(height: 40, msgText: loc.dashboardHomeTxtViewAll,),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

