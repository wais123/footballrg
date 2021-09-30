import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:football_ruang_guru/helper/helper.dart';
import 'package:football_ruang_guru/network/bloc/football_bloc.dart';
import 'package:football_ruang_guru/network/response/standings_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({Key? key}) : super(key: key);

  @override
  _StandingsPageState createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  SharedPreferences? prefs;

  _sharepref() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      footballBloc.getListStanding(
          prefs!.getString("id")!, "b7dddd08c9cf4abf96be4b0d010da3b8");
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: _buildStreamStanding(),
      ),
    );
  }

  Widget _buildStreamStanding() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 20),
      child: StreamBuilder<StandingsResponse>(
          stream: footballBloc.listStanding.stream,
          builder: (context, AsyncSnapshot<StandingsResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.error != null &&
                  snapshot.data!.error!.length > 0) {
                return Helper.buildError(snapshot.data!.error!);
              }
              return _buildListStanding(snapshot.data!);
            } else if (snapshot.hasError) {
              return Helper.buildError(snapshot.data!.error!);
            } else {
              return Helper.buildLoading();
            }
          }),
    );
  }

  Widget _buildListStanding(StandingsResponse response) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        // physics: NeverScrollableScrollPhysics(),
        // shrinkWrap: true,
        children: [
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      children: [
                        Text(""),
                        Text(""),
                        Text(""),
                        Text(""),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      children: [
                        Container(
                            width: 50,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Center(
                                child: Text(
                              "Pt",
                              style: TextStyle(color: Colors.black26),
                            ))),
                        Container(
                            width: 50,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Center(
                                child: Text("P",
                                    style: TextStyle(color: Colors.black26)))),
                        Container(
                            width: 50,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Center(
                                child: Text("W",
                                    style: TextStyle(color: Colors.black26)))),
                        Container(
                            width: 50,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Center(
                                child: Text("D",
                                    style: TextStyle(color: Colors.black26)))),
                        Container(
                            width: 50,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Center(
                                child: Text("L",
                                    style: TextStyle(color: Colors.black26)))),
                        Container(
                            width: 50,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Center(
                                child: Text("GF",
                                    style: TextStyle(color: Colors.black26)))),
                        Container(
                            width: 50,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Center(
                                child: Text("GA",
                                    style: TextStyle(color: Colors.black26)))),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: response.standings!.length,
                itemBuilder: (contex, index) {
                  return Container(
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: response.standings![index].table!.length,
                        itemBuilder: (context, i) {
                          print(
                              "datattttttt ${response.standings![index].table![i].position}");
                          print(
                              "datattttttt ${response.standings![index].table![i].team!.crestUrl}");
                          return Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: 40,
                                                  child: Center(
                                                      child: Text(
                                                          "${response.standings![index].table![i].position}. "))),
                                              Container(
                                                  width: 50,
                                                  child: Center(
                                                      child: SvgPicture.network(
                                                    "${response.standings![index].table![i].team!.crestUrl}",
                                                    placeholderBuilder:
                                                        (context) => Container(
                                                            height: 20,
                                                            width: 20,
                                                            child:
                                                                CircularProgressIndicator()),
                                                    height: 20,
                                                  ))),
                                              Text(
                                                  " ${response.standings![index].table![i].team!.name}"),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: 50,
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Center(
                                                      child: Text(
                                                          "${response.standings![index].table![i].points}"))),
                                              Container(
                                                  width: 50,
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Center(
                                                      child: Text(
                                                          "${response.standings![index].table![i].playedGames}"))),
                                              Container(
                                                  width: 50,
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Center(
                                                      child: Text(
                                                          "${response.standings![index].table![i].won}"))),
                                              Container(
                                                  width: 50,
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Center(
                                                      child: Text(
                                                          "${response.standings![index].table![i].draw}"))),
                                              Container(
                                                  width: 50,
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Center(
                                                      child: Text(
                                                          "${response.standings![index].table![i].lost}"))),
                                              Container(
                                                  width: 50,
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Center(
                                                      child: Text(
                                                          "${response.standings![index].table![i].goalsFor}"))),
                                              Container(
                                                  width: 50,
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Center(
                                                      child: Text(
                                                          "${response.standings![index].table![i].goalsAgainst}"))),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          );
                        }),
                  );
                }),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
