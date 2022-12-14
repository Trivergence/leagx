import 'package:multiple_result/multiple_result.dart';
import 'package:payments/constants/payment_constants.dart';
import 'package:payments/models/account_link.dart';
import 'package:payments/models/error_model.dart';
import 'package:payments/models/express_account.dart';
import 'package:payments/models/payout_model.dart';
import 'package:payments/models/transfer.dart';
import 'package:payments/network/payment_url.dart';
import 'package:payments/payments.dart';

class PayOut {
  static Future<Result<ErrorModel, ExpressAccount>> createExpressAccount(
      {required String countryCode}) async {
    Map<String, dynamic> body;
    if (countryCode == "US") {
      body = {
        "type": 'express',
        "country": "US",
        "business_type": 'individual',
        "capabilities": {
          "card_payments": {"requested": false},
          "transfers": {"requested": true}
        },
      };
    } else {
      body = {
        "type": 'express',
        "country": countryCode,
        "business_type": 'individual',
        "capabilities": {
          "transfers": {"requested": true}
        },
        "tos_acceptance": {
          "service_agreement": 'recipient',
        },
      };
    }
    Result<ErrorModel, dynamic> result = await ApiService.callPostApi(
        url: PaymentUrl.accounts,
        body: body,
        modelName: ApiModels.createExpressAccount);
    return result.when((errorModel) => Error(errorModel), (responceModel) {
      ExpressAccount expressAccount = responceModel;
      return Success(expressAccount);
    });
  }

  static Future<Result<ErrorModel, ExpressAccount>> getAccount(
      String accountId) async {
    String completeUrl = PaymentUrl.accounts + "/" + accountId;
    Result<ErrorModel, dynamic> result = await ApiService.callPostApi(
        url: completeUrl, modelName: ApiModels.createExpressAccount);
    return result.when((errorModel) => Error(errorModel), (responceModel) {
      ExpressAccount expressAccount = responceModel;
      return Success(expressAccount);
    });
  }

  static Future<Result<ErrorModel, String>> createAccountLink(
      String accountId) async {
    var body = {
      "account": accountId,
      "refresh_url": PaymentConstants.refreshUrl,
      "return_url": PaymentConstants.returnUrl,
      "type": 'account_onboarding',
    };
    Result<ErrorModel, dynamic> result = await ApiService.callPostApi(
        url: PaymentUrl.accountLink,
        body: body,
        modelName: ApiModels.createAccountLink);

    return result.when((errorModel) => Error(errorModel), (responceModel) {
      AccountLink accountLink = responceModel;
      return Success(accountLink.url!);
    });
  }

  static Future<Result<ErrorModel, Transfer>> transfer(
      String amount, String accountId) async {
    var body = {
      "amount": (int.parse(amount) * 100).toString(),
      "currency": 'usd',
      "destination": accountId,
    };
    Result<ErrorModel, dynamic> result = await ApiService.callPostApi(
        url: PaymentUrl.transfers,
        body: body,
        modelName: ApiModels.createTransfer);
    return result.when((errorModel) => Error(errorModel), (responceModel) {
      Transfer transfer = responceModel;
      return Success(transfer);
    });
  }

  static Future<Result<ErrorModel, PayoutModel>> payout(
      String amount, String currency, String cardId, String accountId) async {
    var body = {
      "amount": double.parse(amount).round().toString(),
      "currency": currency,
    };
    Result<ErrorModel, dynamic> result = await ApiService.callPostApi(
        url: PaymentUrl.payouts,
        body: body,
        modelName: ApiModels.createPayout,
        headers: {"Stripe-Account": accountId});
    return result.when((errorModel) => Error(errorModel), (responceModel) {
      PayoutModel payoutModel = responceModel;
      return Success(payoutModel);
    });
  }
}
