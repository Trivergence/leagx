import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';

class PaymentExceptions {
  static void handleException({required String errorCode}) {
    String message = "";
    switch(errorCode) {
      case "account_already_exists":
        message = loc.errorStripeAccountAlreadyExists;
        break;
      case "account_country_invalid_address":
        message = loc.errorStripeAccountCountryInvalidAddress;
        break;
      case "account_number_invalid":
        message = loc.errorStripeAccountNumberInvalid;
        break;
      case "alipay_upgrade_required":
        message = loc.errorStripeAlipayUpgradeRequired;
        break;
      case "amount_too_large":
        message = loc.errorStripeAmountTooLarge;
        break;
      case "amount_too_small":
        message = loc.errorStripeAmountTooSmall;
        break;
      case "balance_insufficient":
        message = loc.errorStripeBalanceInsufficient;
        break;
      case "bank_account_exists":
        message = loc.errorStripeBankAccountExists;
        break;
      case "bank_account_unusable":
        message = loc.errorStripeBankAccountUnusable;
        break;
      case "card_declined":
        message = loc.errorStripeCardDeclined;
        break;
      case "charge_exceeds_source_limit":
        message = loc.errorStripeChargeExceedsSourceLimit;
        break;
      case "charge_expired_for_capture":
        message = loc.errorStripeChargeExpiredForCapture;
        break;
      case "email_invalid":
        message = loc.errorStripeEmailInvalid;
        break;
      case "expired_card":
        message = loc.errorStripeExpiredCard;
        break;
      case "incorrect_address":
        message = loc.errorStripeIncorrectAddress;
        break;
      case "instant_payouts_unsupported":
        message = loc.errorStripeInstantPayoutsUnsupported;
        break;
      case "invalid_card_type":
        message = loc.errorStripeInvalidCardType;
        break;
      case "invalid_charge_amount":
        message = loc.errorStripeInvalidChargeAmount;
        break;
      case "missing":
        message = loc.errorStripeMissing;
        break;
      case "payment_intent_authentication_failure":
        message = loc.errorStripePaymentIntentAuthenticationFailure;
        break;
      case "payment_intent_incompatible_payment_method":
        message = loc.errorStripePaymentIntentPaymentAttemptFailed;
        break;
      case "payment_intent_unexpected_state":
        message = loc.errorStripePaymentIntentUnexpectedState;
        break;
      case "payment_method_unactivated":
        message = loc.errorStripePaymentMethodUnactivated;
        break;
      case "payment_method_unexpected_state":
        message = loc.errorStripePaymentMethodUnexpectedState;
        break;
      case "payouts_not_allowed":
        message = loc.errorStripePayoutsNotAllowed;
        break;
      case "processing_error":
        message = loc.errorStripeProcessingError;
        break;
      case "rate_limit":
        message = loc.errorStripeRateLimit;
        break;
      case "sepa_unsupported_account":
        message = loc.errorStripeSepaUnsupportedAccount;
        break;
      case "state_unsupported":
        message = loc.errorStripeStateUnsupported;
        break;
      case "transfers_not_allowed":
        message = loc.errorStripeTransfersNotAllowed;
        break;
      case "url_invalid":
        message = loc.errorStripeUrlInvalid;
        break;
      default:
      message = loc.errorTryAgain;
    }
    ToastMessage.show(message, TOAST_TYPE.error);
  }
}