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
     DateTime now = DateTime.now();
     _upcomingMatches = await ApiService.getMatches(
      parameters: {
        "action": "get_events",
        "timezone": "Asia/Karachi",
        "from": DateUtility.getApiFormat(now),
        "to": DateUtility.getApiFormat(now),
      },
    );
    _upcomingMatches = upcomingMatches.where((match) => isUpcoming(match, now)).toList();
    notifyListeners();
  }

  bool isUpcoming(Events match, DateTime now) {
    DateTime today = DateTime(now.year, now.month, now.day);
    print(today == match.matchDate);
    return today == match.matchDate;
  }
}