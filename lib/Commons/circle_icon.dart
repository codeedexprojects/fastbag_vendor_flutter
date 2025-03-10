import 'package:flutter/material.dart';



class IconInCircle extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color iconColor;
  final Color bgColor;

  const IconInCircle({
    super.key,
    required this.icon,
    required this.bgColor,
    this.size = 50.0,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        color: Colors.white, 
        shape: BoxShape.circle, 
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor, 
          size: size * 0.5, // Adjust icon size relative to the circle
        ),
      ),
    );
  }
}
