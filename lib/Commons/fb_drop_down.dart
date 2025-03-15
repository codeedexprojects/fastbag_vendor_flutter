import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:flutter/material.dart';

class FbCustomDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String hintText;
  final ValueChanged<String?>? onChanged;

  const FbCustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: DropdownButtonFormField<String>(
        value: value,
        validator: customValidatornoSpaceError,
        style: inter(fontSize: 15, color: Colors.black),
        hint: Text(
          hintText,
          style:
              inter(color: Colors.grey.shade600, fontWeight: FontWeight.w300),
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color:
                  Colors.grey.shade300, // Replace with OrderColor.borderColor
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.red.shade300),
          ),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.red)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
