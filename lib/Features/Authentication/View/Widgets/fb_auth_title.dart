import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:flutter/material.dart';

class FbAuthTitle extends StatelessWidget {
  final String title;
  final double fontWidth;
  const FbAuthTitle({super.key, required this.title, required this.fontWidth});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Text(title,
        style: mainFont(
            fontsize: screenWidth * fontWidth,
            fontweight: FontWeight.w600,
            color: FbColors.black));
  }
}
