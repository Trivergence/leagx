// To parse this JSON data, do
//
//     final expressAccount = expressAccountFromJson(jsonString);

import 'dart:convert';

ExpressAccount expressAccountFromJson(String str) =>
    ExpressAccount.fromJson(json.decode(str));

String expressAccountToJson(ExpressAccount data) => json.encode(data.toJson());

class ExpressAccount {
  ExpressAccount({
    required this.id,
    this.object,
    required this.chargesEnabled,
    required this.detailsSubmitted,
    this.externalAccounts,
    this.futureRequirements,
    required this.payoutsEnabled,
    this.requirements,
  });

  String id;
  String? object;
  bool chargesEnabled;
  bool detailsSubmitted;
  ExternalAccounts? externalAccounts;
  Requirements? futureRequirements;
  bool payoutsEnabled;
  Requirements? requirements;

  factory ExpressAccount.fromJson(Map<String, dynamic> json) => ExpressAccount(
        id: json["id"],
        object: json["object"],
        chargesEnabled: json["charges_enabled"],
        detailsSubmitted: json["details_submitted"],
        externalAccounts: ExternalAccounts.fromJson(json["external_accounts"]),
        futureRequirements: Requirements.fromJson(json["future_requirements"]),
        payoutsEnabled: json["payouts_enabled"],
        requirements: Requirements.fromJson(json["requirements"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "charges_enabled": chargesEnabled,
        "details_submitted": detailsSubmitted,
        "external_accounts": externalAccounts!.toJson(),
        "future_requirements": futureRequirements!.toJson(),
        "payouts_enabled": payoutsEnabled,
        "requirements": requirements!.toJson(),
      };
}

class ExternalAccounts {
  ExternalAccounts({
    required this.object,
    required this.data,
    required this.hasMore,
    required this.totalCount,
    required this.url,
  });

  String object;
  List<Datum> data;
  bool hasMore;
  int totalCount;
  String url;

  factory ExternalAccounts.fromJson(Map<String, dynamic> json) =>
      ExternalAccounts(
        object: json["object"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        hasMore: json["has_more"],
        totalCount: json["total_count"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "has_more": hasMore,
        "total_count": totalCount,
        "url": url,
      };
}

class Requirements {
  Requirements({
    required this.alternatives,
    this.currentDeadline,
    required this.currentlyDue,
    this.disabledReason,
    required this.errors,
    required this.eventuallyDue,
    required this.pastDue,
    required this.pendingVerification,
  });

  List<dynamic> alternatives;
  dynamic currentDeadline;
  List<String> currentlyDue;
  String? disabledReason;
  List<dynamic> errors;
  List<String> eventuallyDue;
  List<String> pastDue;
  List<dynamic> pendingVerification;

  factory Requirements.fromJson(Map<String, dynamic> json) => Requirements(
        alternatives: List<dynamic>.from(json["alternatives"].map((x) => x)),
        currentDeadline: json["current_deadline"],
        currentlyDue: List<String>.from(json["currently_due"].map((x) => x)),
        disabledReason: json["disabled_reason"],
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        eventuallyDue: List<String>.from(json["eventually_due"].map((x) => x)),
        pastDue: List<String>.from(json["past_due"].map((x) => x)),
        pendingVerification:
            List<dynamic>.from(json["pending_verification"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "alternatives": List<dynamic>.from(alternatives.map((x) => x)),
        "current_deadline": currentDeadline,
        "currently_due": List<dynamic>.from(currentlyDue.map((x) => x)),
        "disabled_reason": disabledReason,
        "errors": List<dynamic>.from(errors.map((x) => x)),
        "eventually_due": List<dynamic>.from(eventuallyDue.map((x) => x)),
        "past_due": List<dynamic>.from(pastDue.map((x) => x)),
        "pending_verification":
            List<dynamic>.from(pendingVerification.map((x) => x)),
      };
}

class Branding {
  Branding({
    this.icon,
    this.logo,
    this.primaryColor,
    this.secondaryColor,
  });

  dynamic icon;
  dynamic logo;
  dynamic primaryColor;
  dynamic secondaryColor;

  factory Branding.fromJson(Map<String, dynamic> json) => Branding(
        icon: json["icon"],
        logo: json["logo"],
        primaryColor: json["primary_color"],
        secondaryColor: json["secondary_color"],
      );

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "logo": logo,
        "primary_color": primaryColor,
        "secondary_color": secondaryColor,
      };
}

class CardIssuing {
  CardIssuing({
    required this.tosAcceptance,
  });

  CardIssuingTosAcceptance tosAcceptance;

  factory CardIssuing.fromJson(Map<String, dynamic> json) => CardIssuing(
        tosAcceptance:
            CardIssuingTosAcceptance.fromJson(json["tos_acceptance"]),
      );

  Map<String, dynamic> toJson() => {
        "tos_acceptance": tosAcceptance.toJson(),
      };
}

class CardIssuingTosAcceptance {
  CardIssuingTosAcceptance({
    this.date,
    this.ip,
  });

  dynamic date;
  dynamic ip;

  factory CardIssuingTosAcceptance.fromJson(Map<String, dynamic> json) =>
      CardIssuingTosAcceptance(
        date: json["date"],
        ip: json["ip"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "ip": ip,
      };
}

class CardPayments {
  CardPayments({
    required this.declineOn,
    this.statementDescriptorPrefix,
    this.statementDescriptorPrefixKana,
    this.statementDescriptorPrefixKanji,
  });

  DeclineOn declineOn;
  dynamic statementDescriptorPrefix;
  dynamic statementDescriptorPrefixKana;
  dynamic statementDescriptorPrefixKanji;

  factory CardPayments.fromJson(Map<String, dynamic> json) => CardPayments(
        declineOn: DeclineOn.fromJson(json["decline_on"]),
        statementDescriptorPrefix: json["statement_descriptor_prefix"],
        statementDescriptorPrefixKana: json["statement_descriptor_prefix_kana"],
        statementDescriptorPrefixKanji:
            json["statement_descriptor_prefix_kanji"],
      );

  Map<String, dynamic> toJson() => {
        "decline_on": declineOn.toJson(),
        "statement_descriptor_prefix": statementDescriptorPrefix,
        "statement_descriptor_prefix_kana": statementDescriptorPrefixKana,
        "statement_descriptor_prefix_kanji": statementDescriptorPrefixKanji,
      };
}

class DeclineOn {
  DeclineOn({
    required this.avsFailure,
    required this.cvcFailure,
  });

  bool avsFailure;
  bool cvcFailure;

  factory DeclineOn.fromJson(Map<String, dynamic> json) => DeclineOn(
        avsFailure: json["avs_failure"],
        cvcFailure: json["cvc_failure"],
      );

  Map<String, dynamic> toJson() => {
        "avs_failure": avsFailure,
        "cvc_failure": cvcFailure,
      };
}

class Dashboard {
  Dashboard({
    this.displayName,
    this.timezone,
  });

  String? displayName;
  String? timezone;

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
        displayName: json["display_name"] ?? "",
        timezone: json["timezone"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "display_name": displayName,
        "timezone": timezone,
      };
}

class Payments {
  Payments({
    this.statementDescriptor,
    this.statementDescriptorKana,
    this.statementDescriptorKanji,
  });

  dynamic statementDescriptor;
  dynamic statementDescriptorKana;
  dynamic statementDescriptorKanji;

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        statementDescriptor: json["statement_descriptor"],
        statementDescriptorKana: json["statement_descriptor_kana"],
        statementDescriptorKanji: json["statement_descriptor_kanji"],
      );

  Map<String, dynamic> toJson() => {
        "statement_descriptor": statementDescriptor,
        "statement_descriptor_kana": statementDescriptorKana,
        "statement_descriptor_kanji": statementDescriptorKanji,
      };
}

class Payouts {
  Payouts({
    required this.debitNegativeBalances,
    required  this.schedule,
    this.statementDescriptor,
  });

  bool debitNegativeBalances;
  Schedule schedule;
  dynamic statementDescriptor;

  factory Payouts.fromJson(Map<String, dynamic> json) => Payouts(
        debitNegativeBalances: json["debit_negative_balances"],
        schedule: Schedule.fromJson(json["schedule"]),
        statementDescriptor: json["statement_descriptor"],
      );

  Map<String, dynamic> toJson() => {
        "debit_negative_balances": debitNegativeBalances,
        "schedule": schedule.toJson(),
        "statement_descriptor": statementDescriptor,
      };
}

class Schedule {
  Schedule({
    this.delayDays,
    this.interval,
  });

  int? delayDays;
  String? interval;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        delayDays: json["delay_days"] ?? 0,
        interval: json["interval"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "delay_days": delayDays,
        "interval": interval,
      };
}

class Datum {
  Datum({
    this.id,
    this.object,
    this.account,
    this.accountHolderName,
    this.accountHolderType,
    this.accountType,
    required this.availablePayoutMethods,
    this.bankName,
    this.country,
    this.currency,
    required this.defaultForCurrency,
    this.fingerprint,
    this.last4,
    this.routingNumber,
    this.status,
  });

  String? id;
  String? object;
  String? account;
  dynamic accountHolderName;
  dynamic accountHolderType;
  dynamic accountType;
  List<String> availablePayoutMethods;
  String? bankName;
  String? country;
  String? currency;
  bool defaultForCurrency;
  String? fingerprint;
  String? last4;
  String? routingNumber;
  String? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        object: json["object"],
        account: json["account"],
        accountHolderName: json["account_holder_name"],
        accountHolderType: json["account_holder_type"],
        accountType: json["account_type"],
        availablePayoutMethods:
            List<String>.from(json["available_payout_methods"].map((x) => x)),
        bankName: json["bank_name"],
        country: json["country"],
        currency: json["currency"],
        defaultForCurrency: json["default_for_currency"],
        fingerprint: json["fingerprint"],
        last4: json["last4"],
        routingNumber: json["routing_number"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "account": account,
        "account_holder_name": accountHolderName,
        "account_holder_type": accountHolderType,
        "account_type": accountType,
        "available_payout_methods":
            List<dynamic>.from(availablePayoutMethods.map((x) => x)),
        "bank_name": bankName,
        "country": country,
        "currency": currency,
        "default_for_currency": defaultForCurrency,
        "fingerprint": fingerprint,
        "last4": last4,
        "routing_number": routingNumber,
        "status": status,
      };
}
