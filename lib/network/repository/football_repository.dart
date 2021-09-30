import 'package:football_ruang_guru/network/provider/football_provider.dart';
import 'package:football_ruang_guru/network/response/competitions_response.dart';
import 'package:football_ruang_guru/network/response/matches_response.dart';
import 'package:football_ruang_guru/network/response/standings_response.dart';

class FootballRepository {
  FootballProvider _apiProvider = FootballProvider();

  Future<CompetitionsResponse> competition(areas, plan) {
    return _apiProvider.competition(areas, plan);
  }

  Future<StandingsResponse> standing(id, token) {
    return _apiProvider.standing(id, token);
  }

  Future<MatchesResponse> matches(id, token, dateFrom, dateTo) {
    return _apiProvider.matches(id, token, dateFrom, dateTo);
  }
}
