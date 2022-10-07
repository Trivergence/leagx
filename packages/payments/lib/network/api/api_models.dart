

part of payments;

class ApiModels {
  //static const String error = 'Error';
  static const String customer = "CUSTOMER";
  static const String getPaymentMethods = "GET_PAYMENT_METHODS";
  static dynamic getModelObjects(String modelName, dynamic json) {
    switch (modelName) {
      // case error:
      //   return ErrorModel.fromJson(json);
      case customer:
        return Customer.fromJson(json);
      case getPaymentMethods:
        return PaymentMethods.fromJson(json);
    }
  }

  // static dynamic getListOfObjects(String modelName, dynamic json) {
  //   switch (modelName) {
  //     case upcomingMatches:
  //       return fixturesFromJson(json);
  //     case getLeagues:
  //       return leagueFromJson(json);
  //     case getTeams:
  //       return teamFromJson(json).first.players;
  //     case getPlans:
  //       return subscriptionPlanFromJson(json);
  //     case getNews:
  //       return newsFromJson(json);
  //     case getLeaders:
  //       return leaderFromJson(json);
  //     case getSubscribedLeagues:
  //       return subscribedLeagueFromJson(json);
  //     case getPredictions:
  //       return predictionFromJson(json);
  //   }
  // }
}
