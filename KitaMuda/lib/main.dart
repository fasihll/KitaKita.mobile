import 'package:flutter/material.dart';
import 'package:kitamuda/StartingPage/starting_page.dart';

void main() async {
  //sharedPrefences(staring_page/home_page)
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartingPage(),
    );
  }
}
