import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/core/utility.dart';
import 'package:leagx/models/subscribed_league.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/dashboard/components/fixture/components/league_avatar.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/screens/dashboard/components/fixture_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/network/internet_info.dart';
import '../../../../../models/dashboard/fixture.dart';
import '../../../../../models/match_args.dart';
import '../../../../../view_models/dashboard_view_model.dart';
import '../../../../widgets/placeholder_tile.dart';

// ignore: must_be_immutable
class FixtureScreen extends StatefulWidget {
  const FixtureScreen({Key? key}) : super(key: key);

  @override
  State<FixtureScreen> createState() => _FixtureScreenState();
}

class _FixtureScreenState extends State<FixtureScreen> {
  List<Fixture> subscribedMatches = [];

  List<SubscribedLeague> subscribedLeagues = [];
  bool isFiltering = false;
  int selectedIndex = -1;
  late ScrollController _scrollController;
  final int baseScrollPoint = 3;
  double scrollWidth = 0.0;
  int move = 1;

  late DashBoardViewModel _dashBoardViewModel;

  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController();
    _dashBoardViewModel = context.read<DashBoardViewModel>();
    subscribedMatches = isFiltering == true
        ? _dashBoardViewModel.filteredMatches
        : _dashBoardViewModel.subscribedMatches;
    subscribedLeagues = _dashBoardViewModel.subscribedLeagues;
    return RefreshIndicator(
      backgroundColor: AppColors.textFieldColor,
      onRefresh: _refreshData,
      child: Column(
        children: [
          UIHelper.verticalSpaceSmall,
          TextWidget(
            text: loc.dashboardFixtureTxtLeagues,
            fontWeight: FontWeight.w700,
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
                            await Navigator.of(context).pushNamed(
                                Routes.chooseLeague,
                                arguments: false);
                            setState(() {});
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
                          text: loc.dashboardFixtureTxtAll,
                        ),
                      ),
                    if (subscribedLeagues.isNotEmpty)
                      Expanded(
                        child: SizedBox(
                          height: 40.0,
                          child: ListView.builder(
                            controller: _scrollController,
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
                    if(subscribedLeagues.isNotEmpty) InkWell(
                        onTap: () => _scrollToTheNextItemView(),
                        child: const Icon(Icons.arrow_forward_ios_rounded))
                  ],
                ),
              ],
            ),
          ),
          subscribedMatches.isNotEmpty
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                      height: 80, msgText: loc.dashboardFixtureTxtEmptyList),
                ),
        ],
      ),
    );
  }

  void showAll() {
    if (isFiltering != false) {
      selectedIndex = -1;
      isFiltering = false;
      setState(() {});
    }
  }

  filterByLeague(int index) {
    if (selectedIndex != index) {
      _dashBoardViewModel.filterByLeague(
          leagueId: subscribedLeagues[index].externalLeagueId.toString());
      setState(() {
        isFiltering = true;
        selectedIndex = index;
      });
    }
  }

  Future<void> _refreshData() async {
    await _dashBoardViewModel.getAllFixtures();
  }

  _scrollToTheNextItemView(
      {ScrollDirection scrollDirection = ScrollDirection.forward}) async {
    if (scrollDirection == ScrollDirection.forward) {
      if (_scrollController.position.pixels <
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        await _scrollController.animateTo(
            _scrollController.position.pixels + 100,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut);
      }
    } else {
      if (_scrollController.position.pixels >
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        await _scrollController.animateTo(
            _scrollController.position.pixels - 100,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut);
      }
    }
  }
}
enum ScrollDirection { forward, backward }