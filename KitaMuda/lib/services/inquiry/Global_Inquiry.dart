import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kitamuda/model/servicesData.dart';
import 'package:kitamuda/pages/home_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class CorporateCalendar_Inquiry extends StatefulWidget {
  final String? namaLayanan;
  final String? kategori;
  const CorporateCalendar_Inquiry({super.key, this.namaLayanan, this.kategori});

  @override
  State<CorporateCalendar_Inquiry> createState() =>
      _CorporateCalendar_InquiryState(namaLayanan, kategori);
}

class _CorporateCalendar_InquiryState extends State<CorporateCalendar_Inquiry> {
  final String? namaLayanan;
  final String? kategori;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  // Variable File
  File purposePick = File("");
  String purposeName = "";
  File rfpPick = File("");
  String rfpName = "";

  String _proposalPath = '';
  String _proposalFileName = '';
  String _FRPpath = '';
  String _FRPFileName = '';

  String name = '';
  String subjek = '';
  String email = '';
  String pesan = '';

  _CorporateCalendar_InquiryState(this.namaLayanan, this.kategori);

  Future pickPurpose() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      purposePick = File(result.files.single.path ?? "");

      setState(() {
        _proposalFileName = result.files.single.name;
        _proposalPath = purposePick.toString();
      });
    } else {
      showSnackbarCancelAction(context);
    }
  }

  Future pickRFP() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      rfpPick = File(result.files.single.path ?? "");

      setState(() {
        _FRPFileName = result.files.single.name;
        _FRPpath = rfpPick.toString();
      });
    } else {
      showSnackbarCancelAction(context);
    }
  }

  Future sendEmail() async {
    String username = 'ricoenrique24@gmail.com';
    String password = 'tcvuilfhjuccyfdv';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(email, name)
      ..recipients.add('mochammadenrique.25@gmail.com')
      ..ccRecipients.add(email)
      ..subject = subjek
      ..text = pesan
      ..html = '''
        <html>
        <head>
          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
          <style>
            .two-tone {
              background-color: yellow;
              color: black;
              padding: 10px;
            }
            body {
              background-color: white;
            }
          </style>
        </head>
        <body>
          <div class="two-tone">
            <h1 class="display-4">$subjek</h1>
            <p class="lead">$pesan</p>
          </div>
        </body>
      </html>
      '''
      ..attachments = [
        FileAttachment(purposePick)
          ..location = Location.attachment
          ..fileName = "Proposal_$name _$_proposalFileName",
        FileAttachment(rfpPick)
          ..location = Location.attachment
          ..fileName = "RFP_$name _$_FRPFileName",
      ];

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');

      showAlertDialog(context);
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Future hashTransaction() async {
    print('Client Choose $namaLayanan Service in $kategori Category');

    final apiConfig api = apiConfig();
    api.submitTransaction(
      name            : name,
      subject         : subjek,
      frp             : rfpPick,
      frpName         : _FRPFileName,
      proposal        : purposePick,
      proposalName    : _proposalFileName,
      email           : email,
      serviceName     : namaLayanan,
      serviceCategory : kategori
    );
  }

  clearContent() {
    // Menghapus nilai dari controller
    _nameController.clear();
    _subjectController.clear();
    _emailController.clear();
    _messageController.clear();
    purposePick = File("");
    rfpPick = File("");

    setState(() {
      purposeName = "";
      rfpName = "";
      _FRPpath = "";
      _proposalPath = "";
    });
  }

  showSnackbarEmailSuccessful(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Email Berhasil Terkirim!'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  showSnackbarCancelAction(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Anda Membatalkan upload Dokumen!'),
      ),
    );
  }

  showSnackbarLoading(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green[300],
        content: const Text('Mohon Tunggu, Email Anda Sedang dikirim...'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Aksi saat tombol ditekan
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget doneButton = ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        // Aksi saat tombol ditekan (kirim ke homepage)
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      },
      child: Text('Done'),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Selamat!"),
      content: Text(
          "Pesan Email Telah terkirim. Silahkan tinjau email secara berkala."),
      actions: [doneButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
                      controller: _nameController,
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
                      controller: _subjectController,
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
                      controller: _emailController,
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
                      controller: _messageController,
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
                          onPressed: pickPurpose,
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
                          onPressed: pickRFP,
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
                            showSnackbarLoading(context);
                            sendEmail();
                            hashTransaction();
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
