part of payments;

class PayIn {
  static Future<Result<ErrorModel, Customer>> createCustomer(
      {String? userId,
      String? userName,
      String? userEmail,
      String? userPhone}) async {
    var body = {
      "email": userEmail,
      "name": userName,
      "phone": userPhone,
      "metadata": {"internalId": userId}
    };
    Result<ErrorModel, dynamic> result = await ApiService.callPostApi(
        url: PaymentUrl.customer, body: body, modelName: ApiModels.customer);
    return result.when((errorModel) {
      return Error(errorModel);
    }, (customerModel) {
      Customer? customer = customerModel;
      if (customer != null) {
        return Success(customer);
      }
      return Error(ErrorModel(
          error:
              ErrorData(code: PaymentConstants.somethingWentWrongErrorCode)));
    });
  }

  static Future<Result<ErrorModel, List<PayMethod>>> getPaymentMethods(
      {required String customerId}) async {
    String completeUrl = PaymentUrl.customer +
        "/" +
        customerId +
        "/" +
        PaymentUrl.paymentMethods;
    var params = {"type": "card"};
    Result<ErrorModel, dynamic> result = await ApiService.callGetApi(
        url: completeUrl,
        modelName: ApiModels.getPaymentMethods,
        parameters: params);
    return result.when((errorModel) => Error(errorModel), (paymentModel) {
      PaymentMethods? paymentMethods = paymentModel;
      if (paymentMethods != null) {
        return Success(paymentMethods.data!);
      }
      return const Success([]);
    });
  }

  static Future<Result<String, bool>> removePaymentMethod(
      {required String paymentId}) async {
    String completeUrl = PaymentUrl.paymentMethods +
        "/" +
        paymentId +
        "/" +
        PaymentUrl.detachPaymentMethods;
    Result<ErrorModel, bool> result = await ApiService.callPostWoResponceApi(
      url: completeUrl,
    );
    return result.when((errorModel) => Error(errorModel.error!.code!),
        (isSuccessfull) => Success(isSuccessfull));
  }

  static Future<Result<ErrorModel, String?>> createSetupIntent(
      {required String customerId}) async {
    Map<String, dynamic> body = {
      "payment_method_types[]": "card",
      "customer": customerId,
    };
    Result<ErrorModel, dynamic> result = await ApiService.callPostApi(
        url: PaymentUrl.setupIntent,
        body: body,
        modelName: ApiModels.createSetupIntent);
    return result.when((errorModel) {
      return Error(errorModel);
    }, (setupIntentModel) {
      SetupIntent? setupIntent = setupIntentModel;
      if (setupIntent != null) {
        return Success(setupIntent.clientSecret);
      }
      return const Success(null);
    });
  }

  static Future<Result<ErrorModel, String?>> createIndirectPaymentIntent(
      {required String customerId,
      required String amount,
      required String currency}) async {
    Map<String, dynamic> body = {
      'amount': (int.parse(amount) * 100).toString(),
      'currency': currency,
      "setup_future_usage": "off_session",
      "payment_method_types[]": "card",
      "customer": customerId,
    };
    Result<ErrorModel, dynamic> result = await ApiService.callPostApi(
        url: PaymentUrl.paymentIntent,
        body: body,
        modelName: ApiModels.createPaymentIntent);
    return result.when((errorModel) {
      return Error(errorModel);
    }, (paymentIntentModel) {
      PaymentIntent? paymentIntent = paymentIntentModel;
      if (paymentIntent != null) {
        return Success(paymentIntent.clientSecret);
      }
      return const Success(null);
    });
  }

  static Future<Result<ErrorModel, bool>> createDirectPaymentIntent(
      {required String customerId,
      required String amount,
      required String currency,
      required String paymentMethodId}) async {
    Map<String, dynamic> body = {
      'amount': (int.parse(amount) * 100).toString(),
      'currency': currency,
      "customer": customerId,
      "payment_method": paymentMethodId,
      "off_session": true,
      "confirm": true,
    };

    Result<ErrorModel, dynamic> result = await ApiService.callPostApi(
        url: PaymentUrl.paymentIntent,
        body: body,
        modelName: ApiModels.createPaymentIntent);
    return result.when((errorModel) {
      return Error(errorModel);
    }, (paymentIntentModel) {
      PaymentIntent? paymentIntent = paymentIntentModel;
      if (paymentIntent != null) {
        return const Success(true);
      }
      return const Success(false);
    });
  }
}
