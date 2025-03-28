import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/placeholder.dart';
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

categoryCard({required radius, required image, required onTap, required text}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.3), // Shadow color with opacity
                  blurRadius: 7, // Spread of the shadow
                  spreadRadius: 2, // How much the shadow expands
                  offset: const Offset(0, 4), // Shadow position
                ),
              ],
            ),
            child: CircleAvatar(radius: radius, backgroundImage: image),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: nunito(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

subCategoryCard(
    {required VoidCallback onTap,
    required double height,
    required String image,
    required String text}) {
  return Column(
    children: [
      InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          width: 103,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), // Optional rounded corners
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              height: height,
              width: 103,
              fit: BoxFit.cover,
              imageUrl: image,
              placeholder: (context, url) =>
                  Image.asset(PlaceholderImage.placeholderimage),
            ),
          ),
        ),
      ),
      const SizedBox(height: 13),
      Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: nunito(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    ],
  );
}
