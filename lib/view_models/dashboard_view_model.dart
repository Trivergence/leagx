import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/viewmodels/base_model.dart';
import 'package:leagx/models/dashboard/events.dart';
import 'package:leagx/ui/util/utility/date_utility.dart';

class DashBoardViewModel extends BaseModel {

  List<Events> _upcomingMatches = [];
  List<Events> get upcomingMatches => _upcomingMatches;

  Future<void> getData() async {
    await getUpcomingMatches();
  }

  Future<void> getUpcomingMatches() async {
     DateTime today = DateTime.now().toUtc();
     _upcomingMatches = await ApiService.callFootballApi(
      parameters: {
        "action": "get_events",
        "from": DateUtility.getApiFormat(today),
        "to": DateUtility.getApiFormat(today),
      },
      modelName: ApiModels.upcomingMatches
    );
    _upcomingMatches = upcomingMatches.where((match) => match.matchStatus == MatchStatus.FINISHED).toList();
    notifyListeners();
  }
}