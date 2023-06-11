import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kitamuda/globacls.dart' as globals;

class servicesData {
  String? category;
  List<Services>? services;

  servicesData({this.category, this.services});

  servicesData.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  String? serviceId;
  String? image;
  String? name;
  String? description;
  String? icon;
  IconBackground? iconBackground;
  Details? details;

  Services(
      {this.serviceId,
      this.image,
      this.name,
      this.description,
      this.icon,
      this.iconBackground,
      this.details});

  Services.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    iconBackground = json['icon_background'] != null
        ? new IconBackground.fromJson(json['icon_background'])
        : null;
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceId'] = this.serviceId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['icon'] = this.icon;
    if (this.iconBackground != null) {
      data['icon_background'] = this.iconBackground!.toJson();
    }
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class IconBackground {
  int? r;
  int? g;
  int? b;
  double? o;

  IconBackground({this.r, this.g, this.b, this.o});

  IconBackground.fromJson(Map<String, dynamic> json) {
    r = json['r'];
    g = json['g'];
    b = json['b'];
    o = json['o'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r'] = this.r;
    data['g'] = this.g;
    data['b'] = this.b;
    data['o'] = this.o;
    return data;
  }
}

class Details {
  String? namaProduk;
  String? category;
  String? detailProduk;

  Details({this.namaProduk, this.category, this.detailProduk});

  Details.fromJson(Map<String, dynamic> json) {
    namaProduk = json['nama_produk'];
    category = json['category'];
    detailProduk = json['detail_produk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_produk'] = this.namaProduk;
    data['category'] = this.category;
    data['detail_produk'] = this.detailProduk;
    return data;
  }
}

class apiConfig {
  Future<void> submitTransaction(
      {
        String? name,
        String? subject,
        File? frp,
        String? frpName,
        File? proposal,
        String? proposalName,
        String? email,
        String? serviceName,
        String? serviceCategory
      }) async {

      try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(globals.api_service),
      );

      final Map<String, String> headers = {
        'Authorization' : 'kitamudaindonesia',
        'Content-type'  : 'multipart/form-data'
      };

      request.files.add(
        await http.MultipartFile.fromPath(
          'proposal',
          proposal!.path,
          filename: proposalName,
        ),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'frp',
          frp!.path,
          filename: frpName,
        ),
      );

      request.headers.addAll(headers);
      request.fields.addAll({
        'name'        : name!,
        'subject'     : subject!,
        'email'       : email!,
        'serviceName' : serviceName!,
        'serviceCat'  : serviceCategory!
      });

      print("Requesting to server: $request");
      var res = await request.send();
      int resCode = res.statusCode;
      print('This is response from server: $res');
      print('and This is Response code: $resCode');
    } catch (e) {
      print("We have an error in : $e");
    }


    // var dio = Dio();
    // var formData = FormData();

    // formData.files.add(
    //   MapEntry(
    //     'file',
    //     await MultipartFile.fromFile(
    //       proposal!.path,
    //       filename: proposalName,
    //     ),
    //   ),
    // );

    // formData.files.add(
    //   MapEntry(
    //     'file',
    //     await MultipartFile.fromFile(
    //       frp!.path,
    //       filename: frpName,
    //     ),
    //   ),
    // );

    // // Menambahkan data tambahan
    // formData.fields.addAll([
    //   MapEntry('name', nama!),
    //   MapEntry('email', email!),
    //   MapEntry('serviceCategory', 'Annual Report'),
    //   MapEntry('serviceName', 'Report Management'),
    //   MapEntry('status', 'Menunggu Konfirmasi'),
    // ]);

    // try {
    //   var response = await dio.post(
    //     'https://research-of-duren.000webhostapp.com/api.php',
    //     data: formData,
    //   );

    //   print('Response   : ${response.data}');
    //   print('Status Code: ${response.statusCode}');
    // } catch (error) {
    //   print('Error: $error');
    // }
  }
}
