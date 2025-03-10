import 'package:fastbag_vendor_flutter/Extentions/string_extention.dart';
import 'package:flutter/material.dart';

class FbLogoContainer extends StatelessWidget {
  final double customHeight;
  final double customWidth;
  const FbLogoContainer({super.key,required this.customHeight,required this.customWidth});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
              height: screenHeight * customHeight,
              child: Center(
                  child: Image.asset(
                "logo.png".imagePath,
                //height: screenHeight * .25,
                width: screenWidth * customWidth,
                fit: BoxFit.fill,
              )),
            );
  }
}