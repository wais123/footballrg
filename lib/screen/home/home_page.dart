import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:football_ruang_guru/network/bloc/football_bloc.dart';
import 'package:football_ruang_guru/network/response/competitions_response.dart';
import 'package:football_ruang_guru/screen/details/detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:football_ruang_guru/helper/helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences? prefs;

  _sharepref() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _sharepref();
    footballBloc.getListCompetition(
        "2072,2224,2114,2081,2088,2163,2187", "TIER_ONE");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        titleSpacing: 0,
        backgroundColor: Colors.grey[600],
        title: Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: const Text(
            "My Football App",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [_buildStreamCompetition()],
        ),
      ),
    );
  }

  Widget _buildStreamCompetition() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 20),
      child: StreamBuilder<CompetitionsResponse>(
          stream: footballBloc.listCompetition.stream,
          builder: (context, AsyncSnapshot<CompetitionsResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.error != null &&
                  snapshot.data!.error!.length > 0) {
                return Helper.buildError(snapshot.data!.error!);
              }
              return _buildListCompetition(snapshot.data!);
            } else if (snapshot.hasError) {
              return Helper.buildError(snapshot.data!.error!);
            } else {
              return Helper.buildLoading();
            }
          }),
    );
  }

  Widget _buildListCompetition(CompetitionsResponse response) {
    return Container(
      child: GridView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 4 / 3.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 30),
          itemCount: response.competitions!.length,
          itemBuilder: (contex, index) {
            return GestureDetector(
              onTap: () {
                prefs!.setString(
                    "id", response.competitions![index].id.toString());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsPage(
                            title: response.competitions![index].name,
                          )),
                );
              },
              child: Center(
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1.5)),
                  child: Column(
                    children: [
                      SvgPicture.network(
                          "${response.competitions![index].area!.ensignUrl}",
                          width: 150,
                          placeholderBuilder: (context) => Center(
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator()))),
                      SizedBox(
                        height: 10,
                      ),
                      Text("${response.competitions![index].name}"),
                      Text("${response.competitions![index].area!.name}"),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
