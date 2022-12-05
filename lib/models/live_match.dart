// To parse this JSON data, do
//
//     final liveMatch = liveMatchFromJson(jsonString);

import 'dart:convert';

LiveMatch liveMatchFromJson(String str) => LiveMatch.fromJson(json.decode(str));

String liveMatchToJson(LiveMatch data) => json.encode(data.toJson());

class LiveMatch {
  LiveMatch({
    this.status = false,
    this.url = "",
  });

  bool status;
  String url;

  factory LiveMatch.fromJson(Map<String, dynamic> json) => LiveMatch(
        status: json["status"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "url": url,
      };
}
