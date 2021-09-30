import 'package:football_ruang_guru/network/repository/football_repository.dart';
import 'package:football_ruang_guru/network/response/competitions_response.dart';
import 'package:football_ruang_guru/network/response/matches_response.dart';
import 'package:football_ruang_guru/network/response/standings_response.dart';
import 'package:rxdart/rxdart.dart';

class FootballBloc {
  final FootballRepository _repositoryFootball = FootballRepository();
  final BehaviorSubject<CompetitionsResponse> _getListCompetition =
      BehaviorSubject<CompetitionsResponse>();
  final BehaviorSubject<StandingsResponse> _getListStanding =
      BehaviorSubject<StandingsResponse>();
  final BehaviorSubject<MatchesResponse> _getListMatches =
      BehaviorSubject<MatchesResponse>();

  getListCompetition(areas, plan) async {
    CompetitionsResponse response =
        await _repositoryFootball.competition(areas, plan);
    _getListCompetition.sink.add(response);
  }

  getListStanding(id, token) async {
    StandingsResponse response = await _repositoryFootball.standing(id, token);
    _getListStanding.sink.add(response);
  }

  getListMatches(id, token, dateFrom, dateTo) async {
    MatchesResponse response =
        await _repositoryFootball.matches(id, token, dateFrom, dateTo);
    _getListMatches.sink.add(response);
  }

  dispose() async {
    await _getListCompetition.drain();
    _getListCompetition.close();
    await _getListStanding.drain();
    _getListStanding.close();
    await _getListMatches.drain();
    _getListMatches.close();
  }

  BehaviorSubject<CompetitionsResponse> get listCompetition =>
      _getListCompetition;

  BehaviorSubject<StandingsResponse> get listStanding => _getListStanding;

  BehaviorSubject<MatchesResponse> get listMatches => _getListMatches;
}

final footballBloc = FootballBloc();
