import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:leagx/core/secure_storage/secure_storage.dart';
import 'package:leagx/service/payment_service/payment_exception.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:payments/payments.dart';

import '../core/viewmodels/base_model.dart';

class WalletViewModel extends BaseModel {
  List<PayMethod> _paymentMethods = [];

  List<PayMethod> get getPayementMethods => _paymentMethods;

  getData() async {
    setBusy(true);
    await getUserPaymentMethods();
  }


  Future<void> getUserPaymentMethods() async{
    String? customerId = await locator<SecureStore>().getCustomerId();
    if(customerId != null) {
      Result<String, List<PayMethod>> result= await PayIn.getPaymentMethods(customerId: customerId);
      result.when((errorCode) {
        PaymentExceptions.handleException(errorCode: errorCode);
        setBusy(false);
      }, (paymentMethods) {
        _paymentMethods = paymentMethods;
        if (_paymentMethods.isNotEmpty) {
          locator<SecureStore>().savePaymentId(_paymentMethods.first.id!);
          setBusy(false);
        }
      });
    }
  }
  Future<void> removePaymentMethod() async {
    setBusy(true);
    try {
      String? paymentId = await locator<SecureStore>().getPaymentId();
      if (paymentId != null) {
        Result<String, bool> result = await PayIn.removePaymentMethod(paymentId: paymentId);
        result.when((errorCode) {
          PaymentExceptions.handleException(errorCode: errorCode);
          setBusy(false);
        }, (isSuccesful) {
          if (isSuccesful) _paymentMethods = [];
          setBusy(false);
        });
      }
    } on Exception catch (_) {
      setBusy(false);
    }
  }
  Future<bool> purchaseIndirectly({
    required String amount,
    required String currency,
    }) async{
      try {
        bool success = false;
        String? customerId = await locator<SecureStore>().getCustomerId();
        if(customerId != null) {
        Result<String, String?> result = await  PayIn.createIndirectPaymentIntent(
         customerId: customerId,
         amount: amount,
         currency: currency);
         result.when((errorCode) {
            PaymentExceptions.handleException(errorCode: errorCode);
            success = false;
         }, (secretKey) async {
        if (secretKey != null) {
            await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: secretKey,
              customerId: customerId,
              style: ThemeMode.dark));
            await Stripe.instance.presentPaymentSheet();
            await getUserPaymentMethods();
            success = true;
          }
         });
         return success;
        } else {
          ToastMessage.show(loc.somethingWentWrong, TOAST_TYPE.error);
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
    String? customerId = await locator<SecureStore>().getCustomerId();
    if (customerId != null) {
        Result<String, bool> result = await PayIn.createDirectPaymentIntent(
        customerId: customerId, 
        amount: amount,
        currency: currency, 
        paymentMethodId: _paymentMethods.first.id!
      );
      result.when((errorCode) {
        success = false;
        PaymentExceptions.handleException(errorCode: errorCode);
      }, (isSuccessfull) {
        success = isSuccessfull;
      });
    }
    return success;
  }

  Future<void> addPaymentMethod() async {
    String? customerId = await locator<SecureStore>().getCustomerId();
    if (customerId != null) {
      Result<String, String?> result = await PayIn.createSetupIntent(customerId: customerId);
      result.when((errorCode) {
        PaymentExceptions.handleException(errorCode: errorCode);
      }, (secretKey) async {
        if (secretKey != null) {
        try {
          await Stripe.instance.initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  setupIntentClientSecret: secretKey,
                  customerId: customerId,
                  style: ThemeMode.dark));
          await Stripe.instance.presentPaymentSheet();
          setBusy(true);
          await getUserPaymentMethods();
        } on Exception catch (_) {
          Loader.hideLoader();
        }
      }
      });
    }
  }
}