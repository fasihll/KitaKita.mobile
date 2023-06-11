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
        centerTitle: true,
        title: Text(
          "Promo",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            'Tidak Ada Promo yang Tersedia',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}