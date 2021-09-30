import 'package:flutter/material.dart';

class Helper {
  static Widget buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Loading data from API..."),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  static Widget buildError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Error occured : $error")],
      ),
    );
  }
}
