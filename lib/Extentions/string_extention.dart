
//!============================Image Extention
import 'dart:ui';

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

 Color toColor() {
  var hexString = this;
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
 }
}
