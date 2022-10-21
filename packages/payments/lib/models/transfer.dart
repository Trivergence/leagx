// To parse this JSON data, do
//
//     final transfer = transferFromJson(jsonString);

import 'dart:convert';

Transfer transferFromJson(String str) => Transfer.fromJson(json.decode(str));

String transferToJson(Transfer data) => json.encode(data.toJson());

class Transfer {
  Transfer({
    required this.id,
    required this.object,
    required this.amount,
    required this.amountReversed,
    required this.balanceTransaction,
    required this.created,
    required this.currency,
    this.description,
    this.destination,
    this.destinationPayment,
    required this.livemode,
    required this.reversals,
    required this.reversed,
    this.sourceTransaction,
    required this.sourceType,
    this.transferGroup,
  });

  String id;
  String object;
  int amount;
  int amountReversed;
  String balanceTransaction;
  int created;
  String currency;
  dynamic description;
  String? destination;
  dynamic destinationPayment;
  bool livemode;
  Reversals reversals;
  bool reversed;
  dynamic sourceTransaction;
  String sourceType;
  dynamic transferGroup;

  factory Transfer.fromJson(Map<String, dynamic> json) => Transfer(
        id: json["id"],
        object: json["object"],
        amount: json["amount"],
        amountReversed: json["amount_reversed"],
        balanceTransaction: json["balance_transaction"],
        created: json["created"],
        currency: json["currency"],
        description: json["description"],
        destination: json["destination"],
        destinationPayment: json["destination_payment"],
        livemode: json["livemode"],
        reversals: Reversals.fromJson(json["reversals"]),
        reversed: json["reversed"],
        sourceTransaction: json["source_transaction"],
        sourceType: json["source_type"],
        transferGroup: json["transfer_group"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "amount": amount,
        "amount_reversed": amountReversed,
        "balance_transaction": balanceTransaction,
        "created": created,
        "currency": currency,
        "description": description,
        "destination": destination,
        "destination_payment": destinationPayment,
        "livemode": livemode,
        "reversals": reversals.toJson(),
        "reversed": reversed,
        "source_transaction": sourceTransaction,
        "source_type": sourceType,
        "transfer_group": transferGroup,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}

class Reversals {
  Reversals({
    required this.object,
    required this.data,
    required this.hasMore,
    this.totalCount,
    this.url,
  });

  String object;
  List<dynamic> data;
  bool hasMore;
  int? totalCount;
  String? url;

  factory Reversals.fromJson(Map<String, dynamic> json) => Reversals(
        object: json["object"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        hasMore: json["has_more"],
        totalCount: json["total_count"] ?? 0,
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "data": List<dynamic>.from(data.map((x) => x)),
        "has_more": hasMore,
        "total_count": totalCount,
        "url": url,
      };
}
