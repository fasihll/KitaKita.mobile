import 'package:flutter/material.dart';

class Service extends StatefulWidget {
  const Service({Key? key}) : super(key: key);

  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Page'),
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            'Service Page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}