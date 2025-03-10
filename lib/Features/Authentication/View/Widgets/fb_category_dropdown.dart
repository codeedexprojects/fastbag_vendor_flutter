import 'package:flutter/material.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/Model/category_model.dart';

class FbCategoryDropdown extends StatelessWidget {
  final List<CategoryModel> categories;
  final String hint;
  final CategoryModel? selectedCategory;
  final Function(CategoryModel?) onChanged;

  const FbCategoryDropdown({
    super.key,
    required this.categories,
    required this.hint,
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
            Text(
              'STORE TYPE',
              style:
                  TextStyle(fontSize: screenWidth * .025, color: Colors.grey),
            ),
            DropdownButtonFormField<CategoryModel>(
              value: selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem<CategoryModel>(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: categories.isEmpty
                  ? null
                  : (CategoryModel? value) {
                      onChanged(value); // Notify parent with the selected value
                    },
              decoration: InputDecoration(
                hintText: hint,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
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
