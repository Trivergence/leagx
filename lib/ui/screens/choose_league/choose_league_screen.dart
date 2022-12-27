// ignore_for_file: prefer_const_constructors

import 'package:leagx/core/utility.dart';
import 'package:leagx/models/dashboard/league.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/utility/translation_utility.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/loading_widget.dart';
import 'package:leagx/ui/widgets/textfield/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/subscription_viewmodel.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import 'components/league_tile.dart';

class ChooseLeagueScreen extends StatefulWidget {
  final bool isRedeeming;
  const ChooseLeagueScreen({Key? key, this.isRedeeming = false})
      : super(key: key);

  @override
  State<ChooseLeagueScreen> createState() => _ChooseLeagueScreenState();
}

class _ChooseLeagueScreenState extends State<ChooseLeagueScreen> {
  final TextEditingController _searchController = TextEditingController();

  late List<League> listOfLeagues;

  late SubscriptionViewModel _subscriptionViewModel;
  bool isFiltering = false;
  List<League> filteredList = [];
  List<int> subscribedIds = [];

  @override
  Widget build(BuildContext context) {
    _subscriptionViewModel = context.watch<SubscriptionViewModel>();
    subscribedIds = context.read<DashBoardViewModel>().subscribedLeagueIds;
    listOfLeagues = isFiltering ? filteredList : _subscriptionViewModel.leagues;
    return Scaffold(
        appBar: AppBarWidget(
          title: loc.chooseLeagueTxtChooseALeague,
        ),
        body: !_subscriptionViewModel.busy
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 48,
                      child: SearchTextField(
                        textController: _searchController,
                        hint: loc.chooseLeagueTxtSearch,
                        onSeachClicked: _onSearch,
                        onFieldSubmitted: _onSubmit,
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
                              key: UniqueKey(),
                              leagueId: league.leagueId,
                              leagueTitle: league.leagueName,
                              imgUrl: league.leagueLogo,
                              hasSubscribed: subscribedIds
                                  .contains(int.parse(league.leagueId)),
                              isRedeeming: widget.isRedeeming,
                            );
                          }),
                    )
                  ],
                ))
            : LoadingWidget());
  }

  Future<void> _onSubmit(enteredText) async => applyFilter(enteredText);

  Future<void> _onSearch() async {
    String enteredText = _searchController.text;
    if (enteredText.isNotEmpty) {
      applyFilter(enteredText);
    } else {
      if (isFiltering) {
        setState(() {
          isFiltering = false;
        });
      }
    }
  }

  Future<void> applyFilter(String enteredText) async {
    if (Utility.isRTL(enteredText)) {
      enteredText = await TranslationUtility.translateFromArabic(enteredText);
    }
    setState(() {
      isFiltering = true;
      filteredList = _subscriptionViewModel.searchLeague(enteredText);
    });
  }
}
