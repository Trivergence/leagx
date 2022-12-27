import 'package:flutter/material.dart';
import 'package:leagx/core/sharedpref/sharedpref.dart';
import 'package:leagx/core/utility.dart';
import 'package:leagx/core/viewmodels/base_model.dart';
import 'package:leagx/models/currency.dart';
import 'package:leagx/service/payment_service/payment_exception.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/util/app_dialogs/verify_alert_dialog.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:payments/models/error_model.dart';
import 'package:payments/models/express_account.dart';
import 'package:payments/models/payout_model.dart';
import 'package:payments/models/transfer.dart';
import 'package:payments/pay_out.dart';

import '../core/network/api/api_models.dart';
import '../core/network/api/api_service.dart';
import '../core/network/app_url.dart';
import '../models/customer_cred.dart';
import '../models/user/user.dart';
import '../service/payment_service/payment_config.dart';
import '../ui/util/locale/localization.dart';

class PayoutViewModel extends BaseModel {
  ExpressAccount? _expressAccount;
  bool _payoutAvailable = true;

  ExpressAccount? get expressAccount => _expressAccount;
  bool get isPayoutAvailble => _payoutAvailable;

  Future<void> initializeData() async {
    setBusy(true);
    await createAccount();
    await getAccountDetails();
    setBusy(false);
  }

  Future<void> createAccount() async {
    CustomerCred? customerCred = locator<PaymentConfig>().getCustomerCred;
    if (customerCred != null && locator<PaymentConfig>().getAccountId == null) {
      String? countryCode = Utility.getCountryCode();
      if (countryCode != null) {
        Result<ErrorModel, ExpressAccount> result =
            await PayOut.createExpressAccount(countryCode: countryCode);
        result.when(
          (errorModel) => handleError(errorModel),
          (expressAccount) async =>
              await updateAccountId(accountId: expressAccount.id),
        );
      }
    }
  }

  Future<void> getAccountDetails() async {
    String? accountId = locator<PaymentConfig>().getAccountId;
    if (accountId != null) {
      Result<ErrorModel, ExpressAccount> result =
          await PayOut.getAccount(accountId);
      result.when(
        (errorModel) => handleError(errorModel),
        (expressAccount) => _expressAccount = expressAccount,
      );
    }
  }

  Future<bool> withdrawCoins({
    required String amountInDollars,
    required String payoutToken,
  }) async {
    bool success = false;
    User? user = preferenceHelper.getUser();
    CustomerCred? customerCred = locator<PaymentConfig>().getCustomerCred;
    if (user != null && customerCred != null) {
      success =
          await ApiService.postWoResponce(url: AppUrl.addPaymentToken, body: {
        "payment": {
          "user_id": user.id,
          "payment_account_id": customerCred.id,
          "payment_token": payoutToken,
          "payment_type": "StripePayOut",
          "amount": amountInDollars
        }
      });
    } else {
      ToastMessage.show(loc.somethingWentWrong, TOAST_TYPE.msg);
    }
    return success;
  }

  Future<String?> addBank() async {
    String? accountLink;
    await createAccount();
    String? accountId = locator<PaymentConfig>().getAccountId;
    if (accountId != null) {
      Result<ErrorModel, String> result =
          await PayOut.createAccountLink(accountId);
      result.when(
        (errorModel) => handleError(errorModel),
        (link) => accountLink = link,
      );
    } else {
      ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.error);
    }
    return accountLink;
  }

  Future<void> updateAccountId({required String accountId}) async {
    CustomerCred? savedCred = locator<PaymentConfig>().getCustomerCred;
    if (savedCred != null) {
      String completeUrl =
          AppUrl.getPaymentAccounts + "/" + savedCred.id.toString();
      CustomerCred? customerCred = await ApiService.callPutApi(
          url: completeUrl,
          body: {
            "payment_account": {"account_id": accountId}
          },
          modelName: ApiModels.paymentAccount);
      if (customerCred != null) {
        locator<PaymentConfig>().setCustomerCred = customerCred;
      }
    }
  }

  Future<PayoutModel?> payoutMoney(
    String amount,
    String currency,
    String bankId,
  ) async {
    PayoutModel? _payoutModel;
    String? convertedAmount =
        await convertAmount(from: "usd", to: currency, withdrawlAmount: amount);
    CustomerCred? savedCred = locator<PaymentConfig>().getCustomerCred;
    if (savedCred != null &&
        savedCred.accountId != null &&
        convertedAmount != null) {
      Result<ErrorModel, PayoutModel> result = await PayOut.payout(
          convertedAmount, currency, bankId, savedCred.accountId!);
      result.when(
        (errorModel) {
          handleError(errorModel);
          Loader.hideLoader();
        },
        (payoutModel) => _payoutModel = payoutModel,
      );
    } else {
      ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.error);
    }
    return _payoutModel;
  }

  Future<bool> transferToUser(
    String amount,
  ) async {
    bool success = false;
    CustomerCred? savedCred = locator<PaymentConfig>().getCustomerCred;
    if (savedCred != null && savedCred.accountId != null) {
      Result<ErrorModel, Transfer> result =
          await PayOut.transfer(amount, savedCred.accountId!);
      result.when((errorModel) {
        Loader.hideLoader();
        handleError(errorModel);
      }, (_) => success = true);
    } else {
      ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.error);
    }
    return success;
  }

  Future<String?> convertAmount(
      {required String from,
      required String to,
      required String withdrawlAmount}) async {
    String? amount;
    Currency? currency = await ApiService.callCurrencyConverter(
        url: AppUrl.convert,
        parameters: {
          "format": "json",
          "from": from.toUpperCase(),
          "to": to.toUpperCase(),
          "amount": withdrawlAmount
        },
        modelName: ApiModels.getCurrencyAmount);
    if (currency != null) {
      amount = currency.rates.values.toList().first["rate_for_amount"];
    }
    Loader.hideLoader();
    return amount;
  }

  Future<void> updateCoins(DashBoardViewModel dashBoardViewModel) async {
    setBusy(true);
    await dashBoardViewModel.getUserSummary();
    setBusy(false);
  }

  void handleError(ErrorModel errorModel) {
    if (errorModel.error!.code != null) {
      if (errorModel.error!.code == "country_unsupported") {
        _payoutAvailable = false;
      } else {
        PaymentExceptions.handleException(errorCode: errorModel.error!.code!);
      }
    } else {
      ToastMessage.show(errorModel.error!.message!, TOAST_TYPE.error);
    }
  }

  clearData() => _expressAccount = null;

  void showVerificationDialog(BuildContext context) {
    if (_expressAccount != null &&
        _expressAccount!.requirements != null &&
        _expressAccount!.requirements!.eventuallyDue.isNotEmpty) {
      VerificationAlertDialog.show(
          context: context,
          title: "Verification Required",
          listOfRequirements: _expressAccount!.requirements!.eventuallyDue,
          negativeBtnTitle: "Later",
          positiveBtnTitle: "Upload Now",
          onPositiveBtnPressed: (dialogContext) {});
    }
  }
}
