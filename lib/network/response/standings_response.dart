class StandingsResponse {
  StandingsResponse({
    this.filters,
    this.competition,
    this.season,
    this.standings,
    this.error,
  });

  Filters? filters;
  Competition? competition;
  Season? season;
  List<Standing>? standings;
  String? error;

  StandingsResponse.fromJson(Map<String, dynamic> json)
      : filters = Filters.fromJson(json["filters"]),
        competition = Competition.fromJson(json["competition"]),
        season = Season.fromJson(json["season"]),
        standings = List<Standing>.from(
            json["standings"].map((x) => Standing.fromJson(x)));

  StandingsResponse.withError(String errorValue)
      : standings = null,
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

class Season {
  Season({
    this.id,
    this.startDate,
    this.endDate,
    this.currentMatchday,
    this.winner,
  });

  int? id;
  String? startDate;
  String? endDate;
  int? currentMatchday;
  dynamic? winner;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        id: json["id"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        currentMatchday: json["currentMatchday"],
        winner: json["winner"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startDate": startDate,
        "endDate": endDate,
        "currentMatchday": currentMatchday,
        "winner": winner,
      };
}

class Standing {
  Standing({
    this.stage,
    this.type,
    this.group,
    this.table,
  });

  String? stage;
  String? type;
  dynamic? group;
  List<Table>? table;

  factory Standing.fromJson(Map<String, dynamic> json) => Standing(
        stage: json["stage"],
        type: json["type"],
        group: json["group"],
        table: List<Table>.from(json["table"].map((x) => Table.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stage": stage,
        "type": type,
        "group": group,
        "table": List<dynamic>.from(table!.map((x) => x.toJson())),
      };
}

class Table {
  Table({
    this.position,
    this.team,
    this.playedGames,
    this.form,
    this.won,
    this.draw,
    this.lost,
    this.points,
    this.goalsFor,
    this.goalsAgainst,
    this.goalDifference,
  });

  int? position;
  Team? team;
  int? playedGames;
  dynamic? form;
  int? won;
  int? draw;
  int? lost;
  int? points;
  int? goalsFor;
  int? goalsAgainst;
  int? goalDifference;

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        position: json["position"],
        team: Team.fromJson(json["team"]),
        playedGames: json["playedGames"],
        form: json["form"],
        won: json["won"],
        draw: json["draw"],
        lost: json["lost"],
        points: json["points"],
        goalsFor: json["goalsFor"],
        goalsAgainst: json["goalsAgainst"],
        goalDifference: json["goalDifference"],
      );

  Map<String, dynamic> toJson() => {
        "position": position,
        "team": team,
        "playedGames": playedGames,
        "form": form,
        "won": won,
        "draw": draw,
        "lost": lost,
        "points": points,
        "goalsFor": goalsFor,
        "goalsAgainst": goalsAgainst,
        "goalDifference": goalDifference,
      };
}

class Team {
  Team({
    this.id,
    this.name,
    this.crestUrl,
  });

  int? id;
  String? name;
  String? crestUrl;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
        crestUrl: json["crestUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "crestUrl": crestUrl,
      };
}
