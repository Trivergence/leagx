import 'package:leagx/core/utility.dart';
import 'package:leagx/ui/screens/choose_fixture.dart/components/choose_match_tile.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/utility/translation_utility.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/textfield/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../../../models/dashboard/fixture.dart';
import '../../widgets/placeholder_tile.dart';

class ChooseFixtureScreen extends StatefulWidget {
  const ChooseFixtureScreen({Key? key}) : super(key: key);

  @override
  State<ChooseFixtureScreen> createState() => _ChooseFixtureScreenState();
}

class _ChooseFixtureScreenState extends State<ChooseFixtureScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool isFiltering = false;
  List<Fixture> filteredList = [];
  List<Fixture> availableMatches = [];

  @override
  Widget build(BuildContext context) {
    availableMatches = getMatches(context);
    return Scaffold(
        appBar: AppBarWidget(
          title: loc.chooseFixtureTxtTitle,
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
                    onFieldSubmitted: (_) => _filter(),
                    onSeachClicked: _filter,
                  ),
                ),
                UIHelper.verticalSpace(30),
                availableMatches.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: isFiltering
                                ? filteredList.length
                                : availableMatches.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Fixture match = isFiltering
                                  ? filteredList[index]
                                  : availableMatches[index];
                              return ChooseFixtureTile(
                                  key: UniqueKey(),
                                  leagueId: match.leagueId,
                                  teamOneFlag: match.teamHomeBadge,
                                  teamTwoFlag: match.teamAwayBadge,
                                  matchId: match.matchId,
                                  awayTeamName: match.matchAwayteamName,
                                  homeTeamName: match.matchHometeamName);
                            }),
                      )
                    : Center(
                        child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 100),
                        child: PlaceHolderTile(
                            height: 80, msgText: loc.chooseFixtureTxtEmptyList),
                      )),
              ],
            )));
  }

  bool filterMatches(Fixture matchItem, String enteredText) {
    return matchItem.matchAwayteamName
            .toLowerCase()
            .contains(enteredText.toLowerCase()) ||
        matchItem.matchHometeamName
            .toLowerCase()
            .contains(enteredText.toLowerCase());
  }

  List<Fixture> getMatches(BuildContext context) {
    return context.read<DashBoardViewModel>().subscribedMatches;
  }

  _filter() async {
    String enteredText = _searchController.text;
    if (enteredText.isNotEmpty) {
      if (Utility.isRTL(enteredText)) {
        enteredText = await TranslationUtility.translateFromArabic(enteredText);
      }
      setState(() {
        isFiltering = true;
        filteredList = availableMatches
            .where((matchItem) => filterMatches(matchItem, enteredText))
            .toList();
      });
    } else {
      if (isFiltering) {
        isFiltering = false;
        setState(() {});
      }
    }
  }
}
