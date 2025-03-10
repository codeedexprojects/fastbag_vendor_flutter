import 'package:flutter/material.dart';

class FbTextAgreement extends StatefulWidget {
  final Function(bool?) onAgreeChanged;

  const FbTextAgreement({super.key, required this.onAgreeChanged});

  @override
  State<FbTextAgreement> createState() => _FbTextAgreementState();
}

class _FbTextAgreementState extends State<FbTextAgreement> {
  bool _isAgreed = false; // Track if agreement is selected or not

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * .07, vertical: screenHeight * .02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Radio<bool>(
                value: true,
                groupValue: _isAgreed,
                onChanged: (bool? value) {
                  setState(() {
                    _isAgreed = value!;
                    widget.onAgreeChanged(_isAgreed); // Pass the updated value back
                  });
                },
                activeColor: _isAgreed ? Colors.green : Colors.transparent, // Green when selected
                //fillColor: const WidgetStatePropertyAll(Colors.grey),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'By continuing you agree to our ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Terms of Service ',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      softWrap: true,
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                           TextSpan(
                            text: 'and ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: Colors.green),
                          ),
                          TextSpan(
                            text: '.',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
