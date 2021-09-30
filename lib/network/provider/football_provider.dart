import 'package:dio/dio.dart';
import 'package:football_ruang_guru/network/response/competitions_response.dart';
import 'package:football_ruang_guru/network/response/matches_response.dart';
import 'package:football_ruang_guru/network/response/standings_response.dart';

class FootballProvider {
  static const String _BASEURL = "https://api.football-data.org";
  static const String _API_PREFIX = "/v2";
  final String _competitions = _BASEURL + _API_PREFIX + "/competitions";
  final String _standing = _BASEURL + _API_PREFIX + "/competitions";
  final String _matches = _BASEURL + _API_PREFIX + "/competitions";

  Dio _dio = new Dio();

  ProviderData() {
    BaseOptions options =
        BaseOptions(receiveTimeout: 10000, connectTimeout: 10000);
    _dio = Dio(options);
  }

  Future<CompetitionsResponse> competition(areas, plan) async {
    try {
      Response response = await _dio.get(
        _competitions,
        queryParameters: {
          "areas": areas,
          "plan": plan,
        },
      );
      return CompetitionsResponse.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CompetitionsResponse.withError(_handleError(error));
    }
  }

  Future<StandingsResponse> standing(id, token) async {
    try {
      Response response =
          await _dio.get(_standing + "/" + id.toString() + "/standings",
              options: Options(headers: {
                "X-Auth-Token": "$token",
              }));
      return StandingsResponse.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return StandingsResponse.withError(_handleError(error));
    }
  }

  Future<MatchesResponse> matches(id, token, dateFrom, dateTo) async {
    try {
      Response response =
          await _dio.get(_matches + "/" + id.toString() + "/matches",
              options: Options(headers: {
                "X-Auth-Token": "$token",
              }),
              queryParameters: {"dateFrom": dateFrom, "dateTo": dateTo});
      return MatchesResponse.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MatchesResponse.withError(_handleError(error));
    }
  }

  String _handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          errorDescription =
              "Received invalid status code: ${error.response!.statusCode}";
          break;
        case DioErrorType.sendTimeout:
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}
