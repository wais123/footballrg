import 'package:flutter/material.dart';
import 'package:football_ruang_guru/screen/details/tabs/matches_page.dart';
import 'package:football_ruang_guru/screen/details/tabs/standings_page.dart';

class DetailsPage extends StatefulWidget {
  var title;

  DetailsPage({Key? key, this.title}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  TabController? controller;

  void _handleTabSelection() {
    setState(() {
      if (controller!.index == 0) {
        StandingsPage();
      } else if (controller!.index == 1) {
        MatchesPage();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
    controller!.addListener(_handleTabSelection);
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
          child: Text(
            "${widget.title}",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            color: Color(0xffffffff),
            child: new TabBar(
                indicatorColor: Color(0xff2D2828),
                indicatorWeight: 3,
                controller: controller,
                tabs: <Widget>[
                  new Tab(
                    child: Text(
                      'STANDINGS',
                      style: new TextStyle(
                          fontSize: 14,
                          color: controller!.index == 0
                              ? Color(0xff2D2828)
                              : Color(0xff808285)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  new Tab(
                    child: Text(
                      'MATCHES',
                      style: new TextStyle(
                          fontSize: 14,
                          color: controller!.index == 1
                              ? Color(0xff2D2828)
                              : Color(0xff808285)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
          ),
          new Expanded(
              child: new TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: [
                Container(
                  child: StandingsPage(),
                ),
                Container(
                  child: MatchesPage(),
                ),
              ]))
        ],
      )),
    );
  }
}
