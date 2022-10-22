

part of payments;

class ApiModels {
  //static const String error = 'Error';
  static const String customer = "CUSTOMER";
  static const String getPaymentMethods = "GET_PAYMENT_METHODS";
  static const String createSetupIntent = "create_setup_intent";
  static const String createPaymentIntent = "create_payment_intent";
  static const String createExpressAccount = "create_express_account";
  static const String createAccountLink = "create_account_link";
  static const String createTransfer = "create_transfer";
  static const String createPayout = "create_payout";
  static const String error = "error";

  static dynamic getModelObjects(String modelName, dynamic json) {
    switch (modelName) {
      case error:
        return ErrorModel.fromJson(json);
      case customer:
        return Customer.fromJson(json);
      case getPaymentMethods:
        return PaymentMethods.fromJson(json);
      case createSetupIntent:
        return SetupIntent.fromJson(json);
      case createPaymentIntent:
        return PaymentIntent.fromJson(json);
      case createExpressAccount:
        return ExpressAccount.fromJson(json);
      case createTransfer:
        return Transfer.fromJson(json);
      case createPayout:
      return PayoutModel.fromJson(json);
      case createAccountLink:
        return AccountLink.fromJson(json);
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
