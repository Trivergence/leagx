// ignore_for_file: prefer_const_constructors

import 'package:flutter/scheduler.dart';
import 'package:leagx/models/dashboard/league.dart';
import 'package:leagx/ui/screens/base_widget.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/placeholder_tile.dart';
import 'package:leagx/ui/widgets/textfield/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/choose_league_view_model.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../../../models/subscribed_league.dart';
import '../../widgets/loading_widget.dart';
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
  List<int> subscribedIds = [];

  @override
  Widget build(BuildContext context) {
    subscribedIds = context.read<DashBoardViewModel>().subscribedLeagueIds;
    return Scaffold(
      appBar: AppBarWidget(
        title: loc.chooseLeagueTxtChooseALeague,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: BaseWidget<ChooseLeagueViewModel>(
          create: false,
          model: context.read<ChooseLeagueViewModel>(),
          onModelReady: (ChooseLeagueViewModel chooseLeagueModel) async { 
            SchedulerBinding.instance!.addPostFrameCallback((_) {
               chooseLeagueModel.getData();
            });
          },
          builder: (context, ChooseLeagueViewModel chooseLeagueModel, _) {
            _chooseLeagueModel = chooseLeagueModel;
            listOfLeagues = isFiltering ? filteredList : chooseLeagueModel.leagues;
            return !_chooseLeagueModel.busy ? Column(
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
              listOfLeagues.isNotEmpty ? Expanded(
                child: ListView.builder(
                    itemCount: listOfLeagues.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      League league = listOfLeagues[index];
                      return LeagueTile(
                        leagueId: league.leagueId,
                        leagueTitle: league.leagueName,
                        imgUrl: league.leagueLogo,
                        hasSubscribed: subscribedIds.contains(int.parse(league.leagueId)),
                      );
                    }),
              )
              //TODO localization
              : Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: PlaceHolderTile(height: 60, msgText: "Please check your network connection and try again"),
              )
            ],
          ) : const LoadingWidget();
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
