class DishClass {
  String? vendorType;
  int? productCount;

  DishClass({this.vendorType, this.productCount});

  DishClass.fromJson(Map<String, dynamic> json) {
    vendorType = json['vendor_type'];
    productCount = json['product_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_type'] = this.vendorType;
    data['product_count'] = this.productCount;
    return data;
  }
}
