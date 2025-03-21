class FoodDetail {
  int? id;
  int? vendor;
  String? vendorName;
  int? category;
  String? categoryName;
  int? subcategory;
  String? subcategoryName;
  String? name;
  String? description;
  String? price;
  String? wholesalePrice;
  String? offerPrice;
  List<Variants>? variants;
  String? discount;
  bool? isAvailable;
  List<ImageUrls>? imageUrls;
  bool? isPopularProduct;
  bool? isOfferProduct;

  FoodDetail(
      {this.id,
        this.vendor,
        this.vendorName,
        this.category,
        this.categoryName,
        this.subcategory,
        this.subcategoryName,
        this.name,
        this.description,
        this.price,
        this.wholesalePrice,
        this.offerPrice,
        this.variants,
        this.discount,
        this.isAvailable,
        this.imageUrls,
        this.isPopularProduct,
        this.isOfferProduct});

  FoodDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendor = json['vendor'];
    vendorName = json['vendor_name'];
    category = json['category'];
    categoryName = json['category_name'];
    subcategory = json['subcategory'];
    subcategoryName = json['subcategory_name'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    wholesalePrice = json['wholesale_price'];
    offerPrice = json['offer_price'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    discount = json['discount'];
    isAvailable = json['is_available'];
    if (json['image_urls'] != null) {
      imageUrls = <ImageUrls>[];
      json['image_urls'].forEach((v) {
        imageUrls!.add(new ImageUrls.fromJson(v));
      });
    }
    isPopularProduct = json['is_popular_product'];
    isOfferProduct = json['is_offer_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor'] = this.vendor;
    data['vendor_name'] = this.vendorName;
    data['category'] = this.category;
    data['category_name'] = this.categoryName;
    data['subcategory'] = this.subcategory;
    data['subcategory_name'] = this.subcategoryName;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['wholesale_price'] = this.wholesalePrice;
    data['offer_price'] = this.offerPrice;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    data['discount'] = this.discount;
    data['is_available'] = this.isAvailable;
    if (this.imageUrls != null) {
      data['image_urls'] = this.imageUrls!.map((v) => v.toJson()).toList();
    }
    data['is_popular_product'] = this.isPopularProduct;
    data['is_offer_product'] = this.isOfferProduct;
    return data;
  }
}

class Variants {
  Quater? quater;
  Quater? half;
  Quater? full;

  Variants({this.quater, this.half, this.full});

  Variants.fromJson(Map<String, dynamic> json) {
    quater =
    json['Quater'] != null ? new Quater.fromJson(json['Quater']) : null;
    half = json['Half'] != null ? new Quater.fromJson(json['Half']) : null;
    full = json['Full'] != null ? new Quater.fromJson(json['Full']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quater != null) {
      data['Quater'] = this.quater!.toJson();
    }
    if (this.half != null) {
      data['Half'] = this.half!.toJson();
    }
    if (this.full != null) {
      data['Full'] = this.full!.toJson();
    }
    return data;
  }
}

class Quater {
  int? price;
  int? quantity;
  String? stockStatus;

  Quater({this.price, this.quantity, this.stockStatus});

  Quater.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    quantity = json['quantity'];
    stockStatus = json['stock_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['stock_status'] = this.stockStatus;
    return data;
  }
}

class ImageUrls {
  int? id;
  String? image;

  ImageUrls({this.id, this.image});

  ImageUrls.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}
