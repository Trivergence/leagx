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


  List<SubscribedLeague> get subscribedLeagues => _subscribedLeagues;
  List<Fixture> get subscribedMatches => _subscribedMatches;
  List<Fixture> get filteredMatches => _filteredMatches;
  List<int> get subscribedLeagueIds => _subscribedLeagueIds;
  List<News> get getNews => _news;
  List<Leader> get getLeaders => _leaders;
  UserSummary? get userSummary => _userSummary;
  bool get isInitialized => _isInitialized;

  Future<void> getData(BuildContext context,{bool showToast = true}) async {
    setBusy(true);
    try {
      await getSubscribedLeagues(showToast: showToast);
      await getAllLeaders(showToast: showToast);
      await getUserSummary(showToast: showToast);
      await getSubscribedMatches(showToast: showToast);
      setBusy(false);
      if (subscribedLeagues.isNotEmpty) {
        await getAllNews(showToast: showToast);
      }
    } on Exception catch (_) {
      setBusy(false);
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
          baseUrl: AppUrl.footballBaseUrl,
          modelName: ApiModels.upcomingMatches,
          parameters: {
            "APIkey": AppConstants.footballApiKey,
            "action": "get_events",
            "timezone": currentTimeZone,
            "league_id": subscribedLeagueIds.join(","),
            "from": "2022-01-01",
            "to": "2022-12-30",
          },
          cache: true,
          cacheBoxName: AppConstants.subscribedMatchesBoxName,
          showToast: showToast
        );
        _subscribedMatches = tempList.cast<Fixture>();
        _subscribedMatches.sort((fixture1, fixture2) => sortMatches(fixture1, fixture2));
        // _subscribedMatches =
        //     _subscribedMatches.where((match) => isValid(match, now)).toList();
      } on Exception catch (_) {
        setBusy(false);
      }
    } else {
      _subscribedMatches = [];
    }
    notifyListeners();
  }

  Future<void> getSubscribedLeagues({bool showToast = true}) async {
    try {
      User? user = locator<SharedPreferenceHelper>().getUser();
      String completeUrl = AppUrl.getUser + "${user!.id}" + "/subscribed_leagues";
      List<dynamic> tempList = await ApiService.getListRequest(
          baseUrl: AppUrl.baseUrl,
          url: completeUrl,
          headers: {
            "apitoken": preferenceHelper.authToken,
          },
          modelName: ApiModels.getSubscribedLeagues,
          cache: true,
          cacheBoxName: AppConstants.subscribedLeaguesBoxName,
          showToast: showToast
        );
      _subscribedLeagues = tempList.cast<SubscribedLeague>();
      _subscribedLeagueIds = getSubscribedIds();
      if (subscribedLeagueIds.isEmpty) {
        await subscribeDefaultLeague(user.id);
      }
    } on Exception catch (_) {
      setBusy(false);
    }
  }

  List<int> getSubscribedIds() {
    return _subscribedLeagues.map((league) => league.externalLeagueId).toList();
  }

  bool isValid(Fixture match, DateTime now) {
    String matchStatus = match.matchStatus!;
    if (matchStatus == "Fisnished" ||
            matchStatus == "After ET" ||
            matchStatus == "After Pen." ||
            matchStatus == "Cancelled" ||
            matchStatus == "Awarded"
        //match.matchDate.isBefore(now)
        ) {
      return false;
    }
    return true;
  }

  int? getLeagueInternalId(String externalId) {
    try {
      List<SubscribedLeague> listOfLeague = _subscribedLeagues.where((league) => league.externalLeagueId.toString() == externalId).toList();
      if (listOfLeague.isNotEmpty) {
        return listOfLeague.first.id;
      } else {
        return null;
      }
    } on Exception catch (_) {
      setBusy(false);
      return null;
    }
  }

  Future<void> addNews({required BuildContext context, required String desc, required String matchId, required String leagueId}) async {
    User? user = locator<SharedPreferenceHelper>().getUser();
    int? internalLeagueId = getLeagueInternalId(leagueId);
    if (user != null && internalLeagueId != null) {
      try {
        Loader.showLoader();
        Map<String, dynamic> requestBody = {
          "news": {"title": "LeagX", "description": desc, "user_id": user.id, "league_id": internalLeagueId, "match_id": int.parse(matchId)}
        };
        bool success = await ApiService.postWoResponce(url: AppUrl.addNews, body: requestBody);
        if (success) {
          Loader.hideLoader();
          ToastMessage.show(loc.dashboardNewsAddNewsTxtSuccess, TOAST_TYPE.success);
          Navigator.of(context).pop();
          await getAllNews();
          notifyListeners();
        } else {
          ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.error);
        }
      } on Exception catch (_) {
        setBusy(false);
      }
    }
  }

  Future<void> getAllNews({bool showToast = true}) async {
    User? user = locator<SharedPreferenceHelper>().getUser();
    if (user != null) {
      try {
        String completeUrl = AppUrl.getUser + user.id.toString() + AppUrl.subscribedNews;
        List<dynamic> tempList = await ApiService.getListRequest(
            baseUrl: AppUrl.baseUrl,
            url: completeUrl,
            headers: {
              "apitoken": preferenceHelper.authToken,
            },
            modelName: ApiModels.getNews,
            cache: true,
            cacheBoxName: AppConstants.getNewsBoxName,
            showToast: showToast
          );
        _news = tempList.cast<News>();
      } on Exception catch (_) {
        setBusy(false);
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
        showToast: showToast
      );
      _leaders = tempList.cast<Leader>();
    } on Exception catch (_) {
      setBusy(false);
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
      setBusy(false);
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

  Future<void> getPaymentCredentials(BuildContext context, {bool showToast = true}) async {
    User? user = preferenceHelper.getUser();
    if (user != null && locator<PaymentConfig>().getCustomerCred == null) {
      List<dynamic> tempList = await ApiService.getListRequest(
        baseUrl: AppUrl.baseUrl,
        url: AppUrl.getPaymentAccounts,
        modelName: ApiModels.paymentAccounts,
        headers: {
          "apitoken": preferenceHelper.authToken,
        },
        showToast: showToast
      );
      List<CustomerCred> listOfCred = tempList.cast<CustomerCred>().where((userCred) => userCred.userId == user.id).toList();
      if (listOfCred.isNotEmpty) {
        locator<PaymentConfig>().setCustomerCred = listOfCred.where((userCred) => userCred.userId == user.id).toList().first;
      } else {
        context.read<WalletViewModel>().createCustomer(userData: user, showToast: showToast);
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
    _filteredMatches = _subscribedMatches.where((match) => match.leagueId == leagueId).toList();
  }

  int sortMatches(Fixture fixture1, Fixture fixture2) {
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
}
