class GroceryProductModel {
  int? count;
  Null? next;
  Null? previous;
  List<Results>? results;

  GroceryProductModel({this.count, this.next, this.previous, this.results});

  GroceryProductModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  int? category;
  String? categoryName;
  int? subCategory;
  int? vendor;
  String? subCategoryName;
  String? name;
  String? price;
  String? wholesalePrice;
  double? offerPrice;
  String? discount;
  String? description;
  String? weightMeasurement;
  int? priceForSelectedWeight;
  bool? isOfferProduct;
  bool? isPopularProduct;
  List<Weights>? weights;
  bool? available;
  String? createdAt;
  List<Images>? images;

  Results(
      {this.id,
        this.category,
        this.categoryName,
        this.subCategory,
        this.vendor,
        this.subCategoryName,
        this.name,
        this.price,
        this.wholesalePrice,
        this.offerPrice,
        this.discount,
        this.description,
        this.weightMeasurement,
        this.priceForSelectedWeight,
        this.isOfferProduct,
        this.isPopularProduct,
        this.weights,
        this.available,
        this.createdAt,
        this.images});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    categoryName = json['category_name'];
    subCategory = json['sub_category'];
    vendor = json['vendor'];
    subCategoryName = json['sub_category_name'];
    name = json['name'];
    price = json['price'];
    wholesalePrice = json['wholesale_price'];
    offerPrice = json['offer_price'];
    discount = json['discount'];
    description = json['description'];
    weightMeasurement = json['weight_measurement'];
    priceForSelectedWeight = json['price_for_selected_weight'];
    isOfferProduct = json['is_offer_product'];
    isPopularProduct = json['is_popular_product'];
    if (json['weights'] != null) {
      weights = <Weights>[];
      json['weights'].forEach((v) {
        weights!.add(new Weights.fromJson(v));
      });
    }
    available = json['Available'];
    createdAt = json['created_at'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['category_name'] = this.categoryName;
    data['sub_category'] = this.subCategory;
    data['vendor'] = this.vendor;
    data['sub_category_name'] = this.subCategoryName;
    data['name'] = this.name;
    data['price'] = this.price;
    data['wholesale_price'] = this.wholesalePrice;
    data['offer_price'] = this.offerPrice;
    data['discount'] = this.discount;
    data['description'] = this.description;
    data['weight_measurement'] = this.weightMeasurement;
    data['price_for_selected_weight'] = this.priceForSelectedWeight;
    data['is_offer_product'] = this.isOfferProduct;
    data['is_popular_product'] = this.isPopularProduct;
    if (this.weights != null) {
      data['weights'] = this.weights!.map((v) => v.toJson()).toList();
    }
    data['Available'] = this.available;
    data['created_at'] = this.createdAt;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Weights {
  int? price;
  String? weight;
  int? quantity;
  bool? isInStock;

  Weights({this.price, this.weight, this.quantity, this.isInStock});

  Weights.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    weight = json['weight'];
    quantity = json['quantity'];
    isInStock = json['is_in_stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['weight'] = this.weight;
    data['quantity'] = this.quantity;
    data['is_in_stock'] = this.isInStock;
    return data;
  }
}

class Images {
  int? id;
  String? image;

  Images({this.id, this.image});

  Images.fromJson(Map<String, dynamic> json) {
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
