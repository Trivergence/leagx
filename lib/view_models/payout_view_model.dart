import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/core/sharedpref/sharedpref.dart';
import 'package:leagx/core/viewmodels/base_model.dart';
import 'package:leagx/service/payment_service/payment_exception.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:payments/models/express_account.dart';
import 'package:payments/pay_out.dart';

import '../models/customer_cred.dart';
import '../service/payment_service/payment_config.dart';

class PayoutViewModel extends BaseModel{
  ExpressAccount? _expressAccount ;

  ExpressAccount? get expressAccount => _expressAccount;

  Future<void> createAccount() async {
    CustomerCred? customerCred = locator<PaymentConfig>().getCustomerCred;
    if( customerCred != null && locator<PaymentConfig>().getAccountId == null) {
      Result<String?, ExpressAccount> result =
          await PayOut.createExpressAccount();
      result.when(
          (errorCode) =>
              PaymentExceptions.handleException(errorCode: errorCode!),
          (expressAccount) {
        locator<PaymentConfig>().getCustomerCred!.accountId = expressAccount.id;
      });
    }
  }
}