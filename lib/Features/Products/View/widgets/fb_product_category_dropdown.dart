import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:flutter/material.dart';

class FbProductCategoryDropdown extends StatelessWidget {
  final List<dynamic> categories;
  final dynamic selectedCategory;
  final Function(dynamic) onChanged;

  const FbProductCategoryDropdown({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DropdownButtonFormField<dynamic>(
            hint: Text(
              'Product Category',
              style: nunito(
                  color: Colors.grey.shade600, fontWeight: FontWeight.w300),
            ),
            value: selectedCategory,
            items: categories.map((category) {
              return DropdownMenuItem<dynamic>(
                value: category,
                child: Text(
                  category.name,
                  style: nunito(fontWeight: FontWeight.w600),
                ),
              );
            }).toList(),
            onChanged: categories.isEmpty
                ? null
                : (dynamic value) {
                    onChanged(value); // Notify parent with the selected value
                  },
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                suffixIcon: selectedCategory != null
                    ? const Icon(Icons.check, color: Colors.green)
                    : null),
          ),
        ],
      ),
    );
  }
}
