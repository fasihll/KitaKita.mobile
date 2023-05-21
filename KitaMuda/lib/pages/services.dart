import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kitamuda/model/servicesData.dart';
import 'package:kitamuda/services/details/corporateCalendar.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  Future<List<servicesData>> getJson() async {
    Uri url = Uri.parse("http://10.0.2.2:8000/api/services");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => servicesData.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

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
            "Our Service",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 33),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                FutureBuilder(
                  future: getJson(),
                  builder: (context, snapshot) {
                    var items = snapshot.data;
                    if (snapshot.hasData) {
                      return Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: items != null ? items.length : 0,
                            itemBuilder: (context, index1) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    items![index1].category.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  FutureBuilder(
                                    future: getJson(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Container(
                                          child: ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  items![index1].services !=
                                                          null
                                                      ? items[index1]
                                                          .services!
                                                          .length
                                                      : 0,
                                              itemBuilder: (context, index2) {
                                                return Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    CorporateCalendar()));
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
                                                                    items![index1]
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
                                                                    items![index1]
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
          ),
        ));
  }
}
