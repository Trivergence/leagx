import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:leagx/core/secure_storage/secure_storage.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:payments/payments.dart';

import '../core/viewmodels/base_model.dart';

class WalletViewModel extends BaseModel {
  List<PayMethod> paymentMethods = [];

  List<PayMethod> get getPayementMethods => paymentMethods;

  getData() async {
    setBusy(true);
    await getPaymentMethods();
  }


  Future<void> getPaymentMethods() async{
    String? customerId = await locator<SecureStore>().getCustomerId();
    if(customerId != null) {
      paymentMethods = await PayIn.getPaymentMethods(customerId: customerId);
      if (paymentMethods.isNotEmpty) {
        locator<SecureStore>().savePaymentId(paymentMethods.first.id!);
      }
    }
    setBusy(false);
  }
  Future<void> removePaymentMethod() async {
    setBusy(true);
    try {
      String? paymentId = await locator<SecureStore>().getPaymentId();
      if (paymentId != null) {
        bool success = await PayIn.removePaymentMethod(paymentId: paymentId);
        if(success) paymentMethods = [];
        setBusy(false);
      }
    } on Exception catch (_) {
      setBusy(false);
    }
  }

  purchaseDirectly() {

  }
  Future<void> purchaseIndirectly({
    required String amount,
    required String currency,
    }) async{
      String? customerId = await locator<SecureStore>().getCustomerId();
      if(customerId != null) {
      String? secretKey = await  PayIn.createIndirectPaymentIntent(
       customerId: customerId,
       amount: amount,
       currency: currency);
      if (secretKey != null) {
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: secretKey,
              customerId: customerId,
              style: ThemeMode.dark));
      await Stripe.instance.presentPaymentSheet();
      await getPaymentMethods();
    }
  }
}
  Future<void> addPaymentMethod() async {
    String? customerId = await locator<SecureStore>().getCustomerId();
    if (customerId != null) {
      String? secretKey = await PayIn.createSetupIntent(customerId: customerId);
      if (secretKey != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                setupIntentClientSecret: secretKey,
                customerId: customerId,
                style: ThemeMode.dark));
        await Stripe.instance.presentPaymentSheet();
        setBusy(true);
        await getPaymentMethods();
      }
    }
  }
}