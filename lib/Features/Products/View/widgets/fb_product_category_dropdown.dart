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
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * .07, vertical: screenHeight * .02),
      child: SizedBox(
        height: screenHeight * .11,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButtonFormField<dynamic>(
              hint: const Text('Product Category'),
              value: selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem<dynamic>(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: categories.isEmpty
                  ? null
                  : (dynamic value) {
                      onChanged(value); // Notify parent with the selected value
                    },
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
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
      ),
    );
  }
}
