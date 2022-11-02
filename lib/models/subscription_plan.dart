// To parse this JSON data, do
//
//     final subscriptionPlan = subscriptionPlanFromJson(jsonString);

import 'dart:convert';

List<SubscriptionPlan> subscriptionPlanFromJson(String str) =>
    List<SubscriptionPlan>.from(
        json.decode(str).map((x) => SubscriptionPlan.fromJson(x)));

String subscriptionPlanToJson(List<SubscriptionPlan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscriptionPlan {
  SubscriptionPlan({
    required this.id,
    required this.title,
    required this.price,
    required this.feature1,
    required this.feature2,
    required this.feature3,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String title;
  double price;
  String feature1;
  String feature2;
  String feature3;
  DateTime createdAt;
  DateTime updatedAt;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlan(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        feature1: json["feature_1"],
        feature2: json["feature_2"],
        feature3: json["feature_3"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "feature_1": feature1,
        "feature_2": feature2,
        "feature_3": feature3,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
