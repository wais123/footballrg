class CompetitionsResponse {
  CompetitionsResponse({
    this.count,
    this.filters,
    this.competitions,
    this.error,
  });

  int? count;
  Filters? filters;
  List<Competition>? competitions;
  String? error;

  CompetitionsResponse.fromJson(Map<String, dynamic> json)
      : count = json["count"],
        filters = Filters.fromJson(json["filters"]),
        competitions = List<Competition>.from(
            json["competitions"].map((x) => Competition.fromJson(x)));

  CompetitionsResponse.withError(String errorValue)
      : competitions = null,
        error = errorValue;
}

class Competition {
  Competition({
    this.id,
    this.area,
    this.name,
    this.code,
    this.emblemUrl,
    this.plan,
    this.currentSeason,
    this.numberOfAvailableSeasons,
    this.lastUpdated,
  });

  int? id;
  Area? area;
  String? name;
  String? code;
  String? emblemUrl;
  String? plan;
  CurrentSeason? currentSeason;
  int? numberOfAvailableSeasons;
  DateTime? lastUpdated;

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
        id: json["id"],
        area: Area.fromJson(json["area"]),
        name: json["name"],
        code: json["code"],
        emblemUrl: json["emblemUrl"] == null ? null : json["emblemUrl"],
        plan: json["plan"],
        currentSeason: CurrentSeason.fromJson(json["currentSeason"]),
        numberOfAvailableSeasons: json["numberOfAvailableSeasons"],
        lastUpdated: DateTime.parse(json["lastUpdated"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
        "name": name,
        "code": code,
        "emblemUrl": emblemUrl == null ? null : emblemUrl,
        "plan": plan,
        "currentSeason": currentSeason,
        "numberOfAvailableSeasons": numberOfAvailableSeasons,
        "lastUpdated": lastUpdated,
      };
}

class Area {
  Area({
    this.id,
    this.name,
    this.countryCode,
    this.ensignUrl,
  });

  int? id;
  String? name;
  String? countryCode;
  String? ensignUrl;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
        countryCode: json["countryCode"],
        ensignUrl: json["ensignUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "countryCode": countryCode,
        "ensignUrl": ensignUrl,
      };
}

class CurrentSeason {
  CurrentSeason({
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

  factory CurrentSeason.fromJson(Map<String, dynamic> json) => CurrentSeason(
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

class Filters {
  Filters({
    this.areas,
    this.plan,
  });

  List<int>? areas;
  String? plan;

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        areas: List<int>.from(json["areas"].map((x) => x)),
        plan: json["plan"],
      );

  Map<String, dynamic> toJson() => {
        "areas": List<dynamic>.from(areas!.map((x) => x)),
        "plan": plan,
      };
}
