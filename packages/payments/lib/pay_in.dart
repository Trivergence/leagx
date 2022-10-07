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
  static Future<List<PaymentMethod>> getPaymentMethods({required String customerId}) async {
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
}