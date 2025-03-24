class DishClass {
  int? vendorId;
  String? vendorName;
  List<String>? vendorTypes;
  int? totalProductCount;
  int? availableProductCount;
  OutOfStockCounts? outOfStockCounts;

  DishClass(
      {this.vendorId,
        this.vendorName,
        this.vendorTypes,
        this.totalProductCount,
        this.availableProductCount,
        this.outOfStockCounts});

  DishClass.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    vendorTypes = json['vendor_types'].cast<String>();
    totalProductCount = json['total_product_count'];
    availableProductCount = json['available_product_count'];
    outOfStockCounts = json['out_of_stock_counts'] != null
        ? new OutOfStockCounts.fromJson(json['out_of_stock_counts'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    data['vendor_types'] = this.vendorTypes;
    data['total_product_count'] = this.totalProductCount;
    data['available_product_count'] = this.availableProductCount;
    if (this.outOfStockCounts != null) {
      data['out_of_stock_counts'] = this.outOfStockCounts!.toJson();
    }
    return data;
  }
}

class OutOfStockCounts {
  int? clothing;
  int? grocery;
  int? food;
  int? total;

  OutOfStockCounts({this.clothing, this.grocery, this.food, this.total});

  OutOfStockCounts.fromJson(Map<String, dynamic> json) {
    clothing = json['clothing'];
    grocery = json['grocery'];
    food = json['food'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clothing'] = this.clothing;
    data['grocery'] = this.grocery;
    data['food'] = this.food;
    data['total'] = this.total;
    return data;
  }
}
