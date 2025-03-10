import 'package:flutter/material.dart';

class FbTextCreateAccount extends StatelessWidget {
  const FbTextCreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * .07, vertical: screenHeight * .02),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Dont have an account?',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: 'Create new account.',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
        softWrap: true,
      ),
    );
  }
}
