import 'package:flutter/cupertino.dart';
import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/enums.dart';
import 'package:leagx/core/utility.dart';
import 'package:leagx/models/subscribed_league.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/dashboard/components/home/components/league_avatar.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/screens/dashboard/components/fixture_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/dimens.dart';
import '../../../../../core/network/internet_info.dart';
import '../../../../../models/dashboard/fixture.dart';
import '../../../../../models/match_args.dart';
import '../../../../../view_models/dashboard_view_model.dart';
import '../../../../widgets/placeholder_tile.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Fixture> subscribedMatches = [];

  List<SubscribedLeague> subscribedLeagues = [];
  bool isFiltering = false;
  int selectedIndex = -1;
  FilterType selectedFilter = FilterType.upcoming;
  late ScrollController _leagueController;
  late ScrollController _matchController;

  late DashBoardViewModel _dashBoardViewModel;

  @override
  Widget build(BuildContext context) {
    _leagueController = ScrollController();
    _matchController = ScrollController();
    subscribedMatches = context.select<DashBoardViewModel, List<Fixture>>(
        (dashboardModel) => dashboardModel.subscribedMatches);
    _dashBoardViewModel = context.read<DashBoardViewModel>();
    subscribedMatches = isFiltering == true
        ? _dashBoardViewModel.filteredMatches
        : _dashBoardViewModel.subscribedMatches;
    subscribedMatches = selectedFilter == FilterType.finished
        ? _dashBoardViewModel.getFinishedMatches(subscribedMatches)
        : _dashBoardViewModel.getUpcomingMatches(subscribedMatches);
    subscribedLeagues = _dashBoardViewModel.subscribedLeagues;
    return RefreshIndicator(
      backgroundColor: AppColors.textFieldColor,
      onRefresh: _refreshData,
      child: Column(
        children: [
          UIHelper.verticalSpaceSmall,
          TextWidget(
            text: loc.dashboardHomeTxtLeagues,
            fontWeight: FontWeight.w600,
            letterSpace: Utility.isArabic() ? 0 : 4,
            textSize: Dimens.textRegular,
          ),
          UIHelper.verticalSpaceSmall,
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
                gradient: AppColors.blackishGradient,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: LeagueAvatarWidget(
                          addLeague: true,
                          onPressed: () async {
                            if (_dashBoardViewModel.isInitialized) {
                              await Navigator.of(context).pushNamed(
                                  Routes.chooseLeague,
                                  arguments: false);
                              setState(() {});
                            } else {
                              ToastMessage.show(
                                  loc.msgPleaseWait, TOAST_TYPE.msg);
                            }
                          },
                          isSelected: false,
                          width: 40,
                          iconData: Icons.add,
                        )),
                    if (subscribedLeagues.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: LeagueAvatarWidget(
                          onPressed: showAll,
                          isSelected: !isFiltering,
                          width: 40,
                          text: loc.dashboardHomeTxtAll,
                          textSize: Dimens.textXS,
                        ),
                      ),
                    if (subscribedLeagues.isNotEmpty)
                      Expanded(
                        child: SizedBox(
                          height: 40.0,
                          child: ListView.builder(
                            controller: _leagueController,
                            scrollDirection: Axis.horizontal,
                            itemCount: subscribedLeagues.length,
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: LeagueAvatarWidget(
                                  onPressed: () => filterByLeague(index),
                                  placeHolderImg: Assets.icLeague,
                                  isSelected: index == selectedIndex,
                                  imageUrl: subscribedLeagues[index].logo,
                                  padding: const EdgeInsets.all(5.0),
                                  width: 40,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    if (subscribedLeagues.isNotEmpty)
                      InkWell(
                          onTap: () => _dashBoardViewModel.scrollList(
                              scrollController: _leagueController),
                          child: const Icon(Icons.arrow_forward_ios_rounded))
                  ],
                ),
              ],
            ),
          ),
          UIHelper.verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedFilter = FilterType.upcoming;
                  });
                },
                child: TextWidget(
                  text: loc.dashboardFixtureTxtUpcomingMatches,
                  fontWeight: FontWeight.w600,
                  letterSpace: Utility.isArabic() ? 0 : 4,
                  textSize: Dimens.textRegular,
                  color: selectedFilter == FilterType.upcoming
                      ? AppColors.colorWhite
                      : AppColors.colorWhite.withOpacity(0.3),
                ),
              ),
              UIHelper.horizontalSpaceSmall,
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedFilter = FilterType.finished;
                  });
                },
                child: TextWidget(
                  text: loc.dashboardFixtureTxtFinishedMatches,
                  fontWeight: FontWeight.w600,
                  letterSpace: Utility.isArabic() ? 0 : 4,
                  textSize: Dimens.textRegular,
                  color: selectedFilter == FilterType.finished
                      ? AppColors.colorWhite
                      : AppColors.colorWhite.withOpacity(0.3),
                ),
              ),
            ],
          ),
          subscribedMatches.isNotEmpty
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 16.0,
                      left: 16.0,
                      top: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListView.builder(
                              controller: _matchController,
                              shrinkWrap: true,
                              itemCount: subscribedMatches.length,
                              itemBuilder: (context, index) {
                                Fixture match = subscribedMatches[index];
                                return FixtureWidget(
                                    key: UniqueKey(),
                                    leagueName: match.leagueName,
                                    teamOneFlag: match.teamHomeBadge,
                                    teamOneName: match.matchHometeamName,
                                    teamTwoFlag: match.teamAwayBadge,
                                    teamTwoName: match.matchAwayteamName,
                                    scheduledTime: match.matchTime,
                                    scheduledDate: match.matchDate,
                                    isLive: match.matchLive == "1",
                                    isOver:
                                        Utility.isMatchOver(match.matchStatus!),
                                    matchStatus: match.matchStatus,
                                    teamOneScore: match.matchHometeamScore,
                                    teamTwoScore: match.matchAwayteamScore,
                                    onTap: (leagueName) async {
                                      bool isConnected =
                                          await InternetInfo.isConnected();
                                      if (isConnected == true) {
                                        Navigator.pushNamed(
                                            context, Routes.fixtureDetails,
                                            arguments: MatchArgs(
                                              matchId: match.matchId,
                                              leagueName: leagueName,
                                            ));
                                      }
                                    });
                              }),
                        )
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: PlaceHolderTile(
                      height: 80, msgText: loc.dashboardHomeTxtEmptyList),
                ),
        ],
      ),
    );
  }

  void showAll() {
    goToStart(_matchController);
    if (isFiltering != false) {
      selectedIndex = -1;
      isFiltering = false;
      setState(() {});
    }
  }

  filterByLeague(int index) {
    goToStart(_matchController);
    if (selectedIndex != index) {
      context.read<DashBoardViewModel>().filterByLeague(
          leagueId: subscribedLeagues[index].externalLeagueId.toString());
      setState(() {
        isFiltering = true;
        selectedIndex = index;
      });
    } else {
      context.read<DashBoardViewModel>().filterByLeague(
          leagueId: subscribedLeagues[index].externalLeagueId.toString());
    }
  }

  Future<void> _refreshData() async {
    await _dashBoardViewModel.getAllFixtures();
    filterByLeague(selectedIndex);
    setState(() {});
  }

  void goToStart(ScrollController matchController) {
    if (matchController.hasClients && matchController.offset > 50) {
      _matchController.jumpTo(-500);
    }
  }
}
