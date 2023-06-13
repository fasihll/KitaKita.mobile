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
        centerTitle: true,
        title: Text(
          "About",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/logo_kmi.png',
                width: 150,
              ),
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Kita ',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Muda ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFCE00),
                      ),
                    ),
                    TextSpan(
                      text: 'Indonesia',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text(
                'Jadikan Perusahaanmu Lebih Professional',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        color: Color(0xFF1E1E1E),
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: '24/7\n',
                              style: TextStyle(
                                color: Color(0xFFFFCE00),
                                fontSize: 18,
                              ),
                              children: [
                                TextSpan(
                                  text: "kerja",
                                  style: TextStyle(
                                    color: Color(0xFFFFCE00),
                                    fontSize: 15,
                                  ),
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          color: Color(0xFF1E1E1E), shape: BoxShape.circle),
                      padding: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: '10\n',
                              style: TextStyle(
                                color: Color(0xFFFFCE00),
                                fontSize: 21,
                              ),
                              children: [
                                TextSpan(
                                  text: "Layanan",
                                  style: TextStyle(
                                    color: Color(0xFFFFCE00),
                                    fontSize: 10,
                                  ),
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        color: Color(0xFF1E1E1E),
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: '8\n',
                              style: TextStyle(
                                color: Color(0xFFFFCE00),
                                fontSize: 25,
                              ),
                              children: [
                                TextSpan(
                                  text: "Partnetship",
                                  style: TextStyle(
                                    color: Color(0xFFFFCE00),
                                    fontSize: 7,
                                  ),
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text(
                'Kita Muda Indonesia adalah sebuah perusahaan yang bergerak dibidang Creative and Corporation Services. Perusahaan yang akan membantu anda untuk mewujudkan perusahaan yang lebih professional dan lebih bernilai. Selain itu, kami dapat membantu perusahaan atau usaha anda memiliki identitas tersendiri agar mudah dikenali oleh banyak orang. Sehingga dapat meningkatkan angka penjualan dan promosi di perusahaan anda.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Official Client Partnetship:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Flexible(child: Image.asset("assets/images/partner1.png")),
                  Flexible(child: Image.asset("assets/images/partner2.png")),
                  Flexible(child: Image.asset("assets/images/partner3.png")),
                  Flexible(child: Image.asset("assets/images/partner4.png")),
                  Flexible(child: Image.asset("assets/images/partner5.png")),
                  Flexible(child: Image.asset("assets/images/partner6.png")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
