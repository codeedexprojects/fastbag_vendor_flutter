import 'package:flutter/material.dart';

class FbButton extends StatelessWidget {
  final dynamic onClick;
  final String label;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  const FbButton(
      {super.key,
      required this.onClick,
      required this.label,
      this.color,
      this.textColor,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      minWidth: screenWidth * 0.9,
      onPressed: onClick,
      color: color ?? Colors.green,
      textColor: textColor ?? Colors.white,
      shape: borderColor != null
          ?  RoundedRectangleBorder(
              //borderRadius: BorderRadius.circular(10), // Rounded corners
              side:  BorderSide(
                color:borderColor!, // Border color
                width: 1, // Border width
              ),
            )
          : null,
      child: Text(label),
    );
  }
}
