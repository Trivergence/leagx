import 'package:leagx/ui/screens/choose_fixture.dart/components/search_fixture_tile.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/textfield/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../../../models/dashboard/events.dart';

class ChooseFixtureScreen extends StatefulWidget {
  const ChooseFixtureScreen({Key? key}) : super(key: key);

  @override
  State<ChooseFixtureScreen> createState() => _ChooseFixtureScreenState();
}

class _ChooseFixtureScreenState extends State<ChooseFixtureScreen> {
  final TextEditingController _searchController = TextEditingController();

  BuildContext? _context;
  bool isFiltering = false;
  List<Fixture> filteredList = [];
  List<Fixture> availableMatches = [];

  @override
  Widget build(BuildContext context) {
    _context = context;
    availableMatches = getMatches(context);
    return Scaffold(
        appBar: AppBarWidget(
          title: "Choose A Fixture",
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
                    onTextEntered: _onTextEntered,
                  ),
                ),
                UIHelper.verticalSpace(30),
                Expanded(
                  child: ListView.builder(
                      itemCount: availableMatches.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Fixture match = availableMatches[index];
                        return ChooseFixtureTile(leagueId: match.leagueId,
                          imgUrl: match.leagueLogo,
                          leagueTitle: match.leagueName,
                          matchId: match.matchId,
                          awayTeamName: match.matchAwayteamName,
                          homeTeamName: match.matchHometeamName);
                      }),
                )
              ],
            )
        ));
  }

  void _onTextEntered(enteredText) {
    setState(() {
      isFiltering = true;
      filteredList = _context!.read<DashBoardViewModel>().searchMatches(enteredText);
    });
  }

  List<Fixture> getMatches(BuildContext context) {
    return context
        .read<DashBoardViewModel>()
        .upcomingMatches;
  }
}
