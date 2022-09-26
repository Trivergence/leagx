import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/viewmodels/base_model.dart';
import 'package:leagx/models/dashboard/league.dart';

import '../constants/app_constants.dart';
import '../core/network/app_url.dart';

class ChooseLeagueViewModel extends BaseModel {
  List<League> _leagues = [];
  List<League> get leagues => _leagues;
  Future<void> getData() async {
    setBusy(true);
    await getLeagues();
    setBusy(false);
  }

  Future<void> getLeagues() async {
    _leagues = await ApiService.getListRequest(
    baseUrl: AppUrl.footballBaseUrl,
    parameters:{
      "action":"get_leagues",
      "APIkey": AppConstants.footballApiKey
    },
    modelName: ApiModels.getLeagues
    );
  } 
  List<League> searchLeague(String value) {
    return _leagues
      .where((league) => league.leagueName.toLowerCase().contains(value.toLowerCase()))
      .toList();
  }
}