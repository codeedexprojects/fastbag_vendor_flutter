import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FbTextFormField extends StatefulWidget {
  final String label;
  final TextInputType? keyboard;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool border;
  final bool noPadding;

  const FbTextFormField({
    super.key,
    required this.label,
    this.keyboard,
    required this.controller,
    this.validator,
    this.border = false,
    this.noPadding=false,
  });

  @override
  State<FbTextFormField> createState() => _FbTextFormFieldState();
}

class _FbTextFormFieldState extends State<FbTextFormField> {
  bool _isObscure = true;
  final FocusNode _focusNode = FocusNode();
  bool _showCheckIcon = false;
  bool _showError = false; // Tracks whether to show the error message

  @override
  void initState() {
    super.initState();

    // Listen for focus changes
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // When focus is lost, validate the field and show errors
        setState(() {
          _showError = true;
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
        // height: screenHeight * .11,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.label.toUpperCase(),
              style: TextStyle(
                fontSize: screenWidth * .025,
                color: Colors.grey,
              ),
            ),
            TextFormField(

              controller: widget.controller,
              obscureText: (widget.label == "Password" ||
                      widget.label == "Confirm Password") &&
                  _isObscure,
              keyboardType: widget.keyboard,
              focusNode: _focusNode,
              validator: (value) {
                if (_showError && widget.validator != null) {
                  return widget.validator!(value);
                }
                return null; // No error during typing
              },
              inputFormatters: widget.label == "Phone No"
                  ? [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly,
                    ]
                  : widget.label == "Pincode"
                      ? [
                          LengthLimitingTextInputFormatter(6),
                          FilteringTextInputFormatter.digitsOnly,
                        ]
                      : widget.label == "fssai" || widget.label == "FSSAI No"
                          ? [
                              LengthLimitingTextInputFormatter(14),
                              FilteringTextInputFormatter.digitsOnly,
                            ]
                          : null,
              decoration: InputDecoration(

                suffixIcon: (widget.label == "Password" ||
                        widget.label == "Confirm Password")
                    ? Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: _toggleVisibilityOfPwd,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          if (_showCheckIcon)
                            const Icon(Icons.check, color: Colors.green),
                        ],
                      )
                    : _showCheckIcon
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                enabledBorder: widget.border
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 199, 199, 199)),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      )
                    : const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                focusedBorder: widget.border
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      )
                    : const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                border: widget.border
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      )
                    : const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                errorBorder: widget.border
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      )
                    : const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
