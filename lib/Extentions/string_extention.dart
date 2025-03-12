
//!============================Image Extention
extension ImagePathExtension on String{
 String get imagePath => "assets/Images/$this";
}
//===============================Rupee extention
extension RupeePathExtention on String{
 String get rupee => "₹ $this";
}
//!============================Image Extention
extension IconPathExtension on String{
 String get iconPath => "assets/icons/$this";
}
