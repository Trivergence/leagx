import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/viewmodels/base_model.dart';
import 'package:leagx/models/dashboard/league.dart';

class ChooseLeagueViewModel extends BaseModel {
  List<League> _leagues = [];
  List<League> get leagues => _leagues;
  Future<void> getData() async {
    setBusy(true);
    await getLeagues();
    setBusy(false);
  }

  Future<void> getLeagues() async {
    _leagues = await ApiService.getLeagues();
  } 
  List<League> searchLeague(String value) {
    return _leagues
      .where((league) => league.leagueName.toLowerCase().contains(value.toLowerCase()))
      .toList();
  }
}