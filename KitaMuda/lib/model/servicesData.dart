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
  String? name;
  String? description;
  String? icon;
  IconBackground? iconBackground;
  Details? details;

  Services(
      {this.name,
      this.description,
      this.icon,
      this.iconBackground,
      this.details});

  Services.fromJson(Map<String, dynamic> json) {
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
