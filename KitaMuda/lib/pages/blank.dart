import 'package:flutter/material.dart';

class Blank extends StatefulWidget {
  const Blank({Key? key}) : super(key: key);

  @override
  State<Blank> createState() => _BlankState();
}

class _BlankState extends State<Blank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blank Page'),
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            'Blank Page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}