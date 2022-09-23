import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/core/viewmodels/base_model.dart';
import 'package:leagx/models/dashboard/events.dart';
import 'package:leagx/models/subscribed_league.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/util/utility/date_utility.dart';

import '../core/network/app_url.dart';
import '../models/user/user.dart';

class DashBoardViewModel extends BaseModel {

  List<Fixture> _upcomingMatches = [];
  List<SubscribedLeague> _subscribedLeagues = [];
  List<int> _subscribedLeagueIds = [];
  List<Fixture> get upcomingMatches => _upcomingMatches;
  List<SubscribedLeague> get subscribedLeagues => _subscribedLeagues;
  List<int> get subscribedLeagueIds => _subscribedLeagueIds;
  Future<void> getData() async {
    await getUserLeagues();
    await getUpcomingMatches();
  }

  Future<void> getUpcomingMatches() async {
     DateTime now = DateTime.now();
     _upcomingMatches = await ApiService.getMatches(
      parameters: {
        "action": "get_events",
        "timezone": "Asia/Karachi",
        "league_id": subscribedLeagueIds.join(","),
        "from": DateUtility.getApiFormat(now),
        "to": DateUtility.getApiFormat(now),
      },
    );
    _upcomingMatches = upcomingMatches.where((match) => isUpcoming(match, now)).toList();
    notifyListeners();
  }

  Future<void> getUserLeagues() async {
    User? user = locator<SharedPreferenceHelper>().getUser();
    String completeUrl = AppUrl.getUser + "${user!.id}" + "/subscribed_leagues";
    _subscribedLeagues = await ApiService.getUserLeagues(url: completeUrl);
    _subscribedLeagueIds = getSubscribedIds();
  }

  List<int> getSubscribedIds() {
    return _subscribedLeagues
        .map((league) => league.externalLeagueId)
        .toList();
  }

  bool isUpcoming(Fixture match, DateTime now) {
    DateTime today = DateTime(now.year, now.month, now.day);
    return today == match.matchDate;
  }
}