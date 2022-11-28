// To parse this JSON data, do
//
//     final payoutModel = payoutModelFromJson(jsonString);

import 'dart:convert';

PayoutModel payoutModelFromJson(String str) =>
    PayoutModel.fromJson(json.decode(str));

String payoutModelToJson(PayoutModel data) => json.encode(data.toJson());

class PayoutModel {
  PayoutModel({
    required this.id,
    required this.object,
    required this.amount,
    required this.arrivalDate,
    required this.automatic,
    required this.balanceTransaction,
    required this.created,
    required this.currency,
    this.description,
    required this.destination,
    this.failureBalanceTransaction,
    this.failureCode,
    this.failureMessage,
    required this.livemode,
    required this.method,
    this.originalPayout,
    this.reversedBy,
    required this.sourceType,
    this.statementDescriptor,
    required this.status,
    required this.type,
  });

  String id;
  String object;
  int amount;
  int arrivalDate;
  bool automatic;
  String balanceTransaction;
  int created;
  String currency;
  dynamic description;
  String destination;
  dynamic failureBalanceTransaction;
  dynamic failureCode;
  dynamic failureMessage;
  bool livemode;
  String method;
  dynamic originalPayout;
  dynamic reversedBy;
  String sourceType;
  dynamic statementDescriptor;
  String status;
  String type;

  factory PayoutModel.fromJson(Map<String, dynamic> json) => PayoutModel(
        id: json["id"],
        object: json["object"],
        amount: json["amount"],
        arrivalDate: json["arrival_date"],
        automatic: json["automatic"],
        balanceTransaction: json["balance_transaction"],
        created: json["created"],
        currency: json["currency"],
        description: json["description"],
        destination: json["destination"],
        failureBalanceTransaction: json["failure_balance_transaction"],
        failureCode: json["failure_code"],
        failureMessage: json["failure_message"],
        livemode: json["livemode"],
        method: json["method"],
        originalPayout: json["original_payout"],
        reversedBy: json["reversed_by"],
        sourceType: json["source_type"],
        statementDescriptor: json["statement_descriptor"],
        status: json["status"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "amount": amount,
        "arrival_date": arrivalDate,
        "automatic": automatic,
        "balance_transaction": balanceTransaction,
        "created": created,
        "currency": currency,
        "description": description,
        "destination": destination,
        "failure_balance_transaction": failureBalanceTransaction,
        "failure_code": failureCode,
        "failure_message": failureMessage,
        "livemode": livemode,
        "method": method,
        "original_payout": originalPayout,
        "reversed_by": reversedBy,
        "source_type": sourceType,
        "statement_descriptor": statementDescriptor,
        "status": status,
        "type": type,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}
