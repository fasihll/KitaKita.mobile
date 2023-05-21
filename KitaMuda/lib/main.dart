import 'package:flutter/material.dart';
import 'package:kitamuda/StartingPage/starting_page.dart';
import 'package:kitamuda/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  //sharedPrefences
  Future<int?> getSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("status");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: getSP(),
        builder: (context, AsyncSnapshot<int?> snapshot) {
          if (snapshot.data == 1) {
            return HomePage();
          } else {
            return StartingPage();
          }
        },
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, fontFamily: 'Poppins'),
    );
  }
}
