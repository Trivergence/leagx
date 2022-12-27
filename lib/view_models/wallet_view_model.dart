import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:leagx/core/network/app_url.dart';
import 'package:leagx/models/stripe_cred.dart';
import 'package:leagx/service/payment_service/payment_config.dart';
import 'package:leagx/service/payment_service/payment_exception.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:payments/models/error_model.dart';
import 'package:payments/payments.dart' hide ApiModels, ApiService;

import '../core/network/api/api_models.dart';
import '../core/network/api/api_service.dart';
import '../core/sharedpref/sharedpref.dart';
import '../core/viewmodels/base_model.dart';
import '../models/customer_cred.dart';
import '../models/user/user.dart';

class WalletViewModel extends BaseModel {
  List<PayMethod> _paymentMethods = [];

  List<PayMethod> get getPayementMethods => _paymentMethods;

  Future<void> getData() async {
    setBusy(true);
    if (StripeConfig().getSecretKey.isEmpty) {
      await setupStripeCredentials();
    }
    await getUserPaymentMethods();
  }

  Future<void> setupStripeCredentials({bool showToast = true}) async {
    if (StripeConfig().getSecretKey.isEmpty) {
      StripeCred? stripeCred = await ApiService.callGetApi(
          url: AppUrl.setupStripeCred,
          modelName: ApiModels.getStripeCred,
          showToast: showToast);
      if (stripeCred != null) {
        StripeConfig().setSecretkey(key: stripeCred.stripeSecret);
      }
    }
  }

  Future<void> getUserPaymentMethods(
      {save = false, bool showToast = true}) async {
    CustomerCred? customerCred = locator<PaymentConfig>().getCustomerCred;
    if (customerCred != null) {
      Result<ErrorModel, List<PayMethod>> result =
          await PayIn.getPaymentMethods(
              customerId: customerCred.customerId.toString());
      result.when((errorModel) {
        if (showToast == true) {
          handleError(errorModel);
        }
        setBusy(false);
      }, (paymentMethods) async {
        _paymentMethods = paymentMethods;
        if (_paymentMethods.isNotEmpty) {
          if (save == true) {
            await savePaymentId(paymentId: _paymentMethods.first.id!);
          } else {
            await updatePaymentId(paymentId: _paymentMethods.first.id!);
          }
        }
        setBusy(false);
      });
    } else {
      if (showToast == true) {
        ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.error);
      }
      setBusy(false);
    }
  }

  Future<void> removePaymentMethod() async {
    setBusy(true);
    try {
      String? paymentId =
          locator<PaymentConfig>().getCustomerCred!.paymentCardId;
      if (paymentId != null) {
        Result<String, bool> result =
            await PayIn.removePaymentMethod(paymentId: paymentId);
        result.when((errorCode) {
          PaymentExceptions.handleException(errorCode: errorCode);
          setBusy(false);
        }, (isSuccesful) {
          if (isSuccesful) _paymentMethods = [];
          setBusy(false);
        });
      } else {
        ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.error);
        setBusy(false);
      }
    } on Exception catch (_) {
      setBusy(false);
    }
  }

  Future<bool> purchaseIndirectly({
    required String amount,
    required String currency,
  }) async {
    try {
      bool success = false;
      String? _secretKey;
      String? customerId = locator<PaymentConfig>().getCustomerCred!.customerId;
      if (customerId != null) {
        Result<ErrorModel, String?> result =
            await PayIn.createIndirectPaymentIntent(
                customerId: customerId, amount: amount, currency: currency);
        result.when((errorModel) {
          handleError(errorModel);
          success = false;
        }, (secretKey) async {
          if (secretKey != null) {
            _secretKey = secretKey;
          }
        });
        if (_secretKey != null) {
          await Stripe.instance.initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: _secretKey,
                  merchantDisplayName: loc.appName,
                  customerId: customerId,
                  style: ThemeMode.dark));
          await Stripe.instance.presentPaymentSheet();
          await getUserPaymentMethods(save: true);
          success = true;
        }
        return success;
      } else {
        Loader.hideLoader();
        ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.error);
        return success;
      }
    } on Exception catch (_) {
      Loader.hideLoader();
      return false;
    }
  }

  Future<bool> purchaseDirectly({
    required String amount,
    required String currency,
  }) async {
    bool success = false;
    String? customerId = locator<PaymentConfig>().getCustomerCred!.customerId;
    if (customerId != null) {
      Result<ErrorModel, bool> result = await PayIn.createDirectPaymentIntent(
          customerId: customerId,
          amount: amount,
          currency: currency,
          paymentMethodId: _paymentMethods.first.id!);
      result.when(
        (errorModel) {
          handleError(errorModel);
          success = false;
        },
        (isSuccessfull) => success = isSuccessfull,
      );
    } else {
      ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.error);
    }
    return success;
  }

  Future<void> addPaymentMethod() async {
    String? customerId = locator<PaymentConfig>().getCustomerCred!.customerId;
    if (customerId != null) {
      Result<ErrorModel, String?> result =
          await PayIn.createSetupIntent(customerId: customerId);
      result.when((errorModel) => handleError(errorModel), (secretKey) async {
        if (secretKey != null) {
          try {
            await Stripe.instance.initPaymentSheet(
                paymentSheetParameters: SetupPaymentSheetParameters(
                    setupIntentClientSecret: secretKey,
                    merchantDisplayName: 'LeagX',
                    customerId: customerId,
                    style: ThemeMode.dark));
            await Stripe.instance.presentPaymentSheet();
            setBusy(true);
            await getUserPaymentMethods(save: true);
            setBusy(false);
          } on Exception catch (_) {
            Loader.hideLoader();
            setBusy(false);
          }
        }
      });
    } else {
      ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.error);
    }
  }

  Future<void> createCustomer(
      {required User userData, bool showToast = true}) async {
    if (StripeConfig().getSecretKey.isNotEmpty) {
      Result<ErrorModel, Customer> customer = await PayIn.createCustomer(
          userId: userData.id.toString(),
          userName: userData.firstName!,
          userEmail: userData.email);
      customer.when((errorModel) {
        handleError(errorModel);
      }, (customer) async => await saveCustomerId(userData.id, customer.id));
    } else {
      if (showToast == true) {
        ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.error);
      }
      await setupStripeCredentials(showToast: showToast);
    }
  }

  Future<void> saveCustomerId(int userId, String? customerId) async {
    CustomerCred? customerCred = await ApiService.callPostApi(
        url: AppUrl.getPaymentAccounts,
        body: {
          "payment_account": {"user_id": userId, "customer_id": customerId}
        },
        modelName: ApiModels.paymentAccounts);
    if (customerCred != null) {
      locator<PaymentConfig>().setCustomerCred = customerCred;
    }
  }

  Future<void> savePaymentId({String? paymentId}) async {
    CustomerCred? savedCred = locator<PaymentConfig>().getCustomerCred;
    if (savedCred != null) {
      CustomerCred? customerCred = await ApiService.callPutApi(
          url: AppUrl.getPaymentAccounts + "/" + savedCred.id.toString(),
          body: {
            "payment_account": {"payment_card_id": paymentId}
          },
          modelName: ApiModels.paymentAccount);
      if (customerCred != null) {
        locator<PaymentConfig>().setCustomerCred = customerCred;
      }
    }
  }

  Future<void> updatePaymentId({required String paymentId}) async {
    CustomerCred? savedCred = locator<PaymentConfig>().getCustomerCred;
    if (savedCred != null) {
      String completeUrl =
          AppUrl.getPaymentAccounts + "/" + savedCred.id.toString();
      CustomerCred? customerCred = await ApiService.callPutApi(
          url: completeUrl,
          body: {
            "payment_account": {"payment_card_id": paymentId}
          },
          modelName: ApiModels.paymentAccount);
      if (customerCred != null) {
        locator<PaymentConfig>().setCustomerCred = customerCred;
      }
    }
  }

  Future<bool> purchaseCoin(String numOfCoins) async {
    bool success = false;
    if (_paymentMethods.isEmpty) {
      success = await purchaseIndirectly(amount: numOfCoins, currency: "usd");
    } else {
      success = await purchaseDirectly(amount: numOfCoins, currency: "usd");
    }
    if (success == true) {
      success = await addCoins(amountInDollars: numOfCoins);
    }
    return success;
  }

  Future<bool> addCoins({
    required String amountInDollars,
    String? payInToken,
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
          "payment_token": payInToken,
          "payment_type": "StripePayIn",
          "amount": amountInDollars
        }
      });
    } else {
      ToastMessage.show(loc.somethingWentWrong, TOAST_TYPE.msg);
    }
    return success;
  }

  void handleError(ErrorModel errorModel) {
    if (errorModel.error!.code != null) {
      PaymentExceptions.handleException(errorCode: errorModel.error!.code!);
    } else {
      ToastMessage.show(errorModel.error!.message!, TOAST_TYPE.error);
    }
  }

  clearData() => _paymentMethods = [];
}
