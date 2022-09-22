import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/viewmodels/base_model.dart';
import 'package:leagx/models/dashboard/league.dart';

class ChooseLeagueViewModel extends BaseModel {
  // ignore: prefer_final_fields
  List<League> _leagues = [];
  List<League> get leagues => _leagues;
  void getData() {
    getLeagues();
  }

  Future<void> getLeagues() async {
    _leagues = await ApiService.getLeagues();
    notifyListeners();
  } 
  List<League> searchLeague(String value) {
    return _leagues
      .where((league) => league.leagueName.toLowerCase().contains(value.toLowerCase()))
      .toList();
  }
}