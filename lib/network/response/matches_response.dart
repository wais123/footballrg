class MatchesResponse {
  MatchesResponse({
    this.count,
    this.filters,
    this.competition,
    this.matches,
    this.error,
  });

  int? count;
  Filters? filters;
  Competition? competition;
  List<Match>? matches;
  String? error;

  MatchesResponse.fromJson(Map<String, dynamic> json)
      : count = json["count"],
        filters = Filters.fromJson(json["filters"]),
        competition = Competition.fromJson(json["competition"]),
        matches =
            List<Match>.from(json["matches"].map((x) => Match.fromJson(x)));

  MatchesResponse.withError(String errorValue)
      : matches = null,
        error = errorValue;
}

class Competition {
  Competition({
    this.id,
    this.area,
    this.name,
    this.code,
    this.plan,
    this.lastUpdated,
  });

  int? id;
  Area? area;
  String? name;
  String? code;
  String? plan;
  String? lastUpdated;

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
        id: json["id"],
        area: Area.fromJson(json["area"]),
        name: json["name"],
        code: json["code"],
        plan: json["plan"],
        lastUpdated: json["lastUpdated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
        "name": name,
        "code": code,
        "plan": plan,
        "lastUpdated": lastUpdated,
      };
}

class Area {
  Area({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Filters {
  Filters();

  factory Filters.fromJson(Map<String, dynamic> json) => Filters();

  Map<String, dynamic> toJson() => {};
}

class Match {
  Match({
    this.id,
    this.season,
    this.utcDate,
    this.status,
    this.matchday,
    this.stage,
    this.group,
    this.lastUpdated,
    this.odds,
    this.score,
    this.homeTeam,
    this.awayTeam,
    this.referees,
  });

  int? id;
  Season? season;
  String? utcDate;
  String? status;
  int? matchday;
  String? stage;
  dynamic? group;
  String? lastUpdated;
  Odds? odds;
  Score? score;
  HomeTeam? homeTeam;
  AwayTeam? awayTeam;
  List<dynamic>? referees;

  factory Match.fromJson(Map<String, dynamic> json) => Match(
        id: json["id"],
        season: Season.fromJson(json["season"]),
        utcDate: json["utcDate"],
        status: json["status"],
        matchday: json["matchday"],
        stage: json["stage"],
        group: json["group"],
        lastUpdated: json["lastUpdated"],
        odds: Odds.fromJson(json["odds"]),
        score: Score.fromJson(json["score"]),
        homeTeam: HomeTeam.fromJson(json["homeTeam"]),
        awayTeam: AwayTeam.fromJson(json["awayTeam"]),
        referees: List<dynamic>.from(json["referees"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "season": season,
        "utcDate": utcDate,
        "status": status,
        "matchday": matchday,
        "stage": stage,
        "group": group,
        "lastUpdated": lastUpdated,
        "odds": odds!.toJson(),
        "score": score!.toJson(),
        "homeTeam": homeTeam,
        "awayTeam": awayTeam,
        "referees": List<dynamic>.from(referees!.map((x) => x)),
      };
}

class HomeTeam {
  HomeTeam({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory HomeTeam.fromJson(Map<String, dynamic> json) => HomeTeam(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class AwayTeam {
  AwayTeam({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory AwayTeam.fromJson(Map<String, dynamic> json) => AwayTeam(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Odds {
  Odds({
    this.msg,
  });

  String? msg;

  factory Odds.fromJson(Map<String, dynamic> json) => Odds(
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
      };
}

class Score {
  Score({
    this.winner,
    this.duration,
    this.fullTime,
    this.halfTime,
    this.extraTime,
    this.penalties,
  });

  String? winner;
  String? duration;
  FullTime? fullTime;
  HalfTime? halfTime;
  ExtraTime? extraTime;
  Penalties? penalties;

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        winner: json["winner"],
        duration: json["duration"],
        fullTime: FullTime.fromJson(json["fullTime"]),
        halfTime: HalfTime.fromJson(json["halfTime"]),
        extraTime: ExtraTime.fromJson(json["extraTime"]),
        penalties: Penalties.fromJson(json["penalties"]),
      );

  Map<String, dynamic> toJson() => {
        "winner": winner,
        "duration": duration,
        "fullTime": fullTime!.toJson(),
        "halfTime": halfTime!.toJson(),
        "extraTime": extraTime!.toJson(),
        "penalties": penalties!.toJson(),
      };
}

class FullTime {
  FullTime({
    this.homeTeam,
    this.awayTeam,
  });

  int? homeTeam;
  int? awayTeam;

  factory FullTime.fromJson(Map<String, dynamic> json) => FullTime(
        homeTeam: json["homeTeam"] == null ? null : json["homeTeam"],
        awayTeam: json["awayTeam"] == null ? null : json["awayTeam"],
      );

  Map<String, dynamic> toJson() => {
        "homeTeam": homeTeam == null ? null : homeTeam,
        "awayTeam": awayTeam == null ? null : awayTeam,
      };
}

class HalfTime {
  HalfTime({
    this.homeTeam,
    this.awayTeam,
  });

  int? homeTeam;
  int? awayTeam;

  factory HalfTime.fromJson(Map<String, dynamic> json) => HalfTime(
        homeTeam: json["homeTeam"] == null ? null : json["homeTeam"],
        awayTeam: json["awayTeam"] == null ? null : json["awayTeam"],
      );

  Map<String, dynamic> toJson() => {
        "homeTeam": homeTeam == null ? null : homeTeam,
        "awayTeam": awayTeam == null ? null : awayTeam,
      };
}

class ExtraTime {
  ExtraTime({
    this.homeTeam,
    this.awayTeam,
  });

  int? homeTeam;
  int? awayTeam;

  factory ExtraTime.fromJson(Map<String, dynamic> json) => ExtraTime(
        homeTeam: json["homeTeam"] == null ? null : json["homeTeam"],
        awayTeam: json["awayTeam"] == null ? null : json["awayTeam"],
      );

  Map<String, dynamic> toJson() => {
        "homeTeam": homeTeam == null ? null : homeTeam,
        "awayTeam": awayTeam == null ? null : awayTeam,
      };
}

class Penalties {
  Penalties({
    this.homeTeam,
    this.awayTeam,
  });

  int? homeTeam;
  int? awayTeam;

  factory Penalties.fromJson(Map<String, dynamic> json) => Penalties(
        homeTeam: json["homeTeam"] == null ? null : json["homeTeam"],
        awayTeam: json["awayTeam"] == null ? null : json["awayTeam"],
      );

  Map<String, dynamic> toJson() => {
        "homeTeam": homeTeam == null ? null : homeTeam,
        "awayTeam": awayTeam == null ? null : awayTeam,
      };
}

class Season {
  Season({
    this.id,
    this.startDate,
    this.endDate,
    this.currentMatchday,
  });

  int? id;
  String? startDate;
  String? endDate;
  int? currentMatchday;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        id: json["id"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        currentMatchday: json["currentMatchday"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startDate": startDate,
        "endDate": endDate,
        "currentMatchday": currentMatchday,
      };
}
