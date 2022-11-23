import 'package:leagx/core/utility.dart';
import 'package:leagx/models/match_args.dart';
import 'package:leagx/models/user_summary.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/dashboard/components/home/components/analytics_widget.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/ui/screens/dashboard/components/fixture_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/dimens.dart';
import '../../../../../core/network/internet_info.dart';
import '../../../../../models/dashboard/fixture.dart';
import '../../../../../models/leader.dart';
import '../../../../widgets/placeholder_tile.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<Fixture> upcomingMatches = [];
  List<Leader> listOfLeaders = [];
  UserSummary? _userSummary;
  late DashBoardViewModel _dashBoardViewModel;

  @override
  Widget build(BuildContext context) {
    _dashBoardViewModel = context.read<DashBoardViewModel>();
    _userSummary = context.select<DashBoardViewModel, UserSummary?>((dasboardModel) => dasboardModel.userSummary);
    upcomingMatches = _dashBoardViewModel.subscribedMatches;
    listOfLeaders = _dashBoardViewModel.getLeaders;
    return RefreshIndicator(
      backgroundColor: AppColors.textFieldColor,
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    fontWeight: FontWeight.bold,
                    letterSpace: 4,
                    textSize: Dimens.textSM,
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
                            if (isConnected == true) {
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
      ),
    );
  }

  Future<void> _refreshData() async {
    await _dashBoardViewModel.getAllFixtures();
    await _dashBoardViewModel.getUserSummary();
  }
}

