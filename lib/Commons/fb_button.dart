import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:flutter/material.dart';

class FbButton extends StatelessWidget {
  final VoidCallback? onClick;
  final String label;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? height;

  const FbButton({
    super.key,
    required this.onClick,
    required this.label,
    this.height = 50.0, // Default height set to 50
    this.color,
    this.textColor = Colors.white,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialButton(
      minWidth: screenWidth * 0.9,
      height: height,
      onPressed: onClick,
      color: color ?? FbColors.buttonColor,
      textColor: textColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: borderColor ?? Colors.transparent,
          width: borderColor != null ? 1 : 0,
        ),
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
