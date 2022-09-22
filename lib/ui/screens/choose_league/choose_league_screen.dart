import 'package:leagx/models/dashboard/league.dart';
import 'package:leagx/ui/screens/base_widget.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/textfield/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/choose_league_view_model.dart';
import 'package:provider/provider.dart';

import 'components/league_tile.dart';

class ChooseLeagueScreen extends StatefulWidget {
  const ChooseLeagueScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLeagueScreen> createState() => _ChooseLeagueScreenState();
}

class _ChooseLeagueScreenState extends State<ChooseLeagueScreen> {
  final TextEditingController _searchController = TextEditingController();

  late List<League> listOfLeagues;

  late ChooseLeagueViewModel _chooseLeagueModel;
  bool isFiltering = false;
  List<League> filteredList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: loc.chooseLeagueTxtChooseALeague,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: BaseWidget<ChooseLeagueViewModel>(
          create: false,
          model: context.read<ChooseLeagueViewModel>(),
          onModelReady: (ChooseLeagueViewModel chooseLeagueModel) => chooseLeagueModel.getData(),
          builder: (context, ChooseLeagueViewModel chooseLeagueModel, _) {
            _chooseLeagueModel = chooseLeagueModel;
            listOfLeagues = isFiltering ? filteredList : chooseLeagueModel.leagues;
            return Column(
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
                    itemCount: listOfLeagues.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      League league = listOfLeagues[index];
                      return LeagueTile(
                        leagueTitle: league.leagueName,
                        imgUrl: league.leagueLogo,
                        hasSubscribed: false,
                      );
                    }),
              )
            ],
          );
      }),
    ));
  }

  void _onTextEntered(enteredText) {
    setState(() {
      isFiltering = true;
      filteredList = _chooseLeagueModel.searchLeague(enteredText);
    });
  }
}
