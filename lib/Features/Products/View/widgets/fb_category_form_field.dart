import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FbCategoryFormField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextInputType? keyboard;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;
  final Function(String?) onChanged;
  final bool readOnly;

  const FbCategoryFormField(
      {super.key,
      required this.label,
      this.keyboard,
      required this.controller,
      this.validator,
      this.inputFormatters = const [],
      this.readOnly = false,
      this.onChanged = _defaultOnChanged,
      this.textInputAction,
      this.hint});
  static void _defaultOnChanged(String? value) {
    // Placeholder function (does nothing)
  }
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
        readOnly: widget.readOnly,
        controller: widget.controller,
        onChanged: widget.onChanged,
        style: nunito(fontWeight: FontWeight.w600),
        keyboardType: widget.keyboard,
        textInputAction: widget.textInputAction,
        focusNode: _focusNode,
        validator: widget.validator,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          hintText: widget.hint ?? widget.label,
          hintStyle:
              nunito(color: Colors.grey.shade600, fontWeight: FontWeight.w300),
          suffixIcon: _showCheckIcon
              ? const Icon(Icons.check, color: Colors.green)
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.red.shade300),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
