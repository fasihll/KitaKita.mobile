import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kitamuda/pages/home_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class CorporateCalendar_Inquiry extends StatefulWidget {
  const CorporateCalendar_Inquiry({super.key});

  @override
  State<CorporateCalendar_Inquiry> createState() =>
      _CorporateCalendar_InquiryState();
}

class _CorporateCalendar_InquiryState extends State<CorporateCalendar_Inquiry> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String subjek = '';
  String email = '';
  String pesan = '';

  String _proposalPath = '';
  String _proposalFileName = '';
  String _FRPpath = '';
  String _FRPFileName = '';

  void _proposanFilePick() async {
    FilePickerResult? proposal = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (proposal != null && proposal.files.single.path != null) {
      PlatformFile file = proposal.files.first;
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);

      File _file = File(proposal.files.single.path!);

      setState(() {
        _proposalPath = _file.path;
        _proposalFileName = file.name;
      });
    } else {
      //user cencled the picker
    }
  }

  void _FRPFilePick() async {
    FilePickerResult? FRP = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (FRP != null && FRP.files.single.path != null) {
      PlatformFile file = FRP.files.first;
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);

      File _file = File(FRP.files.single.path!);

      setState(() {
        _FRPpath = _file.path;
        _FRPFileName = file.name;
      });
    } else {
      //user cencled the picker
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
          "Pemesanan",
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
              SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Pemesan :",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(14),
                        hintText: "Masukkan nama pemesan",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(0, 0, 0, 0.45)),
                        filled: true,
                        fillColor: Color(0xffEAEAEA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Wajib diisi dengan benar';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => name = value),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Subjek :",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(14),
                        hintText: "Subject",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(0, 0, 0, 0.45)),
                        filled: true,
                        fillColor: Color(0xffEAEAEA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Wajib diisi dengan benar';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => subjek = value),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Email :",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(14),
                        hintText: "Masukkan email anda",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(0, 0, 0, 0.45)),
                        filled: true,
                        fillColor: Color(0xffEAEAEA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Wajib diisi dengan benar';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => email = value),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Pesan :",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(14),
                        hintText: "Isi pesan",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(0, 0, 0, 0.45)),
                        filled: true,
                        fillColor: Color(0xffEAEAEA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Wajib diisi dengan benar';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => pesan = value),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Lampirkan dokumen proposal :",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(6),
                      dashPattern: [10, 10],
                      color: Color(0xffFFCE00),
                      strokeWidth: 2,
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _proposanFilePick,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(126, 255, 204, 0),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6))),
                          child: Center(
                            child: Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_open_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    _proposalPath.isEmpty
                                        ? 'Upload'
                                        : _proposalFileName,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Lampirkan dokumen RFP :",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(6),
                      dashPattern: [10, 10],
                      color: Color(0xffFFCE00),
                      strokeWidth: 2,
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _FRPFilePick,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(126, 255, 204, 0),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6))),
                          child: Center(
                            child: Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_open_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    _FRPpath.isEmpty ? 'Upload' : _FRPFileName,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final message =
                                  'Name: $name, Subjek: $subjek, Email: $email, Pesan: $pesan,ProposanName: $_proposalFileName, ProposalFilePath: $_proposalPath,FPRName: $_FRPFileName FRPFilePath: $_FRPpath';
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffFFCE00),
                              padding: EdgeInsets.all(14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          child: Text(
                            "Kirim Pesan",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 33,
              )
            ],
          ),
        ),
      ),
    );
  }
}
