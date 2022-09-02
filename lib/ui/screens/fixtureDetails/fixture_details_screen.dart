import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/screens/fixtureDetails/news/news_view.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/bar/tab_bar/tab_bar_widget.dart';

import 'package:flutter/material.dart';
import 'package:leagx/ui/widgets/dot_widget.dart';
import 'package:leagx/ui/widgets/live_widget.dart';
import '../../widgets/bar/tab_bar/model/tab_bar_item_model.dart';

import 'match/match_view.dart';
import 'players/players_view.dart';

class FixtureDetails extends StatefulWidget {
  const FixtureDetails({Key? key}) : super(key: key);

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
    return Scaffold(
      appBar: AppBarWidget(
        title: 'UEFA Champion League',
        trailing: const Padding(
          padding: EdgeInsets.all(15.0),
          child: DotWidget(
            size: 22,
          ),
        ),
      ),
      body: Column(
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
              ? const MatchView()
              : index == 1
                  ? PlayersView()
                  : index == 2
                      ? const NewsView()
                      : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
