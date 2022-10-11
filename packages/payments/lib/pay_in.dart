part of payments;


class PayIn {
  static Future<Customer?> createCustomer({
     String? userId, 
     String? userName, 
     String? userEmail, 
     String? userPhone}) async {
    var body = {
      "email": userEmail,
      "name": userName,
      "phone": userPhone,
      "metadata": {
        "internalId": userId
      }
    };
      Customer? customer = await ApiService.callPostApi(
        url: PaymentUrl.customer,
        body: body,
        modelName: ApiModels.customer
      );
      return customer;
  }
  static Future<List<PayMethod>> getPaymentMethods({required String customerId}) async {
    String completeUrl = PaymentUrl.customer + "/" + customerId + "/" + PaymentUrl.paymentMethods;
    var params = {"type": "card"};
    PaymentMethods? paymentMethods = await  ApiService.callGetApi(
      url: completeUrl, 
      modelName: ApiModels.getPaymentMethods,
      parameters: params
    );
    if(paymentMethods != null) {
      return paymentMethods.data!;
    }
    return [];
  }
    static Future<bool> removePaymentMethod(
      {required String paymentId}) async {
    String completeUrl = PaymentUrl.paymentMethods +
        "/" +
        paymentId +
        "/" +
        PaymentUrl.detachPaymentMethods;
    bool success = await ApiService.callPostWoResponceApi(
        url: completeUrl,
      );
    return success;
  }
  static Future<String?> createSetupIntent(
      {required String customerId}) async {
    Map<String,dynamic> body = {
     "payment_method_types[]": "card",
     "customer": customerId,
    };

    SetupIntent? setupIntent = await ApiService.callPostApi(
      url: PaymentUrl.setupIntent,
      body: body,
      modelName: ApiModels.createSetupIntent);
      if(setupIntent != null) {
        return setupIntent.clientSecret;
      }
      return null;
  }
    static Future<String?> createIndirectPaymentIntent({
      required String customerId, 
      required String amount, 
      required String currency}) async {
    Map<String, dynamic> body = {
      'amount': (int.parse(amount) * 100).toString(),
      'currency': currency,
      "setup_future_usage": "off_session",
      "payment_method_types[]": "card",
      "customer": customerId,
    };

    PaymentIntent? paymentIntent = await ApiService.callPostApi(
        url: PaymentUrl.paymentIntent,
        body: body,
        modelName: ApiModels.createPaymentIntent);
    if (paymentIntent != null) {
      return paymentIntent.clientSecret;
    }
    return null;
  }
}