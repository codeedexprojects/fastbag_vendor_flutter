class FashionItemModel {
  final int? id;
  final int vendor;
  final String? vendor_name;
  final int category;
  final String? category_name;
  final int subcategory;
  final String? subcategory_name;
  final String name;
  final String description;
  final String price;
  final String offer_price;
  final String discount;
  final bool is_available;
  final List<String> image_urls;
  final bool is_popular_product;
  final bool is_offer_product;
  final String wholesale_price;
  final List<dynamic> variants;

  FashionItemModel(
      {this.id,
        required this.vendor,
        this.vendor_name,
        required this.category,
        this.category_name,
        required this.subcategory,
        this.subcategory_name,
        required this.name,
        required this.description,
        required this.price,
        required this.offer_price,
        required this.discount,
        required this.is_available,
        required this.image_urls,
        required this.is_popular_product,
        required this.is_offer_product,
        required this.wholesale_price,
        required this.variants});

  factory FashionItemModel.fromMap(Map<String, dynamic> productMap) {
    return FashionItemModel(
        id: productMap['id'],
        vendor: productMap['vendor'],
        vendor_name: productMap['vendor_name'],
        category: productMap['category'],
        category_name: productMap['category_name'],
        subcategory: productMap['subcategory'],
        subcategory_name: productMap['subcategory_name'],
        name: productMap['name'],
        description: productMap['description'],
        price: productMap['price'],
        offer_price: productMap['offer_price'],
        wholesale_price: productMap['wholesale_price'],
        variants: productMap['variants'],
        discount: productMap['discount'],
        is_available: productMap['is_available'],
        image_urls: productMap["image_urls"]
            .map<String>((imageData) => imageData['image'].toString())
            .toList(),
        is_popular_product: productMap['is_popular_product'],
        is_offer_product: productMap['is_offer_product']);
  }

}
