import 'package:leagx/models/players.dart';

import '../core/network/api/api_service.dart';
import '../core/viewmodels/base_model.dart';
import '../models/dashboard/events.dart';
import '../ui/util/utility/date_utility.dart';

class FixtureDetailViewModel extends BaseModel {
  List<Events> _matchDetails = [];
  List<Player> _awayTeamPlayers = [];
  List<Player> _homeTeamPlayers = [];

  List<Events> get matchDetails => _matchDetails;
  List<Player> get awayTeamPlayers => _awayTeamPlayers;
  List<Player> get homeTeamPlayers => _homeTeamPlayers;

  Future<void> getData({required String matchId}) async {
    setBusy(true);
    await getMatchDetails(matchId);
    await getHomeTeamPlayers(_matchDetails.first.matchHometeamId);
    await getAwayTeamPlayers(_matchDetails.first.matchAwayteamId);
    setBusy(false);
  }

  Future<void> getMatchDetails(String matchId) async {
    DateTime today = DateTime.now().toUtc();
    _matchDetails = await ApiService.getMatches(parameters: {
      "action": "get_events",
      "match_id": matchId,
      "from": DateUtility.getApiFormat(today),
      "to": DateUtility.getApiFormat(today),
      "timezone": "Asia/Karachi",
    });
  }

  getHomeTeamPlayers(String matchHometeamId) async {
    _homeTeamPlayers = await ApiService.getPlayers(matchHometeamId);
  }
  getAwayTeamPlayers(String matchAwayteamId) async {
    _awayTeamPlayers = await ApiService.getPlayers(matchAwayteamId);
  }
}
