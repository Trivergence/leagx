import 'package:leagx/models/auth/forgot_password.dart';
import 'package:leagx/models/dashboard/fixture.dart';
import 'package:leagx/models/dashboard/league.dart';
import 'package:leagx/models/error_model.dart';
import 'package:leagx/models/leader.dart';
import 'package:leagx/models/players.dart';
import 'package:leagx/models/user/user.dart';
import 'package:leagx/models/user/userdata.dart';

import '../../../models/dashboard/news.dart';
import '../../../models/subscribed_league.dart';
import '../../../models/subscription_plan.dart';

class ApiModels {
  static const String error = 'Error';
  static const String forgotPassword = "FORGOT_PASSWORD";
  static const String user = "USER";
  static const String upcomingMatches = "UPCOMING_MATCHES";
  static const String getLeagues = "GET_LEAGUES";
  static const String getNews = "GET_NEWS";
  static const String getTeams = "GET_TEAM";
  static const String getPlans = "GET_PLANS";
  static const String getLeaders = "GET_LEADERS";
  static const String getSubscribedLeagues = "GET_SUBSCRIBED_LEAGUE";
  static const String userData = "USERDATA";
  static dynamic getModelObjects(String modelName, dynamic json) {
    switch (modelName) {
      case error:
        return ErrorModel.fromJson(json);
      case forgotPassword:
        return ForgotPassword.fromJson(json);
      case user:
        return User.fromJson(json);
      case userData:
        return UserData.fromJson(json);
    }
  }
  static dynamic getListOfObjects(String modelName, dynamic json) {
    switch (modelName) {
      case upcomingMatches:
        return fixturesFromJson(json);
      case getLeagues:
        return leagueFromJson(json);
      case getTeams:
        return teamFromJson(json).first.players;
      case getPlans:
        return subscriptionPlanFromJson(json);
      case getNews:
      return newsFromJson(json);
      case getLeaders:
        return leaderFromJson(json);
      case getSubscribedLeagues:
        return subscribedLeagueFromJson(json);
    }
  }
}
