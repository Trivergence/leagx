// To parse this JSON data, do
//
//     final stripeCred = stripeCredFromJson(jsonString);

import 'dart:convert';

StripeCred stripeCredFromJson(String str) =>
    StripeCred.fromJson(json.decode(str));

String stripeCredToJson(StripeCred data) => json.encode(data.toJson());

class StripeCred {
  StripeCred({
    required this.stripeSecret,
    required this.publishableKey,
  });

  String stripeSecret;
  String publishableKey;

  factory StripeCred.fromJson(Map<String, dynamic> json) => StripeCred(
        stripeSecret: json["stripe_secret"],
        publishableKey: json["publishable_key"],
      );

  Map<String, dynamic> toJson() => {
        "stripe_secret": stripeSecret,
        "publishable_key": publishableKey,
      };
}
