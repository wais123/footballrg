import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_ruang_guru/screen/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ],
  ).then((val) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FottBall RuangGuru',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'My Football App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _connectionStatus = 'Unknown';
  bool? connect;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        connect = true;
        startSplashScreen();
        break;
      case ConnectivityResult.mobile:
        connect = true;
        startSplashScreen();
        break;
      case ConnectivityResult.none:
        connect = false;
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        connect = false;
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return HomePage();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: connect == true
            ? Center(
                child: Text(
                "My Football Apps",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[500]),
              ))
            : Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Failed to get connectivity.",
                    style: TextStyle(color: Colors.blue[500]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildButtonRek(),
                ],
              )),
      ),
    );
  }

  Widget _buildButtonRek() {
    return Container(
      height: 45,
      // margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff1D4D4E),
                Color(0xff008E81),
              ],
            )),
        child: ElevatedButton(
          onPressed: () {
            initConnectivity();
          },
          style: ElevatedButton.styleFrom(
              elevation: 0, primary: Colors.transparent),
          child: Text(
            "Refresh",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
