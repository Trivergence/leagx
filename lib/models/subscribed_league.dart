// To parse this JSON data, do
//
//     final subscribedLeague = subscribedLeagueFromJson(jsonString);

import 'dart:convert';

List<SubscribedLeague> subscribedLeagueFromJson(String str) =>
    List<SubscribedLeague>.from(
        json.decode(str).map((x) => SubscribedLeague.fromJson(x)));

String subscribedLeagueToJson(List<SubscribedLeague> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscribedLeague {
  SubscribedLeague({
    required this.id,
    required this.title,
    required this.description,
    required this.logo,
    required this.createdAt,
    required this.updatedAt,
    required this.externalLeagueId,
  });

  int id;
  String title;
  dynamic description;
  String logo;
  DateTime createdAt;
  DateTime updatedAt;
  int externalLeagueId;

  factory SubscribedLeague.fromJson(Map<String, dynamic> json) =>
      SubscribedLeague(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        logo: json["logo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        externalLeagueId: json["external_league_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "logo": logo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "external_league_id": externalLeagueId,
      };
}
