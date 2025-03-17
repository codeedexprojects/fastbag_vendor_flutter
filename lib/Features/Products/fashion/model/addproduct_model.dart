class AddFashionProductModel {
  int? vendor;
  int? categoryId;
  int? subcategoryId;
  String? name;
  String? description;
  String? gender;
  String? wholesalePrice;
  String? price;
  String? offerPrice;
  String? discount;
  List<ColorsS>? colors;
  String? material;
  bool? isActive;

  AddFashionProductModel(
      {this.vendor,
        this.categoryId,
        this.subcategoryId,
        this.name,
        this.description,
        this.gender,
        this.wholesalePrice,
        this.price,
        this.offerPrice,
        this.discount,
        this.colors,
        this.material,
        this.isActive});

  AddFashionProductModel.fromJson(Map<String, dynamic> json) {
    vendor = json['vendor'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    name = json['name'];
    description = json['description'];
    gender = json['gender'];
    wholesalePrice = json['wholesale_price'];
    price = json['price'];
    offerPrice = json['offer_price'];
    discount = json['discount'];
    if (json['colors'] != null) {
      colors = <ColorsS>[];
      json['colors'].forEach((v) {
        colors!.add(new ColorsS.fromJson(v));
      });
    }
    material = json['material'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor'] = this.vendor;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['gender'] = this.gender;
    data['wholesale_price'] = this.wholesalePrice;
    data['price'] = this.price;
    data['offer_price'] = this.offerPrice;
    data['discount'] = this.discount;
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    data['material'] = this.material;
    data['is_active'] = this.isActive;
    return data;
  }
}

class ColorsS {
  String? colorName;
  String? colorImage;
  List<Sizes>? sizes;

  ColorsS({this.colorName, this.colorImage, this.sizes});

  ColorsS.fromJson(Map<String, dynamic> json) {
    colorName = json['color_name'];
    colorImage = json['color_image'];
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(new Sizes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color_name'] = this.colorName;
    data['color_image'] = this.colorImage;
    if (this.sizes != null) {
      data['sizes'] = this.sizes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sizes {
  String? size;
  String? price;
  int? stock;

  Sizes({this.size, this.price, this.stock});

  Sizes.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    price = json['price'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['price'] = this.price;
    data['stock'] = this.stock;
    return data;
  }
}
