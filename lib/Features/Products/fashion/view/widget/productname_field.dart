import 'package:flutter/material.dart';

import '../../../../../Commons/fonts.dart';

class ProductnameField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextInputType? keyboard;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool noPadding;

  const ProductnameField(
      {super.key,
      required this.label,
      required this.keyboard,
      required this.controller,
      this.validator,
      this.noPadding = false,
      this.hint});

  @override
  State<ProductnameField> createState() => _ProductnameFieldState();
}

class _ProductnameFieldState extends State<ProductnameField> {
  bool _isObscure = true;

  final FocusNode _focusNode = FocusNode();
  bool _showCheckIcon = false;

  @override
  void initState() {
    super.initState();

    // Listen for focus changes
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // When focus is lost, check if there's any text to show the icon
        setState(() {
          _showCheckIcon = widget.controller.text.isNotEmpty;
        });
      }
      if (_focusNode.hasFocus) {
        // When focus is lost, check if there's any text to show the icon
        setState(() {
          _showCheckIcon = widget.controller.text.isNotEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleVisibilityOfPwd() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.noPadding ? 0 : screenWidth * .07,
          vertical: widget.noPadding ? 0 : screenHeight * .01),
      child: SizedBox(
        //height: screenHeight * .11,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboard,
              focusNode: _focusNode,
              validator: widget.validator,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
                  borderRadius: BorderRadius.circular(
                    0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
                  borderRadius: BorderRadius.circular(
                    0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
                  borderRadius: BorderRadius.circular(
                    0,
                  ),
                ),
                hintText: widget.hint ?? widget.label,
                hintStyle: normalFont4(
                    fontsize: 14,
                    fontweight: FontWeight.w400,
                    color: Color.fromRGBO(26, 26, 26, 1)),
                suffixIcon: _showCheckIcon
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
