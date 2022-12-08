// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:leagx/models/user_summary.dart';
import 'package:provider/provider.dart';

import 'package:leagx/ui/screens/choose_analyst/components/choose_analyst_tile.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';

import '../../../core/network/internet_info.dart';
import '../../../models/dashboard/fixture.dart';
import '../../../models/leader.dart';
import '../../../models/subscribed_league.dart';
import '../../../view_models/fixture_view_model.dart';
import '../../util/app_dialogs/confirmation_dialog.dart';
import '../../widgets/placeholder_tile.dart';

// ignore: must_be_immutable
class ConsultAnalystScreen extends StatelessWidget {
  Fixture matchDetails;
  ConsultAnalystScreen({
    Key? key,
    required this.matchDetails,
  }) : super(key: key);

  List<UserSummary> analystList = [];
  late DashBoardViewModel _dashBoardViewModel;
  late FixtureDetailViewModel _fixtureViewModel;
  int? leagueId;

  @override
  Widget build(BuildContext context) {
    _dashBoardViewModel = context.read<DashBoardViewModel>();
    _fixtureViewModel = context.read<FixtureDetailViewModel>();
    analystList = _fixtureViewModel.getAnalysts;
    leagueId = getIntLeageId();
    return Scaffold(
        appBar: AppBarWidget(
          title: loc.chooseAnExpertTxtChooseAnExpert,
        ),
        body: ListView.builder(
          itemCount: analystList.length > 10 ? 10 : analystList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            UserSummary expert = analystList[index];
            return ConsultAnalystTile(
              number: index + 1,
              imageUrl: expert.profileImg,
              title: expert.firstName! + expert.lastName!,
              numberOfPrediciton: expert.totalPredictions!.round(),
              successRate: expert.predictionSuccessRate!.toStringAsFixed(1),
              onTileTap: () => _showConfirmationDialog(context, expert.id),
            );
          },
        ));
  }

  _showConfirmationDialog(BuildContext context, int analystId) async {
    ConfirmationDialog.show(
        context: context,
        title: loc.chooseAnExpertDialogTitle,
        positiveBtnTitle: loc.chooseAnExpertDialogYes,
        negativeBtnTitle: loc.chooseAnExpertDialogNo,
        body: loc.chooseAnExpertDialogBody,
        onPositiveBtnPressed: (_) => predict(context, analystId));
  }

  predict(BuildContext context, int analystId) async {
    bool isConnected = await InternetInfo.isConnected();
    if (isConnected == true) {
      if (leagueId != null) {
        context.read<FixtureDetailViewModel>().savePrediction(
            context: context,
            matchId: int.parse(matchDetails.matchId),
            leagueId: leagueId!,
            homeScore: 0,
            awayScore: 0,
            awayTeamLogo: matchDetails.teamAwayBadge,
            homeTeamLogo: matchDetails.teamHomeBadge,
            expertId: analystId,
            awayTeamName: matchDetails.matchAwayteamName,
            homeTeamName: matchDetails.matchHometeamName,
            isPublic: false);
      }
    }
  }

  int? getIntLeageId() {
    List<SubscribedLeague> subscribedLeagues = _dashBoardViewModel
        .subscribedLeagues
        .where((league) =>
            league.externalLeagueId.toString() == matchDetails.leagueId)
        .toList();
    if (subscribedLeagues.isNotEmpty) {
      return subscribedLeagues.first.id;
    } else {
      return null;
    }
  }
}
