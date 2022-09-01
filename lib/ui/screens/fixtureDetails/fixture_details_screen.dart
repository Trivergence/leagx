import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/screens/fixtureDetails/news/news_view.dart';
import 'package:leagx/ui/widgets/app_bar_widget.dart';
import 'package:leagx/ui/widgets/header_widget.dart';

import 'package:flutter/material.dart';
import '../../util/ui_model/tab_button_model.dart';

import 'match/match_view.dart';
import 'players/players_view.dart';

class FixtureDetails extends StatefulWidget {
  const FixtureDetails({Key? key}) : super(key: key);

  @override
  State<FixtureDetails> createState() => _FixtureDetailsState();
}

class _FixtureDetailsState extends State<FixtureDetails> {
  List<TabButtonModel> listOfTabs = [
    TabButtonModel('MATCH', 0),
    TabButtonModel('PLAYERS', 1),
    TabButtonModel('NEWS', 2)
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarWidget(
        title: 'UEFA Champion League',
        trailing: const Padding(
          padding: EdgeInsets.only(right: 15.0),
          child: CircleAvatar(
            radius: 8,
            backgroundColor: AppColors.colorGreen,
          ),
        ),
      ),
      body: Column(
        children: [
          HeaderWidget(
              totalTabs: 3,
              selectedIndex: index,
              listOfTabs: listOfTabs,
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
