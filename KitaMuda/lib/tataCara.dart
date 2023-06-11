import 'package:flutter/material.dart';
import 'package:kitamuda/pages/home_page.dart';

class TataCara extends StatefulWidget {
  const TataCara({super.key});

  @override
  State<TataCara> createState() => _TataCaraState();
}

class _TataCaraState extends State<TataCara> {
  final List<String> title = [
    'Buka Apilkasi KMI dan Klik Tombol Mulai Jelajahi',
    'Setelah Masuk ke Menu Dashboard Buka Menu Service di bagian bawah atau navigasi, atau bisa langsung klik More Service di bagian semua jasa kami',
    'Kemudian Pilih Layanan yang ingin dipesan',
    'Setelah masuk menu detail klik Pesan Jasa',
    'Isi Semua data Inquiry sesuai kebutuhan pemesanan, Setelah semua data terisi klik pesan sekarang (Pastikan semua data terisi dengan baik dan benar karena akan berpengaruh pada proses peninjauan pesanan oleh admin.',
  ];
  final List<String> images = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
    'assets/images/image4.png',
    'assets/images/image5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 26,
              color: Colors.black,
            )),
        centerTitle: true,
        title: Text(
          "Tata Cara",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));
            },
            child: Icon(
              Icons.home_outlined,
              size: 29,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 33),
          child: Column(
            children: [
              ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 38),
                itemCount: title.length,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${index + 1}. ' + title[index],
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Image.asset(
                        images[index],
                      ),
                      SizedBox(
                        height: 26,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffD6D6D6),
                      padding: EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: Text(
                    "Kembali",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 23,
              )
            ],
          ),
        ),
      ),
    );
  }
}
