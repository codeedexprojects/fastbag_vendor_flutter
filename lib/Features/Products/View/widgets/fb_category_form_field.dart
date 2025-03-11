import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FbCategoryFormField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextInputType? keyboard;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const FbCategoryFormField(
      {super.key,
      required this.label,
      this.keyboard,
      required this.controller,
      this.validator,
      this.hint});

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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
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
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.red.shade300),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
