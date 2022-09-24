import 'package:flutter/scheduler.dart';
import 'package:leagx/models/dashboard/fixture.dart';
import 'package:leagx/models/match_args.dart';
import 'package:leagx/ui/screens/base_widget.dart';
import 'package:leagx/ui/screens/fixtureDetails/news/news_view.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/bar/tab_bar/tab_bar_widget.dart';

import 'package:flutter/material.dart';
import 'package:leagx/ui/widgets/dot_widget.dart';
import 'package:leagx/ui/widgets/loading_widget.dart';
import 'package:leagx/view_models/fixture_view_model.dart';
import 'package:provider/provider.dart';
import '../../widgets/bar/tab_bar/model/tab_bar_item_model.dart';

import 'match/match_view.dart';
import 'players/players_view.dart';

class FixtureDetails extends StatefulWidget {
  final MatchArgs matchData;
  const FixtureDetails({Key? key, required this.matchData}) : super(key: key);

  @override
  State<FixtureDetails> createState() => _FixtureDetailsState();
}

class _FixtureDetailsState extends State<FixtureDetails> {
  List<TabBarItemModel> listOfTabs = [
    TabBarItemModel(loc.fixtureDetailsBtnMatch, 0),
    TabBarItemModel(loc.fixtureDetailsBtnPlayers, 1),
    TabBarItemModel(loc.fixtureDetailsBtnNews, 2)
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BaseWidget<FixtureDetailViewModel>(
        create: false,
        model: context.read<FixtureDetailViewModel>(),
        onModelReady: (FixtureDetailViewModel model) async {
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            model.getData(matchId: widget.matchData.matchId);
          });
          },
        builder: (context, FixtureDetailViewModel fixtureModel, _) {
          return RefreshIndicator(
            onRefresh: () => fixtureModel.getData(matchId: widget.matchData.matchId),
            child: Scaffold(
            appBar: AppBarWidget(
              title: widget.matchData.leagueName,
              trailing: Padding(
                padding: const EdgeInsets.all(15.0),
                child: DotWidget(
                  size: 22,
                  isLive: widget.matchData.liveStatus,
                ),
              ),
            ),
            body: !fixtureModel.busy && fixtureModel.matchDetails.isNotEmpty ? Column(
              children: [
                TabBarWidget(
                    totalTabs: 3,
                    selectedIndex: index,
                    tabs: listOfTabs,
                    onTabChanged: (selectedIndex) {
                      setState(() {
                        index = selectedIndex!;
                      });
                    }),
                index == 0
                    ? MatchView(
                      matchDetails: fixtureModel.matchDetails.first,)
                    : index == 1
                        ? PlayersView(
                            matchDetails: fixtureModel.matchDetails.first,
                          )
                        : index == 2
                            ? NewsView(leagueId: fixtureModel.matchDetails.first.leagueId,)
                            : const SizedBox.shrink(),
              ],
            ) : const LoadingWidget(),
                  ),
          );
        },);
  }
}
