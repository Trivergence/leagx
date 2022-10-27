// To parse this JSON data, do
//
//     final customerCred = customerCredFromJson(jsonString);

import 'dart:convert';

List<CustomerCred> customerCredFromJson(String str) => List<CustomerCred>.from(
    json.decode(str).map((x) => CustomerCred.fromJson(x)));

String customerCredToJson(List<CustomerCred> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerCred {
  CustomerCred({
    this.id,
    this.userId,
    this.paymentCardId,
    this.customerId,
    this.accountId,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  int? userId;
  String? paymentCardId;
  String? customerId;
  String? accountId;
  DateTime createdAt;
  DateTime updatedAt;

  factory CustomerCred.fromJson(Map<String, dynamic> json) => CustomerCred(
        id: json["id"],
        userId: json["user_id"],
        paymentCardId: json["payment_card_id"],
        customerId: json["customer_id"],
        accountId: json["account_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "payment_card_id": paymentCardId,
        "customer_id": customerId,
        "account_id": accountId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
