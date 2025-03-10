import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FbCategoryFormField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextInputType? keyboard;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool noPadding;

  const FbCategoryFormField(
      {super.key,
      required this.label,
      this.keyboard,
      required this.controller,
      this.validator,
      this.noPadding = false, this.hint});

  @override
  State<FbCategoryFormField> createState() => _FbCategoryFormFieldState();
}

class _FbCategoryFormFieldState extends State<FbCategoryFormField> {
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
          vertical: widget.noPadding ? 0 : screenHeight * .02),
      child: SizedBox(
        //height: screenHeight * .11,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.label.toUpperCase(),
              style:
                  TextStyle(fontSize: screenWidth * .025, color: Colors.grey),
            ),
            TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboard,
              focusNode: _focusNode,
              validator: widget.validator,
              decoration: InputDecoration(
                hintText: widget.hint ?? widget.label,
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: _showCheckIcon
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.2),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
