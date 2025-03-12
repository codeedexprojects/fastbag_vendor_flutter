import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: DropdownButtonFormField<String>(
        value: value,
        style: inter(fontSize: 15, color: Colors.black),
        hint: Text(
          hintText,
          style:
              inter(color: Colors.grey.shade600, fontWeight: FontWeight.w300),
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.015),
            borderSide: BorderSide(
              color:
                  Colors.grey.shade300, // Replace with OrderColor.borderColor
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.015),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.015),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
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
