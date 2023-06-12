import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:kitamuda/model/servicesData.dart';
import 'package:kitamuda/pages/about.dart';
import 'package:kitamuda/pages/blank.dart';
import 'package:kitamuda/pages/promo.dart';
import 'package:kitamuda/pages/services.dart';
import 'package:kitamuda/services/details/corporateCalendar.dart';
import 'package:kitamuda/util/jasa.dart';
import 'package:http/http.dart' as http;
import 'package:kitamuda/globacls.dart' as globals;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  Future<List<servicesData>?> getJson() async {
    try {
      Uri url = Uri.parse(globals.api_service);

      final response = await http.get(url, headers: globals.headers);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((data) => servicesData.fromJson(data)).toList();
      } else {

        throw Exception('Unexpected error occurred!');

      }
    } catch (e) {
      print("error message : $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Title
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 185,
                  decoration: BoxDecoration(
                    color: Color(0xffFFCE00),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 48,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selamat Datang Di\nKita Muda Indonesia',
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Jadikan Usahamu Lebih Professional',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Mau cari jasa apa nih?',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff908D8D),
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jadikan perusahaanmu lebih baik',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Pakai Kita Muda Indonesia untuk jadikan perusahaan anda lebih professional, Yuk Gunakan ....',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              child: PageView(
                scrollDirection: Axis.horizontal,
                children: [
                  FutureBuilder<List<servicesData>?>(
                    future: getJson(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        
                        // Ketika sedang dalam proses mengambil data
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // Ketika terjadi error dalam mengambil data
                        return Text('Error: ${snapshot.error}');
                      } else {
                        if (snapshot.hasData) {
                          // Ketika data telah berhasil diambil
                          
                          List<servicesData>? data = snapshot.data;
                          Random r = Random();
                          int rNumber = r.nextInt(3);
                          if (data != null && data.isNotEmpty) {
                            return Container(
                              height: 200,
                              child: PageView(
                                scrollDirection: Axis.horizontal,

                                children: data[rNumber]
                                        .services
                                        ?.map((service) {
                                      String description2 =
                                          service.description ?? "";
                                      String images = "image-default.png"; // service.image ?? ""

                                      if (description2.length > 20) {
                                        description2 =
                                            description2.substring(0, 20) +
                                                "\n" +
                                                description2.substring(20);
                                      }

                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  CorporateCalendar(
                                                title: service.name.toString(),
                                                description: service.description
                                                    .toString(),
                                                namaProduk:
                                                    service.name.toString(),
                                                detailProduk: service
                                                    .details?.detailProduk
                                                    .toString(),
                                                category: data[rNumber]
                                                    .category
                                                    .toString(),
                                                icon: service.icon,
                                                r: service.iconBackground!.r,
                                                g: service.iconBackground!.g,
                                                b: service.iconBackground!.b,
                                                o: service.iconBackground!.o!
                                                    .toDouble(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Jasa(
                                          namaProduk: service.name ?? "",
                                          description: description2,
                                          gambar: images,
                                        ),

                                      );
                                    }).toList() ??
                                    [],
                              ),
                            );
                          } else {
                            // Ketika data kosong
                            return Text('No data available');
                          }
                        } else {
                          // Ketika tidak ada data
                          return Text('No data available');
                        }
                      }
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Semua Jasa Kami',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Semua Jasa yang kami berikan untuk Anda',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Column(
              children: [
                FutureBuilder(
                  future: getJson(),
                  builder: (context, snapshot) {
                    var items = snapshot.data;
                    if (snapshot.hasData) {
                      return Container(
                        margin: EdgeInsets.only(top: 0, left: 33, right: 33),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: items != null ? 1 : 0,
                            itemBuilder: (context, index1) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder(
                                    future: getJson(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Container(
                                          child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  items![index1].services !=
                                                          null
                                                      ? 3
                                                      : 0,
                                              itemBuilder: (context, index2) {
                                                return Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                CorporateCalendar(
                                                              title: items[
                                                                      index1]
                                                                  .services![
                                                                      index2]
                                                                  .name
                                                                  .toString(),
                                                              description: items[
                                                                      index1]
                                                                  .services![
                                                                      index2]
                                                                  .description
                                                                  .toString(),
                                                              namaProduk: items[
                                                                      index1]
                                                                  .services![
                                                                      index2]
                                                                  .name
                                                                  .toString(),
                                                              detailProduk: items[
                                                                      index1]
                                                                  .services![
                                                                      index2]
                                                                  .details!
                                                                  .detailProduk
                                                                  .toString(),
                                                              category: items[
                                                                      index1]
                                                                  .category
                                                                  .toString(),
                                                              icon: items[
                                                                      index1]
                                                                  .services![
                                                                      index2]
                                                                  .icon,
                                                              r: items[index1]
                                                                  .services![
                                                                      index2]
                                                                  .iconBackground!
                                                                  .r,
                                                              g: items[index1]
                                                                  .services![
                                                                      index2]
                                                                  .iconBackground!
                                                                  .g,
                                                              b: items[index1]
                                                                  .services![
                                                                      index2]
                                                                  .iconBackground!
                                                                  .b,
                                                              o: items[index1]
                                                                  .services![
                                                                      index2]
                                                                  .iconBackground!
                                                                  .o!
                                                                  .toDouble(),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 24),
                                                        child: Row(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              9),
                                                                  decoration: BoxDecoration(
                                                                      color: Color.fromRGBO(
                                                                          int.parse(items[index1]
                                                                              .services![
                                                                                  index2]
                                                                              .iconBackground!
                                                                              .r
                                                                              .toString()),
                                                                          int.parse(items[index1]
                                                                              .services![
                                                                                  index2]
                                                                              .iconBackground!
                                                                              .g
                                                                              .toString()),
                                                                          int.parse(items[index1]
                                                                              .services![
                                                                                  index2]
                                                                              .iconBackground!
                                                                              .b
                                                                              .toString()),
                                                                          double.parse(items[index1]
                                                                              .services![
                                                                                  index2]
                                                                              .iconBackground!
                                                                              .o
                                                                              .toString())),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15)),
                                                                  child: Icon(
                                                                    IconData(
                                                                        int.parse(items[index1]
                                                                            .services![
                                                                                index2]
                                                                            .icon
                                                                            .toString()),
                                                                        fontFamily:
                                                                            'MaterialIcons'),
                                                                    size: 30,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(

                                                                    items[index1]

                                                                        .services![
                                                                            index2]
                                                                        .name
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  Text(

                                                                    items[index1]

                                                                        .services![
                                                                            index2]
                                                                        .description
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            11,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 1,
                                                                    child:
                                                                        Container(
                                                                      color: Colors
                                                                          .black,
                                                                      constraints:
                                                                          BoxConstraints(
                                                                              maxWidth: double.maxFinite),
                                                                      //height: -> setting to maximum of its parent
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              }),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(snapshot.error.toString());
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Blank()));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(9),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  0, 102, 255, 0.38),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Icon(
                                            Icons.more_horiz_outlined,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ServicesPage()));
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'More Service',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  'Klik untuk melihat semua jasa yang kami berikan',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 11),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Promo()),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFCE00),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.discount_outlined,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Promo',
                          style: GoogleFonts.poppins(),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ServicesPage()),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFCE00),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.settings_outlined,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Service',
                          style: GoogleFonts.poppins(),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => About()),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFCE00),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.thumb_up, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'About',
                          style: GoogleFonts.poppins(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
