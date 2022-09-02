import 'package:leagx/constants/assets.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/ui_model/choose_league_model.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/textfield/search_textfield.dart';
import 'package:flutter/material.dart';

import 'components/league_tile.dart';

class ChooseLeagueScreen extends StatelessWidget {
  ChooseLeagueScreen({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  List<ChooseLeague> listOfLeagues = [
    ChooseLeague(
        leagueImage: Assets.leagueImage1,
        leagueName: 'FIFA Matches',
        hasSubscribed: true),
    ChooseLeague(
        leagueImage: Assets.leagueImage2,
        leagueName: 'Premier League',
        hasSubscribed: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: loc.chooseLeagueTxtChooseALeague,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 48,
              child: SearchTextField(
                textController: _searchController,
                hint: loc.chooseLeagueTxtSearch,
              ),
            ),
            UIHelper.verticalSpace(30),
            Expanded(
              child: ListView.builder(
                  itemCount: listOfLeagues.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return LeagueTile(
                      listOfLeagues: listOfLeagues,
                      index: index,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
