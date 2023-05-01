import 'package:flutter/material.dart';
import 'package:kmi_apps/StartingPage/starting_page.dart';

void main() async {
  await Future.delayed(Duration(seconds: 3));
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
