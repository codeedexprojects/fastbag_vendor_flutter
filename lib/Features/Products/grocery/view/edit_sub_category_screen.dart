import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/flush_bar.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_file_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_form_field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_toggle_switch.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/ViewModel/grocery_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view/list_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/grocery_catgeory_model.dart';

class EditGrocerySubCategoryScreen extends StatefulWidget {
  final GroceryCategoryModel category;
  final GrocerySubCategoryModel subCategory;
  const EditGrocerySubCategoryScreen(
      {super.key, required this.category, required this.subCategory});

  @override
  State<EditGrocerySubCategoryScreen> createState() =>
      _EditGrocerySubCategoryScreenState();
}

class _EditGrocerySubCategoryScreenState
    extends State<EditGrocerySubCategoryScreen> {
  late TextEditingController nameController;
  var categoryController = TextEditingController();

  File? _selectedImage;
  bool? _switchValue;
  GroceryCategoryModel? selectedCategory;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.subCategory.name);
    categoryController.text = widget.category.name ?? '';
    _switchValue = widget.subCategory.enableSubcategory;

    super.initState();
  }

  void _onFilePicked(File? file) {
    setState(() {
      _selectedImage = file;
    });
  }

  onSubmitForm(GroceryViewModel groceryViewModel, int subCategoryId) async {
    MultipartFile? imageFile; // Allow nullable assignment

    if (_selectedImage != null) {
      imageFile = await MultipartFile.fromFile(_selectedImage!.path);
    }

    final data = {
      if (nameController.text.isNotEmpty) 'name': nameController.text,
      if (imageFile != null) "subcategory_image": imageFile,
      if (selectedCategory != null) 'category': selectedCategory!.id,
      "enable_subcategory": _switchValue, // Ensure it has a default value
    };

    if (data.isEmpty) {
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error_outline,
        message: 'There is nothing to update',
      );
    } else {
      await groceryViewModel.editSubCategory(context, subCategoryId, data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final groceryViewModel = Provider.of<GroceryViewModel>(context);
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
              Icons.arrow_back_ios_new), // Replace with your desired icon
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Edit Sub Category",
          style: mainFont(
              fontsize: screenWidth * 0.05,
              fontweight: FontWeight.w500,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            FbCategoryFormField(
                label: "Category Name",
                controller: nameController,
                validator: customValidatornoSpaceError),
            // Check if subcategory image exists
            // (_selectedImage == null &&
            //         widget.subCategory.subcategoryImage != null)
            //     ? ClipRRect(
            //         borderRadius: BorderRadius.circular(10),
            //         child: Image.network(
            //           widget.subCategory.subcategoryImage!,
            //           width: 100,
            //           height: 100,
            //           fit: BoxFit.cover,
            //         ),
            //       )
            //     :
            FbCategoryFilePicker(
              onFilePicked: (file) => _onFilePicked(file),
              fileCategory: "Category",
            ),
            FbCategoryFormField(
              onTap: () async {
                final selectedCat = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ListCategoriesName(),
                  ),
                );

                if (selectedCat != null) {
                  setState(() {
                    selectedCategory = selectedCat;
                    categoryController.text = selectedCat.name;
                  });
                }
              },
              readOnly: true,
              label: 'Category',
              controller: categoryController,
              keyboard: TextInputType.number,
            ),
            FbToggleSwitch(
              title: 'Mark Category in stock',
              initialValue: _switchValue!,
              onToggleChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            ),
            FbButton(
                onClick: () =>
                    onSubmitForm(groceryViewModel, widget.subCategory.id),
                label: "Update Sub Category")
          ],
        ),
      ),
    );
  }
}
