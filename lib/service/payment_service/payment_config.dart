import 'package:leagx/models/customer_cred.dart';

class PaymentConfig {
  CustomerCred? _customerCred;

  CustomerCred? get getCustomerCred => _customerCred;

  set setCustomerCred(CustomerCred customerCred) => _customerCred = customerCred;
}