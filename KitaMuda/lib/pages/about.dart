import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Page'),
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            'About Page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}