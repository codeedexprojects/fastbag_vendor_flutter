import 'dart:convert';

class GroceryProductsModel {
  final int id;
  final int category;
  final String categoryName;
  final int subCategory;
  final String subCategoryName;
  final int vendor;
  final String name;
  final double price;
  final double wholesalePrice;
  final double offerPrice;
  final double discount;
  final String description;
  final String weightMeasurement;
  final double priceForSelectedWeight;
  final bool isOfferProduct;
  final bool isPopularProduct;
  final bool available;
  final String createdAt;
  final List<Weight> weights;
  final List<ProductImage> images;

  GroceryProductsModel({
    required this.id,
    required this.category,
    required this.categoryName,
    required this.subCategory,
    required this.subCategoryName,
    required this.vendor,
    required this.name,
    required this.price,
    required this.wholesalePrice,
    required this.offerPrice,
    required this.discount,
    required this.description,
    required this.weightMeasurement,
    required this.priceForSelectedWeight,
    required this.isOfferProduct,
    required this.isPopularProduct,
    required this.available,
    required this.createdAt,
    required this.weights,
    required this.images,
  });

  factory GroceryProductsModel.fromJson(Map<String, dynamic> json) {
    return GroceryProductsModel(
      id: json['id'],
      category: json['category'],
      categoryName: json['category_name'],
      subCategory: json['sub_category'],
      subCategoryName: json['sub_category_name'],
      vendor: json['vendor'],
      name: json['name'],
      price: double.parse(json['price']),
      wholesalePrice: double.parse(json['wholesale_price']),
      offerPrice: json['offer_price'].toDouble(),
      discount: double.parse(json['discount']),
      description: json['description'],
      weightMeasurement: json['weight_measurement'],
      priceForSelectedWeight: json['price_for_selected_weight'].toDouble(),
      isOfferProduct: json['is_offer_product'],
      isPopularProduct: json['is_popular_product'],
      available: json['Available'],
      createdAt: json['created_at'],
      weights: (json['weights'] as List).map((e) => Weight.fromJson(e)).toList(),
      images: (json['images'] as List).map((e) => ProductImage.fromJson(e)).toList(),
    );
  }
}

class Weight {
  final double price;
  final String weight;
  final int quantity;
  final bool isInStock;

  Weight({
    required this.price,
    required this.weight,
    required this.quantity,
    required this.isInStock,
  });

  factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      price: double.parse(json['price'].toString()),
      weight: json['weight'],
      quantity: json['quantity'],
      isInStock: json['is_in_stock'],
    );
  }
}

class ProductImage {
  final int id;
  final String image;

  ProductImage({
    required this.id,
    required this.image,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      image: json['image'],
    );
  }
}
