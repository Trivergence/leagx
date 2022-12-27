// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  ErrorModel({
    this.error,
  });

  ErrorData? error;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        error: ErrorData.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error!.toJson(),
      };
}
class ErrorData {
  ErrorData({
    this.charge,
    this.code,
    this.declineCode,
    this.docUrl,
    this.message,
    this.type,
  });

  String? charge;
  String? code;
  String? declineCode;
  String? docUrl;
  String? message;
  String? requestLogUrl;
  String? type;

  factory ErrorData.fromJson(Map<String, dynamic> json) => ErrorData(
        charge: json["charge"],
        code: json["code"],
        declineCode: json["decline_code"],
        docUrl: json["doc_url"],
        message: json["message"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "charge": charge,
        "code": code,
        "decline_code": declineCode,
        "doc_url": docUrl,
        "message": message,
        "type": type,
      };
}