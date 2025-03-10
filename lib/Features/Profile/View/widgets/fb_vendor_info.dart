import 'package:flutter/material.dart';


class FbVendorInfo extends StatelessWidget {
  final String label;
  final String value;
  const FbVendorInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
            padding:  EdgeInsets.all(screenWidth * 0.05),
            child: SizedBox(
              height: screenHeight*.07,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   Text(label),
                  SizedBox(height: screenHeight * .015,),
                   Text(value)
                ],
              ),
            ),
          );
  }
}