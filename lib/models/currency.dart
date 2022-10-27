// To parse this JSON data, do
//
//     final currency = currencyFromJson(jsonString);

import 'dart:convert';

Currency currencyFromJson(String str) => Currency.fromJson(json.decode(str));

String currencyToJson(Currency data) => json.encode(data.toJson());

class Currency {
  Currency({
    required this.baseCurrencyCode,
    required this.baseCurrencyName,
    required this.amount,
    required this.updatedDate,
    required this.rates,
    required this.status,
  });

  String baseCurrencyCode;
  String baseCurrencyName;
  String amount;
  DateTime updatedDate;
  Map<String,dynamic> rates;
  String status;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        baseCurrencyCode: json["base_currency_code"],
        baseCurrencyName: json["base_currency_name"],
        amount: json["amount"],
        updatedDate: DateTime.parse(json["updated_date"]),
        rates: json["rates"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "base_currency_code": baseCurrencyCode,
        "base_currency_name": baseCurrencyName,
        "amount": amount,
        "updated_date":
            "${updatedDate.year.toString().padLeft(4, '0')}-${updatedDate.month.toString().padLeft(2, '0')}-${updatedDate.day.toString().padLeft(2, '0')}",
        "rates": rates,
        "status": status,
      };
}
