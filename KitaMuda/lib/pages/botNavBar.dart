import 'package:flutter/material.dart';
import 'package:kitamuda/pages/about.dart';
import 'package:kitamuda/pages/home_page.dart';
import 'package:kitamuda/pages/promo.dart';
import 'package:kitamuda/pages/services.dart';

class MenuBawah extends StatefulWidget {
  @override
  _MenuBawahState createState() => _MenuBawahState();
}

class _MenuBawahState extends State<MenuBawah> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    Promo(),
    ServicesPage(),
    About(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        unselectedItemColor: Colors.white,
        unselectedLabelStyle: TextStyle(color: Colors.white),
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFFFFCE00),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Promo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Service',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
