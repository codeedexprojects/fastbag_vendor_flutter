class FashionDetail {
  int? id;
  int? vendor;
  String? category;
  String? subcategory;
  String? name;
  String? description;
  String? gender;
  String? price;
  String? discount;
  String? offerPrice;
  int? totalStock;
  List<Colors>? colors;
  String? material;
  List<Images>? images;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  FashionDetail(
      {this.id,
        this.vendor,
        this.category,
        this.subcategory,
        this.name,
        this.description,
        this.gender,
        this.price,
        this.discount,
        this.offerPrice,
        this.totalStock,
        this.colors,
        this.material,
        this.images,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  FashionDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendor = json['vendor'];
    category = json['category'];
    subcategory = json['subcategory'];
    name = json['name'];
    description = json['description'];
    gender = json['gender'];
    price = json['price'];
    discount = json['discount'];
    offerPrice = json['offer_price'];
    totalStock = json['total_stock'];
    if (json['colors'] != null) {
      colors = <Colors>[];
      json['colors'].forEach((v) {
        colors!.add(new Colors.fromJson(v));
      });
    }
    material = json['material'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor'] = this.vendor;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    data['name'] = this.name;
    data['description'] = this.description;
    data['gender'] = this.gender;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['offer_price'] = this.offerPrice;
    data['total_stock'] = this.totalStock;
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    data['material'] = this.material;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Colors {
  List<Sizes>? sizes;
  String? colorName;
  String? colorImage;

  Colors({this.sizes, this.colorName, this.colorImage});

  Colors.fromJson(Map<String, dynamic> json) {
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(new Sizes.fromJson(v));
      });
    }
    colorName = json['color_name'];
    colorImage = json['color_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sizes != null) {
      data['sizes'] = this.sizes!.map((v) => v.toJson()).toList();
    }
    data['color_name'] = this.colorName;
    data['color_image'] = this.colorImage;
    return data;
  }
}

class Sizes {
  String? size;
  dynamic? price;
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

class Images {
  int? id;
  String? imageUrl;
  int? clothing;
  String? image;

  Images({this.id, this.imageUrl, this.clothing, this.image});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    clothing = json['clothing'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['clothing'] = this.clothing;
    data['image'] = this.image;
    return data;
  }
}
