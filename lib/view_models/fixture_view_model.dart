import '../core/network/api/api_models.dart';
import '../core/network/api/api_service.dart';
import '../core/viewmodels/base_model.dart';
import '../models/dashboard/events.dart';
import '../ui/util/utility/date_utility.dart';

class FixtureDetailViewModel extends BaseModel {
  List<Events> _matchDetails = [];
  List<Events> get matchDetails => _matchDetails;

  Future<void> getData({required String matchId}) async {
    await getMatchDetails(matchId);
  }

  Future<void> getMatchDetails(String matchId) async {
    DateTime today = DateTime.now().toUtc();
    _matchDetails = await ApiService.callFootballApi(parameters: {
      "action": "get_events",
      "match_id": matchId,
      "from": DateUtility.getApiFormat(today),
      "to": DateUtility.getApiFormat(today),
    }, modelName: ApiModels.upcomingMatches);
    notifyListeners();
  }
}
