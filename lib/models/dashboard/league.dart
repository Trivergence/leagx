// To parse this JSON data, do
//
//     final league = leagueFromJson(jsonString);

import 'dart:convert';

List<League> leagueFromJson(String str) =>
    List<League>.from(json.decode(str).map((x) => League.fromJson(x)));

String leagueToJson(List<League> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class League {
  League({
    required this.countryId,
    required this.countryName,
    required this.leagueId,
    required this.leagueName,
    required this.leagueSeason,
    required this.leagueLogo,
    required this.countryLogo,
  });

  String countryId;
  String countryName;
  String leagueId;
  String leagueName;
  String leagueSeason;
  String leagueLogo;
  String countryLogo;

  factory League.fromJson(Map<String, dynamic> json) => League(
        countryId: json["country_id"],
        countryName: json["country_name"],
        leagueId: json["league_id"],
        leagueName: json["league_name"],
        leagueSeason: json["league_season"],
        leagueLogo: json["league_logo"],
        countryLogo: json["country_logo"],
      );

  Map<String, dynamic> toJson() => {
        "country_id": countryId,
        "country_name": countryName,
        "league_id": leagueId,
        "league_name": leagueName,
        "league_season": leagueSeason,
        "league_logo": leagueLogo,
        "country_logo": countryLogo,
      };
}
