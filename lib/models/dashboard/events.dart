// To parse this JSON data, do
//
//     final events = eventsFromJson(jsonString);

import 'dart:convert';

List<Events> eventsFromJson(String str) =>
    List<Events>.from(json.decode(str).map((x) => Events.fromJson(x)));

String eventsToJson(List<Events> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Events {
  Events({
    required this.matchId,
    required this.countryId,
    required this.countryName,
    required this.leagueId,
    required this.leagueName,
    required this.matchDate,
    required this.matchStatus,
    required this.matchTime,
    required this.matchHometeamId,
    required this.matchHometeamName,
    required this.matchHometeamScore,
    required this.matchAwayteamName,
    required this.matchAwayteamId,
    required this.matchAwayteamScore,
    required this.matchHometeamHalftimeScore,
    required this.matchAwayteamHalftimeScore,
    required this.matchHometeamExtraScore,
    required this.matchAwayteamExtraScore,
    required this.matchHometeamPenaltyScore,
    required this.matchAwayteamPenaltyScore,
    required this.matchHometeamFtScore,
    required this.matchAwayteamFtScore,
    required this.matchHometeamSystem,
    required this.matchAwayteamSystem,
    required this.matchLive,
    required this.matchRound,
    required this.matchStadium,
    required this.matchReferee,
    required this.teamHomeBadge,
    required this.teamAwayBadge,
    required this.leagueLogo,
    required this.countryLogo,
    required this.leagueYear,
    required this.fkStageKey,
    required this.stageName,
    required this.goalscorer,
    required this.cards,
    required this.substitutions,
    required this.lineup,
    required this.statistics,
    required this.statistics1Half,
  });

  String matchId;
  String countryId;
  String countryName;
  String leagueId;
  String leagueName;
  DateTime matchDate;
  String matchStatus;
  String matchTime;
  String matchHometeamId;
  String matchHometeamName;
  String matchHometeamScore;
  String matchAwayteamName;
  String matchAwayteamId;
  String matchAwayteamScore;
  String matchHometeamHalftimeScore;
  String matchAwayteamHalftimeScore;
  String matchHometeamExtraScore;
  String matchAwayteamExtraScore;
  String matchHometeamPenaltyScore;
  String matchAwayteamPenaltyScore;
  String matchHometeamFtScore;
  String matchAwayteamFtScore;
  MatchTeamSystem matchHometeamSystem;
  MatchTeamSystem matchAwayteamSystem;
  String matchLive;
  String matchRound;
  String matchStadium;
  String matchReferee;
  String teamHomeBadge;
  String teamAwayBadge;
  String leagueLogo;
  String countryLogo;
  String leagueYear;
  String fkStageKey;
  String stageName;
  List<Goalscorer> goalscorer;
  List<CardElement> cards;
  Substitutions substitutions;
  Lineup lineup;
  List<Statistic> statistics;
  List<Statistic> statistics1Half;

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        matchId: json["match_id"],
        countryId: json["country_id"],
        countryName: json["country_name"],
        leagueId: json["league_id"],
        leagueName: json["league_name"],
        matchDate: DateTime.parse(json["match_date"]),
        matchStatus: json["match_status"],
        matchTime: json["match_time"],
        matchHometeamId: json["match_hometeam_id"],
        matchHometeamName: json["match_hometeam_name"],
        matchHometeamScore: json["match_hometeam_score"],
        matchAwayteamName: json["match_awayteam_name"],
        matchAwayteamId: json["match_awayteam_id"],
        matchAwayteamScore: json["match_awayteam_score"],
        matchHometeamHalftimeScore: json["match_hometeam_halftime_score"],
        matchAwayteamHalftimeScore: json["match_awayteam_halftime_score"],
        matchHometeamExtraScore: json["match_hometeam_extra_score"],
        matchAwayteamExtraScore: json["match_awayteam_extra_score"],
        matchHometeamPenaltyScore: json["match_hometeam_penalty_score"],
        matchAwayteamPenaltyScore: json["match_awayteam_penalty_score"],
        matchHometeamFtScore: json["match_hometeam_ft_score"],
        matchAwayteamFtScore: json["match_awayteam_ft_score"],
        matchHometeamSystem:
            matchTeamSystemValues.map[json["match_hometeam_system"]] ?? MatchTeamSystem.EMPTY,
        matchAwayteamSystem:
            matchTeamSystemValues.map[json["match_awayteam_system"]] ?? MatchTeamSystem.EMPTY,
        matchLive: json["match_live"],
        matchRound: json["match_round"],
        matchStadium: json["match_stadium"],
        matchReferee: json["match_referee"],
        teamHomeBadge: json["team_home_badge"],
        teamAwayBadge: json["team_away_badge"],
        leagueLogo: json["league_logo"],
        countryLogo: json["country_logo"],
        leagueYear: json["league_year"],
        fkStageKey: json["fk_stage_key"],
        stageName: json["stage_name"],
        goalscorer: List<Goalscorer>.from(
            json["goalscorer"].map((x) => Goalscorer.fromJson(x))),
        cards: List<CardElement>.from(
            json["cards"].map((x) => CardElement.fromJson(x))),
        substitutions: Substitutions.fromJson(json["substitutions"]),
        lineup: Lineup.fromJson(json["lineup"]),
        statistics: List<Statistic>.from(
            json["statistics"].map((x) => Statistic.fromJson(x))),
        statistics1Half: List<Statistic>.from(
            json["statistics_1half"].map((x) => Statistic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "match_id": matchId,
        "country_id": countryId,
        "country_name": countryName,
        "league_id": leagueId,
        "league_name": leagueName,
        "match_date":
            "${matchDate.year.toString().padLeft(4, '0')}-${matchDate.month.toString().padLeft(2, '0')}-${matchDate.day.toString().padLeft(2, '0')}",
        "match_status": matchStatus,
        "match_time": matchTime,
        "match_hometeam_id": matchHometeamId,
        "match_hometeam_name": matchHometeamName,
        "match_hometeam_score": matchHometeamScore,
        "match_awayteam_name": matchAwayteamName,
        "match_awayteam_id": matchAwayteamId,
        "match_awayteam_score": matchAwayteamScore,
        "match_hometeam_halftime_score": matchHometeamHalftimeScore,
        "match_awayteam_halftime_score": matchAwayteamHalftimeScore,
        "match_hometeam_extra_score": matchHometeamExtraScore,
        "match_awayteam_extra_score": matchAwayteamExtraScore,
        "match_hometeam_penalty_score": matchHometeamPenaltyScore,
        "match_awayteam_penalty_score": matchAwayteamPenaltyScore,
        "match_hometeam_ft_score": matchHometeamFtScore,
        "match_awayteam_ft_score": matchAwayteamFtScore,
        "match_hometeam_system":
            matchTeamSystemValues.reverse[matchHometeamSystem],
        "match_awayteam_system":
            matchTeamSystemValues.reverse[matchAwayteamSystem],
        "match_live": matchLive,
        "match_round": matchRound,
        "match_stadium": matchStadium,
        "match_referee": matchReferee,
        "team_home_badge": teamHomeBadge,
        "team_away_badge": teamAwayBadge,
        "league_logo": leagueLogo,
        "country_logo": countryLogo,
        "league_year": leagueYear,
        "fk_stage_key": fkStageKey,
        "stage_name": stageName,
        "goalscorer": List<dynamic>.from(goalscorer.map((x) => x.toJson())),
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
        "substitutions": substitutions.toJson(),
        "lineup": lineup.toJson(),
        "statistics": List<dynamic>.from(statistics.map((x) => x.toJson())),
        "statistics_1half":
            List<dynamic>.from(statistics1Half.map((x) => x.toJson())),
      };
}

class CardElement {
  CardElement({
    required this.time,
    required this.homeFault,
    required this.card,
    required this.awayFault,
    required this.info,
    required this.homePlayerId,
    required this.awayPlayerId,
    required this.scoreInfoTime,
  });

  String time;
  String homeFault;
  CardEnum card;
  String awayFault;
  Info info;
  String homePlayerId;
  String awayPlayerId;
  ScoreInfoTime scoreInfoTime;

  factory CardElement.fromJson(Map<String, dynamic> json) => CardElement(
        time: json["time"],
        homeFault: json["home_fault"],
        card: cardEnumValues.map[json["card"]] ?? CardEnum.YELLOW_CARD,
        awayFault: json["away_fault"],
        info: infoValues.map[json["info"]] ?? Info.EMPTY,
        homePlayerId: json["home_player_id"],
        awayPlayerId: json["away_player_id"],
        scoreInfoTime: scoreInfoTimeValues.map[json["score_info_time"]] ?? ScoreInfoTime.THE_1_ST_HALF,
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "home_fault": homeFault,
        "card": cardEnumValues.reverse[card],
        "away_fault": awayFault,
        "info": infoValues.reverse[info],
        "home_player_id": homePlayerId,
        "away_player_id": awayPlayerId,
        "score_info_time": scoreInfoTimeValues.reverse[scoreInfoTime],
      };
}

enum CardEnum { YELLOW_CARD, RED_CARD }

final cardEnumValues = EnumValues(
    {"red card": CardEnum.RED_CARD, "yellow card": CardEnum.YELLOW_CARD});

enum Info { EMPTY, AWAY, HOME, PENALTY }

final infoValues = EnumValues({
  "away": Info.AWAY,
  "": Info.EMPTY,
  "home": Info.HOME,
  "Penalty": Info.PENALTY
});

enum ScoreInfoTime { THE_1_ST_HALF, THE_2_ND_HALF }

final scoreInfoTimeValues = EnumValues({
  "1st Half": ScoreInfoTime.THE_1_ST_HALF,
  "2nd Half": ScoreInfoTime.THE_2_ND_HALF
});

class Goalscorer {
  Goalscorer({
    required this.time,
    required this.homeScorer,
    required this.homeScorerId,
    required this.homeAssist,
    required this.homeAssistId,
    required this.score,
    required this.awayScorer,
    required this.awayScorerId,
    required this.awayAssist,
    required this.awayAssistId,
    required this.info,
    required this.scoreInfoTime,
  });

  String time;
  String homeScorer;
  String homeScorerId;
  String homeAssist;
  String homeAssistId;
  String score;
  String awayScorer;
  String awayScorerId;
  String awayAssist;
  String awayAssistId;
  Info info;
  ScoreInfoTime scoreInfoTime;

  factory Goalscorer.fromJson(Map<String, dynamic> json) => Goalscorer(
        time: json["time"],
        homeScorer: json["home_scorer"],
        homeScorerId: json["home_scorer_id"],
        homeAssist: json["home_assist"],
        homeAssistId: json["home_assist_id"],
        score: json["score"],
        awayScorer: json["away_scorer"],
        awayScorerId: json["away_scorer_id"],
        awayAssist: json["away_assist"],
        awayAssistId: json["away_assist_id"],
        info: infoValues.map[json["info"]] ?? Info.EMPTY,
        scoreInfoTime: scoreInfoTimeValues.map[json["score_info_time"]] ?? ScoreInfoTime.THE_1_ST_HALF,
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "home_scorer": homeScorer,
        "home_scorer_id": homeScorerId,
        "home_assist": homeAssist,
        "home_assist_id": homeAssistId,
        "score": score,
        "away_scorer": awayScorer,
        "away_scorer_id": awayScorerId,
        "away_assist": awayAssist,
        "away_assist_id": awayAssistId,
        "info": infoValues.reverse[info],
        "score_info_time": scoreInfoTimeValues.reverse[scoreInfoTime],
      };
}

class Lineup {
  Lineup({
    required this.home,
    required this.away,
  });

  LineupAway home;
  LineupAway away;

  factory Lineup.fromJson(Map<String, dynamic> json) => Lineup(
        home: LineupAway.fromJson(json["home"]),
        away: LineupAway.fromJson(json["away"]),
      );

  Map<String, dynamic> toJson() => {
        "home": home.toJson(),
        "away": away.toJson(),
      };
}

class LineupAway {
  LineupAway({
    required this.startingLineups,
    required this.substitutes,
    required this.coach,
    required this.missingPlayers,
  });

  List<Coach> startingLineups;
  List<Coach> substitutes;
  List<Coach> coach;
  List<dynamic> missingPlayers;

  factory LineupAway.fromJson(Map<String, dynamic> json) => LineupAway(
        startingLineups: List<Coach>.from(
            json["starting_lineups"].map((x) => Coach.fromJson(x))),
        substitutes:
            List<Coach>.from(json["substitutes"].map((x) => Coach.fromJson(x))),
        coach: List<Coach>.from(json["coach"].map((x) => Coach.fromJson(x))),
        missingPlayers:
            List<dynamic>.from(json["missing_players"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "starting_lineups":
            List<dynamic>.from(startingLineups.map((x) => x.toJson())),
        "substitutes": List<dynamic>.from(substitutes.map((x) => x.toJson())),
        "coach": List<dynamic>.from(coach.map((x) => x.toJson())),
        "missing_players": List<dynamic>.from(missingPlayers.map((x) => x)),
      };
}

class Coach {
  Coach({
    required this.lineupPlayer,
    required this.lineupNumber,
    required this.lineupPosition,
    required this.playerKey,
  });

  String lineupPlayer;
  String lineupNumber;
  String lineupPosition;
  String playerKey;

  factory Coach.fromJson(Map<String, dynamic> json) => Coach(
        lineupPlayer: json["lineup_player"],
        lineupNumber: json["lineup_number"],
        lineupPosition: json["lineup_position"],
        playerKey: json["player_key"],
      );

  Map<String, dynamic> toJson() => {
        "lineup_player": lineupPlayer,
        "lineup_number": lineupNumber,
        "lineup_position": lineupPosition,
        "player_key": playerKey,
      };
}

enum MatchTeamSystem {
  THE_4231,
  EMPTY,
  THE_433,
  THE_4411,
  THE_541,
  THE_442,
  THE_3412,
  THE_343,
  THE_4141,
  THE_3421,
  THE_4312,
  THE_532,
  THE_352
}

final matchTeamSystemValues = EnumValues({
  "": MatchTeamSystem.EMPTY,
  "3-4-1-2": MatchTeamSystem.THE_3412,
  "3-4-2-1": MatchTeamSystem.THE_3421,
  "3-4-3": MatchTeamSystem.THE_343,
  "3-5-2": MatchTeamSystem.THE_352,
  "4-1-4-1": MatchTeamSystem.THE_4141,
  "4-2-3-1": MatchTeamSystem.THE_4231,
  "4-3-1-2": MatchTeamSystem.THE_4312,
  "4-3-3": MatchTeamSystem.THE_433,
  "4-4-1-1": MatchTeamSystem.THE_4411,
  "4-4-2": MatchTeamSystem.THE_442,
  "5-3-2": MatchTeamSystem.THE_532,
  "5-4-1": MatchTeamSystem.THE_541
});
class Statistic {
  Statistic({
    required this.type,
    required this.home,
    required this.away,
  });

  String type;
  String home;
  String away;

  factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
        type: json["type"],
        home: json["home"],
        away: json["away"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "home": home,
        "away": away,
      };
}

class Substitutions {
  Substitutions({
    required this.home,
    required this.away,
  });

  List<AwayElement> home;
  List<AwayElement> away;

  factory Substitutions.fromJson(Map<String, dynamic> json) => Substitutions(
        home: List<AwayElement>.from(
            json["home"].map((x) => AwayElement.fromJson(x))),
        away: List<AwayElement>.from(
            json["away"].map((x) => AwayElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "home": List<dynamic>.from(home.map((x) => x.toJson())),
        "away": List<dynamic>.from(away.map((x) => x.toJson())),
      };
}

class AwayElement {
  AwayElement({
    required this.time,
    required this.substitution,
    required this.substitutionPlayerId,
  });

  String time;
  String substitution;
  String substitutionPlayerId;

  factory AwayElement.fromJson(Map<String, dynamic> json) => AwayElement(
        time: json["time"],
        substitution: json["substitution"],
        substitutionPlayerId: json["substitution_player_id"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "substitution": substitution,
        "substitution_player_id": substitutionPlayerId,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
      reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
