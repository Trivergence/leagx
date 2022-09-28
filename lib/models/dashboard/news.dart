// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

import '../user/user.dart';

List<News> newsFromJson(String str) =>
    List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsToJson(List<News> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class News {
  News({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.leagueId,
    required this.createdAt,
    required this.updatedAt,
    required this.matchId,
    required this.user,
  });

  int id;
  String title;
  String description;
  int userId;
  int leagueId;
  DateTime createdAt;
  DateTime updatedAt;
  int matchId;
  User user;

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        userId: json["user_id"],
        leagueId: json["league_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        matchId: json["match_id"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "user_id": userId,
        "league_id": leagueId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "match_id": matchId,
        "user": user.toJson(),
      };
}
