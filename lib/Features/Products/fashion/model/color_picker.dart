class ColorPickerModel {
  String? colorName;
  String? colorCode;

  ColorPickerModel({this.colorName, this.colorCode});

  ColorPickerModel.fromJson(Map<String, dynamic> json) {
    colorName = json['color_name'];
    colorCode = json['color_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color_name'] = this.colorName;
    data['color_code'] = this.colorCode;
    return data;
  }
}
