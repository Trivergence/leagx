// To parse this JSON data, do
//
//     final team = teamFromJson(jsonString);

import 'dart:convert';

List<Team> teamFromJson(String str) =>
    List<Team>.from(json.decode(str).map((x) => Team.fromJson(x)));

String teamToJson(List<Team> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Team {
  Team({
    required this.teamKey,
    required this.teamName,
    required this.teamBadge,
    required this.players,
    required this.coaches,
  });

  String teamKey;
  String teamName;
  String teamBadge;
  List<Player> players;
  List<Coach> coaches;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        teamKey: json["team_key"],
        teamName: json["team_name"],
        teamBadge: json["team_badge"],
        players:
            List<Player>.from(json["players"].map((x) => Player.fromJson(x))),
        coaches:
            List<Coach>.from(json["coaches"].map((x) => Coach.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "team_key": teamKey,
        "team_name": teamName,
        "team_badge": teamBadge,
        "players": List<dynamic>.from(players.map((x) => x.toJson())),
        "coaches": List<dynamic>.from(coaches.map((x) => x.toJson())),
      };
}

class Coach {
  Coach({
    required this.coachName,
    required this.coachCountry,
    required this.coachAge,
  });

  String coachName;
  String coachCountry;
  String coachAge;

  factory Coach.fromJson(Map<String, dynamic> json) => Coach(
        coachName: json["coach_name"],
        coachCountry: json["coach_country"],
        coachAge: json["coach_age"],
      );

  Map<String, dynamic> toJson() => {
        "coach_name": coachName,
        "coach_country": coachCountry,
        "coach_age": coachAge,
      };
}

class Player {
  Player({
    required this.playerKey,
    required this.playerId,
    required this.playerImage,
    required this.playerName,
    required this.playerNumber,
    required this.playerCountry,
    required this.playerAge,
    required this.playerMatchPlayed,
    required this.playerGoals,
    required this.playerYellowCards,
    required this.playerRedCards,
    required this.playerSubstituteOut,
    required this.playerSubstitutesOnBench,
    required this.playerAssists,
    required this.playerBirthdate,
    required this.playerIsCaptain,
    required this.playerShotsTotal,
    required this.playerGoalsConceded,
    required this.playerFoulsCommitted,
    required this.playerTackles,
    required this.playerBlocks,
    required this.playerCrossesTotal,
    required this.playerInterceptions,
    required this.playerClearances,
    required this.playerDispossesed,
    required this.playerSaves,
    required this.playerInsideBoxSaves,
    required this.playerDuelsTotal,
    required this.playerDuelsWon,
    required this.playerDribbleAttempts,
    required this.playerDribbleSucc,
    required this.playerPenComm,
    required this.playerPenWon,
    required this.playerPenScored,
    required this.playerPenMissed,
    required this.playerPasses,
    required this.playerPassesAccuracy,
    required this.playerKeyPasses,
    required this.playerWoordworks,
    required this.playerRating,
  });

  int playerKey;
  String playerId;
  String playerImage;
  String playerName;
  String playerNumber;
  String playerCountry;
  String playerAge;
  String playerMatchPlayed;
  String playerGoals;
  String playerYellowCards;
  String playerRedCards;
  String playerSubstituteOut;
  String playerSubstitutesOnBench;
  String playerAssists;
  String playerBirthdate;
  String playerIsCaptain;
  String playerShotsTotal;
  String playerGoalsConceded;
  String playerFoulsCommitted;
  String playerTackles;
  String playerBlocks;
  String playerCrossesTotal;
  String playerInterceptions;
  String playerClearances;
  String playerDispossesed;
  String playerSaves;
  String playerInsideBoxSaves;
  String playerDuelsTotal;
  String playerDuelsWon;
  String playerDribbleAttempts;
  String playerDribbleSucc;
  String playerPenComm;
  String playerPenWon;
  String playerPenScored;
  String playerPenMissed;
  String playerPasses;
  String playerPassesAccuracy;
  String playerKeyPasses;
  String playerWoordworks;
  String playerRating;

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        playerKey: json["player_key"],
        playerId: json["player_id"],
        playerImage: json["player_image"],
        playerName: json["player_name"],
        playerNumber: json["player_number"],
        playerCountry: json["player_country"],
        playerAge: json["player_age"],
        playerMatchPlayed: json["player_match_played"],
        playerGoals: json["player_goals"],
        playerYellowCards: json["player_yellow_cards"],
        playerRedCards: json["player_red_cards"],
        playerSubstituteOut: json["player_substitute_out"],
        playerSubstitutesOnBench: json["player_substitutes_on_bench"],
        playerAssists: json["player_assists"],
        playerBirthdate: json["player_birthdate"],
        playerIsCaptain: json["player_is_captain"],
        playerShotsTotal: json["player_shots_total"],
        playerGoalsConceded: json["player_goals_conceded"],
        playerFoulsCommitted: json["player_fouls_committed"],
        playerTackles: json["player_tackles"],
        playerBlocks: json["player_blocks"],
        playerCrossesTotal: json["player_crosses_total"],
        playerInterceptions: json["player_interceptions"],
        playerClearances: json["player_clearances"],
        playerDispossesed: json["player_dispossesed"],
        playerSaves: json["player_saves"],
        playerInsideBoxSaves: json["player_inside_box_saves"],
        playerDuelsTotal: json["player_duels_total"],
        playerDuelsWon: json["player_duels_won"],
        playerDribbleAttempts: json["player_dribble_attempts"],
        playerDribbleSucc: json["player_dribble_succ"],
        playerPenComm: json["player_pen_comm"],
        playerPenWon: json["player_pen_won"],
        playerPenScored: json["player_pen_scored"],
        playerPenMissed: json["player_pen_missed"],
        playerPasses: json["player_passes"],
        playerPassesAccuracy: json["player_passes_accuracy"],
        playerKeyPasses: json["player_key_passes"],
        playerWoordworks: json["player_woordworks"],
        playerRating: json["player_rating"],
      );

  Map<String, dynamic> toJson() => {
        "player_key": playerKey,
        "player_id": playerId,
        "player_image": playerImage,
        "player_name": playerName,
        "player_number": playerNumber,
        "player_country": playerCountry,
        "player_age": playerAge,
        "player_match_played": playerMatchPlayed,
        "player_goals": playerGoals,
        "player_yellow_cards": playerYellowCards,
        "player_red_cards": playerRedCards,
        "player_substitute_out": playerSubstituteOut,
        "player_substitutes_on_bench": playerSubstitutesOnBench,
        "player_assists": playerAssists,
        "player_birthdate": playerBirthdate,
        "player_is_captain": playerIsCaptain,
        "player_shots_total": playerShotsTotal,
        "player_goals_conceded": playerGoalsConceded,
        "player_fouls_committed": playerFoulsCommitted,
        "player_tackles": playerTackles,
        "player_blocks": playerBlocks,
        "player_crosses_total": playerCrossesTotal,
        "player_interceptions": playerInterceptions,
        "player_clearances": playerClearances,
        "player_dispossesed": playerDispossesed,
        "player_saves": playerSaves,
        "player_inside_box_saves": playerInsideBoxSaves,
        "player_duels_total": playerDuelsTotal,
        "player_duels_won": playerDuelsWon,
        "player_dribble_attempts": playerDribbleAttempts,
        "player_dribble_succ": playerDribbleSucc,
        "player_pen_comm": playerPenComm,
        "player_pen_won": playerPenWon,
        "player_pen_scored": playerPenScored,
        "player_pen_missed": playerPenMissed,
        "player_passes": playerPasses,
        "player_passes_accuracy": playerPassesAccuracy,
        "player_key_passes": playerKeyPasses,
        "player_woordworks": playerWoordworks,
        "player_rating": playerRating,
      };
}
