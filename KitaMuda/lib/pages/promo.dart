import 'package:flutter/material.dart';

class Promo extends StatefulWidget {
  const Promo({Key? key}) : super(key: key);

  @override
  State<Promo> createState() => _PromoState();
}

class _PromoState extends State<Promo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promo Page'),
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            'Promo Page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}