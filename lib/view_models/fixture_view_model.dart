import 'package:flutter/material.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/models/players.dart';

import '../constants/app_constants.dart';
import '../constants/colors.dart';
import '../core/network/api/api_models.dart';
import '../core/network/api/api_service.dart';
import '../core/network/app_url.dart';
import '../core/viewmodels/base_model.dart';
import '../models/dashboard/fixture.dart';
import '../models/user/user.dart';
import '../service/service_locator.dart';
import '../ui/screens/fixtureDetails/components/prediction_bottom_sheet.dart';
import '../ui/util/loader/loader.dart';
import '../ui/util/utility/date_utility.dart';

class FixtureDetailViewModel extends BaseModel {
  List<Fixture> _matchDetails = [];
  List<Player> _awayTeamPlayers = [];
  List<Player> _homeTeamPlayers = [];

  List<Fixture> get matchDetails => _matchDetails;
  List<Player> get awayTeamPlayers => _awayTeamPlayers;
  List<Player> get homeTeamPlayers => _homeTeamPlayers;

  Future<void> getData({required String matchId}) async {
    setBusy(true);
    try {
      await getMatchDetails(matchId);
      setBusy(false);
      await getHomeTeamPlayers(_matchDetails.first.matchHometeamId);
      await getAwayTeamPlayers(_matchDetails.first.matchAwayteamId);
    } on Exception catch (_) {
      setBusy(false);
    }
  }
    Future<void> refreshData({required String matchId}) async {
    await getMatchDetails(matchId);
    await getHomeTeamPlayers(_matchDetails.first.matchHometeamId);
    await getAwayTeamPlayers(_matchDetails.first.matchAwayteamId);
    notifyListeners();
  }

  Future<void> getMatchDetails(String matchId) async {
    DateTime today = DateTime.now().toUtc();
    List<Fixture> tempList = await ApiService.getListRequest(
      baseUrl: AppUrl.footballBaseUrl,
      modelName: ApiModels.upcomingMatches,
      parameters: {
      "APIkey": AppConstants.footballApiKey,
      "action": "get_events",
      "match_id": matchId,
      "from": DateUtility.getApiFormat(today),
      "to": DateUtility.getApiFormat(today),
      "timezone": "Asia/Riyadh",
    });
    _matchDetails = tempList.cast<Fixture>();
  }

  Future<void> savePrediction({
  required BuildContext context,
  required String homeTeamName,
  required String awayTeamName,
  required int matchId,
  required int leagueId,
  required int homeScore,
  required int awayScore,
  required bool isPublic,
  int? expertId }
  ) async {
    User? user =locator<SharedPreferenceHelper>().getUser();
    Map<String,dynamic> body = {
      "match":{
          "first_team_name": homeTeamName,
          "second_team_name": awayTeamName,
          "external_match_id": matchId,
          "league_id": leagueId
      },
      "prediction": {
          "first_team_score": homeScore,
          "second_team_score": awayScore,
          "user_id": user!.id,
          "is_public": isPublic.toString(),
          "expert_id": expertId
      }
    };
    Loader.showLoader();
    bool success = await ApiService.postWoResponce(
      url: AppUrl.makePrediction,
      body: body);
    if(success) {
      Navigator.of(context).pop();
      Loader.hideLoader();
    } else {
      Loader.hideLoader();
    }
  }

  getHomeTeamPlayers(String matchHometeamId) async {
    List<Player> tempList = await ApiService.getListRequest(
      baseUrl: AppUrl.footballBaseUrl,
      parameters: {
      "action": "get_teams",
      "team_id": matchHometeamId,
      "APIkey": AppConstants.footballApiKey
      },
      modelName: ApiModels.getTeams
    ) ;
    _homeTeamPlayers = tempList.cast<Player>();
    notifyListeners();
  }
  getAwayTeamPlayers(String matchAwayteamId) async {
    List<Player> tempList = await ApiService.getListRequest(
        baseUrl: AppUrl.footballBaseUrl,
        parameters: {
          "action": "get_teams",
          "team_id": matchAwayteamId,
          "APIkey": AppConstants.footballApiKey
        },
        modelName: ApiModels.getTeams);
        _awayTeamPlayers = tempList.cast<Player>();
        notifyListeners();
  }

  showPredictionSheet(BuildContext context, Fixture matchDeta) {
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.colorBackground,
        builder: (context) {
          return PredictionSheetWidget(
              matchDetails: matchDeta,
            );
        });
  }
}
