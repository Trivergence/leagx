import 'package:leagx/core/secure_storage/secure_storage.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:payments/payments.dart';

import '../core/viewmodels/base_model.dart';

class WalletViewModel extends BaseModel {
  List<PaymentMethod> paymentMethods = [];

  List<PaymentMethod> get getPayementMethods => paymentMethods;

  getData() async {
    await getPaymentMethods();
  }


  Future<void> getPaymentMethods() async{
    String? customerId = await locator<SecureStore>().getCustomerId();
    if(customerId != null) {
      paymentMethods = await PayIn.getPaymentMethods(customerId: customerId);
    }
    notifyListeners();
  }
}