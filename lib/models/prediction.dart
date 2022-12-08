// To parse this JSON data, do
//
//     final prediction = predictionFromJson(jsonString);

import 'dart:convert';

List<Prediction> predictionFromJson(String str) =>
    List<Prediction>.from(json.decode(str).map((x) => Prediction.fromJson(x)));

String predictionToJson(List<Prediction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Prediction {
  Prediction({
    required this.id,
    required this.firstTeamScore,
    required this.secondTeamScore,
    required this.matchId,
    required this.userId,
    required this.accuratePercentage,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.isPublic,
    required this.expertId,
    required this.externalMatchId,
    required this.match,
  });

  int id;
  int? firstTeamScore;
  int? secondTeamScore;
  int? matchId;
  int? userId;
  double? accuratePercentage;
  DateTime createdAt;
  DateTime updatedAt;
  String? status;
  bool? isPublic;
  int? expertId;
  int? externalMatchId;
  Match match;

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
        id: json["id"],
        firstTeamScore: json["first_team_score"],
        secondTeamScore: json["second_team_score"],
        matchId: json["match_id"],
        userId: json["user_id"],
        accuratePercentage: json["accurate_percentage"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"] ?? "OPEN",
        isPublic: json["is_public"],
        expertId: json["expert_id"],
        externalMatchId: json["external_match_id"],
        match: Match.fromJson(json["match"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_team_score": firstTeamScore,
        "second_team_score": secondTeamScore,
        "match_id": matchId,
        "user_id": userId,
        "accurate_percentage": accuratePercentage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "is_public": isPublic,
        "expert_id": expertId,
        "external_match_id": externalMatchId,
        "match": match.toJson(),
      };
}

class Match {
  Match({
    required this.id,
    required this.externalMatchId,
    required this.firstTeamName,
    required this.secondTeamName,
    required this.firstTeamScore,
    required this.secondTeamScore,
    required this.leagueId,
    required this.createdAt,
    required this.updatedAt,
    required this.firstTeamLogo,
    required this.secondTeamLogo,
  });

  int id;
  int? externalMatchId;
  String? firstTeamName;
  String? secondTeamName;
  int? firstTeamScore;
  int? secondTeamScore;
  int? leagueId;
  DateTime createdAt;
  DateTime updatedAt;
  String? firstTeamLogo;
  String? secondTeamLogo;

  factory Match.fromJson(Map<String, dynamic> json) => Match(
        id: json["id"],
        externalMatchId: json["external_match_id"],
        firstTeamName: json["first_team_name"] ?? "",
        secondTeamName: json["second_team_name"] ?? "",
        firstTeamScore: json["first_team_score"],
        secondTeamScore: json["second_team_score"],
        leagueId: json["league_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        firstTeamLogo: json["first_team_logo"] ?? "",
        secondTeamLogo: json["second_team_logo"] ?? "" ,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "external_match_id": externalMatchId,
        "first_team_name": firstTeamName,
        "second_team_name": secondTeamName,
        "first_team_score": firstTeamScore,
        "second_team_score": secondTeamScore,
        "league_id": leagueId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "first_team_logo": firstTeamLogo,
        "second_team_logo": secondTeamLogo,
      };
}
