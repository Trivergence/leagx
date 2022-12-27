import 'package:flutter/material.dart';
import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/core/utility.dart';
import 'package:leagx/core/viewmodels/base_model.dart';
import 'package:leagx/models/dashboard/fixture.dart';
import 'package:leagx/models/subscribed_league.dart';
import 'package:leagx/models/user_summary.dart';
import 'package:leagx/service/payment_service/payment_config.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/view_models/auth_view_model.dart';
import 'package:leagx/view_models/wallet_view_model.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../constants/enums.dart';
import '../core/network/app_url.dart';
import '../core/sharedpref/sharedpref.dart';
import '../models/customer_cred.dart';
import '../models/dashboard/news.dart';
import '../models/leader.dart';
import '../models/user/user.dart';
import '../ui/util/utility/date_utility.dart';

class DashBoardViewModel extends BaseModel {
  UserSummary? _userSummary;
  List<Fixture> _subscribedMatches = [];
  List<Fixture> _filteredMatches = [];
  List<SubscribedLeague> _subscribedLeagues = [];
  List<News> _news = [];
  List<Leader> _leaders = [];
  List<int> _subscribedLeagueIds = [];
  bool _isInitialized = false;
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  List<SubscribedLeague> get subscribedLeagues => _subscribedLeagues;
  List<Fixture> get subscribedMatches => _subscribedMatches;
  List<Fixture> get filteredMatches => _filteredMatches;
  List<int> get subscribedLeagueIds => _subscribedLeagueIds;
  List<News> get getNews => _news;
  List<Leader> get getLeaders => _leaders;
  UserSummary? get userSummary => _userSummary;
  bool get isInitialized => _isInitialized;

  setLoading(bool value) {
    _isLoading = value;
    notify();
  }

  Future<void> getData(BuildContext context, {bool showToast = true}) async {
    if (_isLoading == false) {
      setLoading(true);
    }
    try {
      await getSubscribedLeagues(showToast: showToast);
      await getAllLeaders(showToast: showToast);
      await getUserSummary(showToast: showToast);
      await getSubscribedMatches(showToast: showToast);
      setLoading(false);
      if (subscribedLeagues.isNotEmpty) {
        await getAllNews(showToast: showToast);
      }
    } on Exception catch (_) {
      setLoading(false);
    }
  }

  void initializationComplete() {
    _isInitialized = true;
  }

  Future<void> getAllFixtures() async {
    await getSubscribedMatches();
  }

  Future<void> getSubscribedMatches({bool showToast = true}) async {
    // "from": DateUtility.getApiFormat(now),
    //       "to": DateUtility.getApiFormat(now.add(const Duration(days: 3))),
    if (subscribedLeagueIds.isNotEmpty) {
      try {
        DateTime now = DateTime.now();
        String currentTimeZone = await Utility.getTzName();
        List<dynamic> tempList = await ApiService.getListRequest(
            requestType: RequestType.footballApi,
            baseUrl: AppUrl.baseUrl + AppUrl.getSubscribedMatches,
            modelName: ApiModels.upcomingMatches,
            parameters: {
              //"APIkey": AppConstants.footballApiKey,
              // "action": "get_events",
              "timezone": currentTimeZone,
              "league_id": subscribedLeagueIds.join(","),
              "from": "2022-01-01",
              "to": "2022-12-30",
            },
            cache: true,
            cacheBoxName: AppConstants.subscribedMatchesBoxName,
            showToast: showToast);
        _subscribedMatches = tempList.cast<Fixture>();
        // _subscribedMatches
        //     .sort((fixture1, fixture2) => sortMatchesDesc(fixture1, fixture2));
        // _subscribedMatches =
        //     _subscribedMatches.where((match) => isValid(match, now)).toList();
      } on Exception catch (_) {
        setLoading(false);
      }
    } else {
      _subscribedMatches = [];
    }
  }

  Future<void> getSubscribedLeagues({bool showToast = true}) async {
    try {
      User? user = locator<SharedPreferenceHelper>().getUser();
      String completeUrl =
          AppUrl.getUser + "${user!.id}" + "/subscribed_leagues";
      List<dynamic> tempList = await ApiService.getListRequest(
          baseUrl: AppUrl.baseUrl,
          url: completeUrl,
          headers: {
            "apitoken": preferenceHelper.authToken,
          },
          modelName: ApiModels.getSubscribedLeagues,
          cache: true,
          cacheBoxName: AppConstants.subscribedLeaguesBoxName,
          showToast: showToast);
      _subscribedLeagues = tempList.cast<SubscribedLeague>();
      _subscribedLeagueIds = getSubscribedIds();
      if (subscribedLeagueIds.isEmpty) {
        await subscribeDefaultLeague(user.id);
      }
    } on Exception catch (_) {
      setLoading(false);
    }
  }

  List<int> getSubscribedIds() {
    return _subscribedLeagues.map((league) => league.externalLeagueId).toList();
  }

  bool isValid(Fixture match, DateTime now) {
    String matchStatus = match.matchStatus!;
    if (matchStatus == MatchStatus.finished.value ||
            matchStatus == MatchStatus.afterExTime.value ||
            matchStatus == MatchStatus.afterPanalty.value ||
            matchStatus == MatchStatus.cancelled.value ||
            matchStatus == MatchStatus.awarded.value
        //match.matchDate.isBefore(now)
        ) {
      return false;
    }
    return true;
  }

  int? getLeagueInternalId(String externalId) {
    try {
      List<SubscribedLeague> listOfLeague = _subscribedLeagues
          .where((league) => league.externalLeagueId.toString() == externalId)
          .toList();
      if (listOfLeague.isNotEmpty) {
        return listOfLeague.first.id;
      } else {
        return null;
      }
    } on Exception catch (_) {
      setLoading(false);
      return null;
    }
  }

  Future<void> addNews(
      {required BuildContext context,
      required String desc,
      required String matchId,
      required String leagueId}) async {
    User? user = locator<SharedPreferenceHelper>().getUser();
    int? internalLeagueId = getLeagueInternalId(leagueId);
    if (user != null && internalLeagueId != null) {
      try {
        Loader.showLoader();
        Map<String, dynamic> requestBody = {
          "news": {
            "title": "LeagX",
            "description": desc,
            "user_id": user.id,
            "league_id": internalLeagueId,
            "match_id": int.parse(matchId)
          }
        };
        bool success = await ApiService.postWoResponce(
            url: AppUrl.addNews, body: requestBody);
        if (success) {
          Loader.hideLoader();
          ToastMessage.show(
              loc.dashboardNewsAddNewsTxtSuccess, TOAST_TYPE.success);
          Navigator.of(context).pop();
          await getAllNews();
          notifyListeners();
        } else {
          ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.error);
        }
      } on Exception catch (_) {
        setLoading(false);
      }
    }
  }

  Future<void> getAllNews({bool showToast = true}) async {
    User? user = locator<SharedPreferenceHelper>().getUser();
    if (user != null) {
      try {
        String completeUrl =
            AppUrl.getUser + user.id.toString() + AppUrl.subscribedNews;
        List<dynamic> tempList = await ApiService.getListRequest(
            baseUrl: AppUrl.baseUrl,
            url: completeUrl,
            headers: {
              "apitoken": preferenceHelper.authToken,
            },
            modelName: ApiModels.getNews,
            cache: true,
            cacheBoxName: AppConstants.getNewsBoxName,
            showToast: showToast);
        _news = tempList.cast<News>();
      } on Exception catch (_) {
        setLoading(false);
      }
    }
  }

  Future<void> getAllLeaders({bool showToast = true}) async {
    try {
      String completeUrl = AppUrl.getUser + AppUrl.getLeaders;
      List<dynamic> tempList = await ApiService.getListRequest(
          baseUrl: AppUrl.baseUrl,
          url: completeUrl,
          modelName: ApiModels.getLeaders,
          headers: {
            "apitoken": preferenceHelper.authToken,
          },
          cache: true,
          cacheBoxName: AppConstants.getLeadersBoxName,
          showToast: showToast);
      _leaders = tempList.cast<Leader>();
      //_subscribedMatches.sort((fixture1, fixture2) => sortMatches(fixture1, fixture2));
      _leaders.sort((leader1, leader2) => sortLeader(leader1, leader2));
    } on Exception catch (_) {
      setLoading(false);
    }
  }

  notify() {
    notifyListeners();
  }

  List<News> getNewsbyLeague(String externalId) {
    try {
      int? id = getLeagueInternalId(externalId);
      if (id == null) {
        return [];
      } else {
        return _news.where((newsItems) => newsItems.leagueId == id).toList();
      }
    } on Exception catch (_) {
      setLoading(false);
      return [];
    }
  }

  getUserSummary({bool showToast = true}) async {
    User? user = preferenceHelper.getUser();
    if (user != null) {
      String completeUrl = AppUrl.getUser + user.id.toString();
      _userSummary = await ApiService.callGetApi(
        url: completeUrl,
        modelName: ApiModels.userSummary,
        cache: true,
        cacheBoxName: AppConstants.userSummaryBoxName,
      );
      notify();
    }
  }

  Future<void> getPaymentCredentials(BuildContext context,
      {bool showToast = true}) async {
    User? user = preferenceHelper.getUser();
    if (user != null && locator<PaymentConfig>().getCustomerCred == null) {
      List<dynamic> tempList = await ApiService.getListRequest(
          baseUrl: AppUrl.baseUrl,
          url: AppUrl.getPaymentAccounts,
          modelName: ApiModels.paymentAccounts,
          headers: {
            "apitoken": preferenceHelper.authToken,
          },
          showToast: showToast);
      List<CustomerCred> listOfCred = tempList
          .cast<CustomerCred>()
          .where((userCred) => userCred.userId == user.id)
          .toList();
      if (listOfCred.isNotEmpty) {
        locator<PaymentConfig>().setCustomerCred = listOfCred
            .where((userCred) => userCred.userId == user.id)
            .toList()
            .first;
      } else {
        context
            .read<WalletViewModel>()
            .createCustomer(userData: user, showToast: showToast);
      }
    }
  }

  clearData() {
    _subscribedMatches = [];
    _subscribedLeagues = [];
    _news = [];
    _subscribedLeagueIds = [];
  }

  // TODO remove this later
  Future<void> subscribeDefaultLeague(int userId) async {
    bool success = await AuthViewModel.subscribeOneLeague(userId);
    if (success) {
      await getSubscribedLeagues();
    }
  }

  void filterByLeague({required String leagueId}) async {
    _filteredMatches = _subscribedMatches
        .where((match) => match.leagueId == leagueId)
        .toList();
  }

  int sortMatchesDesc(Fixture fixture1, Fixture fixture2) {
    DateTime refinedTime1 = DateUtility.parseTime(fixture1.matchTime);
    DateTime refinedTime2 = DateUtility.parseTime(fixture2.matchTime);
    if (fixture2.matchDate.compareTo(fixture1.matchDate) > 0) {
      return 1;
    } else if (fixture2.matchDate.compareTo(fixture1.matchDate) < 0) {
      return -1;
    } else {
      if (refinedTime2.compareTo(refinedTime1) > 0) {
        return 1;
      }
      if (refinedTime2.compareTo(refinedTime1) < 0) {
        return -1;
      } else {
        return 0;
      }
    }
  }

  int sortMatchesAsce(Fixture fixture1, Fixture fixture2) {
    DateTime refinedTime1 = DateUtility.parseTime(fixture1.matchTime);
    DateTime refinedTime2 = DateUtility.parseTime(fixture2.matchTime);
    if (fixture1.matchDate.compareTo(fixture2.matchDate) > 0) {
      return 1;
    } else if (fixture1.matchDate.compareTo(fixture2.matchDate) < 0) {
      return -1;
    } else {
      if (refinedTime1.compareTo(refinedTime2) > 0) {
        return 1;
      }
      if (refinedTime1.compareTo(refinedTime2) < 0) {
        return -1;
      } else {
        return 0;
      }
    }
  }

  int sortLeader(Leader leader1, Leader leader2) {
    return leader2.predictionSuccessRate!
        .compareTo(leader1.predictionSuccessRate!);
  }

  scrollList(
      {required ScrollController scrollController,
      ScrollDirection scrollDirection = ScrollDirection.forward}) async {
    if (scrollDirection == ScrollDirection.forward) {
      if (scrollController.position.pixels <
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        await scrollController.animateTo(scrollController.position.pixels + 100,
            duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
      }
    } else {
      if (scrollController.position.pixels >
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        await scrollController.animateTo(scrollController.position.pixels - 100,
            duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
      }
    }
  }

  List<Fixture> getFinishedMatches(List<Fixture> matches) {
    List<Fixture> _matches;
    _matches = matches
        .where((matchItem) => Utility.isMatchOver(matchItem.matchStatus!))
        .toList();
    _matches.sort((fixture1, fixture2) => sortMatchesDesc(fixture1, fixture2));
    return _matches;
  }

  List<Fixture> getUpcomingMatches(List<Fixture> matches) {
    List<Fixture> _matches;
    _matches =
        matches.where((matchItem) => isUpcomingMatch(matchItem)).toList();
    _matches.sort((fixture1, fixture2) => sortMatchesAsce(fixture1, fixture2));
    return _matches;
  }

  bool isUpcomingMatch(Fixture matchItem) {
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    if ((matchItem.matchDate == now || matchItem.matchDate.isAfter(now)) &&
        !Utility.isMatchOver(matchItem.matchStatus!)) {
      return true;
    } else {
      return false;
    }
  }
}
