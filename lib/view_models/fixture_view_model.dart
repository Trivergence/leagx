import 'package:flutter/material.dart';
import 'package:leagx/constants/enums.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/core/sharedpref/sharedpref.dart';
import 'package:leagx/models/players.dart';
import 'package:leagx/models/prediction.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../constants/colors.dart';
import '../core/network/api/api_models.dart';
import '../core/network/api/api_service.dart';
import '../core/network/app_url.dart';
import '../core/network/internet_info.dart';
import '../core/utility.dart';
import '../core/viewmodels/base_model.dart';
import '../models/dashboard/fixture.dart';
import '../models/live_match.dart';
import '../models/user/user.dart';
import '../models/user_summary.dart';
import '../routes/routes.dart';
import '../service/service_locator.dart';
import '../ui/screens/fixtureDetails/components/prediction_bottom_sheet.dart';
import '../ui/util/app_dialogs/fancy_dialog.dart';
import '../ui/util/loader/loader.dart';

class FixtureDetailViewModel extends BaseModel {
  LiveMatch? _liveMatch;
  Map<String, LiveMatch> _cachedLink = {};
  List<Fixture> _matchDetails = [];
  List<Player> _awayTeamPlayers = [];
  List<Player> _homeTeamPlayers = [];
  List<Prediction> _predictions = [];

  LiveMatch? get liveMatch => _liveMatch;
  List<Fixture> get matchDetails => _matchDetails;
  List<Player> get awayTeamPlayers => _awayTeamPlayers;
  List<Player> get homeTeamPlayers => _homeTeamPlayers;
  List<Prediction> get getPredictions => _predictions;

  Future<void> getData({required String matchId}) async {
    setBusy(true);
    try {
      await getMatchDetails(matchId);
      await getLiveMatchData(matchId);
      setBusy(false);
      if(matchDetails.isNotEmpty) {
        await getHomeTeamPlayers(_matchDetails.first.matchHometeamId);
        await getAwayTeamPlayers(_matchDetails.first.matchAwayteamId);
      }
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
    try {
      DateTime now = DateTime.now();
      String currentTimeZone = await Utility.getTzName();
      List<dynamic> tempList = await ApiService.getListRequest(
        baseUrl: AppUrl.footballBaseUrl,
        modelName: ApiModels.upcomingMatches,
        parameters: {
        "APIkey": AppConstants.footballApiKey,
        "action": "get_events",
        "match_id": matchId,
        "from": "2022-01-01",
        "to": "2022-12-30",
        "timezone": currentTimeZone,
       },
        cache: true,
        cacheBoxName: AppConstants.matchDetailsBoxName + matchId
      );
      _matchDetails = tempList.cast<Fixture>();
    } on Exception catch (_) {
        setBusy(false);
    }
  }

  Future<void> savePrediction({
  required BuildContext context,
  required String homeTeamName,
  required String awayTeamName,
  required String homeTeamLogo,
  required String awayTeamLogo,
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
          "first_team_logo": homeTeamLogo,
          "second_team_logo": awayTeamLogo,
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
      await getUserPredictions();
      ToastMessage.show(loc.fixtureDetailsPredictionSuccess, TOAST_TYPE.success);
      context.read<DashBoardViewModel>().getUserSummary();
      context.read<DashBoardViewModel>().getAllLeaders();
      context.read<DashBoardViewModel>().getData(context);
      Navigator.of(context).pop();
      Loader.hideLoader();
    } else {
      Loader.hideLoader();
    }
  }

  Future<void> getUserPredictions({bool showToast = true}) async {
    User? user = preferenceHelper.getUser();
    if(user != null) {
      String completeUrl = AppUrl.getUser + user.id.toString() + AppUrl.getPredictions;
      List<dynamic> tempList = await ApiService.getListRequest(
        url: completeUrl,
        baseUrl: AppUrl.baseUrl,
        modelName: ApiModels.getPredictions,
        showToast: showToast
      );
      _predictions = tempList.cast<Prediction>();
      notifyListeners();
      } else {
        _predictions = [];
      }
  }

  getHomeTeamPlayers(String matchHometeamId) async {
    try {
      List<dynamic> tempList = await ApiService.getListRequest(
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
    } on Exception catch (_) {
      setBusy(false);
    }
  }
  getAwayTeamPlayers(String matchAwayteamId) async {
    try {
      List<dynamic> tempList = await ApiService.getListRequest(
          baseUrl: AppUrl.footballBaseUrl,
          parameters: {
            "action": "get_teams",
            "team_id": matchAwayteamId,
            "APIkey": AppConstants.footballApiKey
          },
          modelName: ApiModels.getTeams);
          _awayTeamPlayers = tempList.cast<Player>();
          notifyListeners();
    } on Exception catch (_) {
      setBusy(false);
    }
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
  Prediction? getMatchPrediction({required String matchId}) {
    List<Prediction> userPredictions = _predictions
    .where((prediction) => prediction.externalMatchId == int.parse(matchId))
    .toList();
    if(userPredictions.isNotEmpty) {
      return userPredictions[0];
    }
    return null;
  }

  void predictMatch({required BuildContext context, required Fixture matchDetails}) {
      UserSummary? userSummary = context.read<DashBoardViewModel>().userSummary;
    if (userSummary != null && userSummary.remainingPredictions! > 0) {
      showPredictionSheet(context, matchDetails);
    } else {
      FancyDialog.showInfo(
          context: context,
          title: loc.fixtureDetailsPredictionDialogTitle,
          okTitle: loc.fixtureDetailsPredictionDialogBtnAdd,
          cancelTitle: loc.fixtureDetailsPredictionDialogBtnCancel,
          onOkPressed: () async {
            bool isConnected = await InternetInfo.isConnected();
            if (isConnected == true) {
              Navigator.pushNamed(context, Routes.chooseLeague, arguments: false);
            }
          });
    }
  }
  Future<void> getLiveMatchData(String matchId) async {
    if(!_cachedLink.containsKey(matchId)) {
      String completeUrl = AppUrl.liveAnimation + "/" + matchId;
      _liveMatch = await ApiService.callGetApi(
          baseUrl: AppUrl.clientUrl,
          url: completeUrl,
          modelName: ApiModels.liveMatch,
          requestType: RequestType.clientSideApi);
    } else {
      _liveMatch = _cachedLink[matchId];
    }
    notifyListeners();
    if(liveMatch != null && liveMatch!.url.isNotEmpty) {
      cacheStreamLink(matchId : matchId, liveMatch : liveMatch!);
    }
  }
  
  void cacheStreamLink({
    required String matchId,
    required LiveMatch liveMatch}) {
      _cachedLink[matchId] = liveMatch;
  }
}
