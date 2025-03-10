import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FbColorFilteredSvg extends StatelessWidget {
  final String assetPath;
  final double width;
  final double height;
  final Color color;

  const FbColorFilteredSvg({
    super.key,
    required this.assetPath,
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
