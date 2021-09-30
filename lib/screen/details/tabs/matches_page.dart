import 'package:flutter/material.dart';
import 'package:football_ruang_guru/helper/helper.dart';
import 'package:football_ruang_guru/network/bloc/football_bloc.dart';
import 'package:football_ruang_guru/network/response/matches_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({Key? key}) : super(key: key);

  @override
  _MatchesPageState createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  SharedPreferences? prefs;

  _sharepref() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      footballBloc.getListMatches(prefs!.getString("id")!,
          "b7dddd08c9cf4abf96be4b0d010da3b8", "2021-09-01", "2021-09-29");
    });
  }

  @override
  void initState() {
    super.initState();
    _sharepref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildStreamStanding(),
    );
  }

  Widget _buildStreamStanding() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 20),
      child: StreamBuilder<MatchesResponse>(
          stream: footballBloc.listMatches.stream,
          builder: (context, AsyncSnapshot<MatchesResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.error != null &&
                  snapshot.data!.error!.length > 0) {
                return Helper.buildError(snapshot.data!.error!);
              }
              return _buildListMatches(snapshot.data!);
            } else if (snapshot.hasError) {
              return Helper.buildError(snapshot.data!.error!);
            } else {
              return Helper.buildLoading();
            }
          }),
    );
  }

  Widget _buildListMatches(MatchesResponse response) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListView.builder(
          itemCount: response.matches!.length,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1.5)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Center(
                              child: Text(
                                  "${response.matches![index].homeTeam!.name}",
                                  style: TextStyle(color: Colors.black)))),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Center(
                              child: Text(
                                  "${response.matches![index].awayTeam!.name}",
                                  style: TextStyle(color: Colors.black)))),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Center(
                                  child: Text(
                                      "${response.matches![index].status}",
                                      style: TextStyle(color: Colors.black)))),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Center(
                                  child: response.matches![index].score!
                                              .fullTime!.homeTeam ==
                                          null
                                      ? Text("0")
                                      : Text(
                                          "${response.matches![index].score!.fullTime!.homeTeam}",
                                          style:
                                              TextStyle(color: Colors.black)))),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Center(
                                  child: response.matches![index].score!
                                              .fullTime!.awayTeam ==
                                          null
                                      ? Text("0")
                                      : Text(
                                          "${response.matches![index].score!.fullTime!.awayTeam}",
                                          style:
                                              TextStyle(color: Colors.black)))),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
