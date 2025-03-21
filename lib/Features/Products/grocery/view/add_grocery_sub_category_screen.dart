import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/flush_bar.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_file_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_form_field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_toggle_switch.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/ViewModel/grocery_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_catgeory_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view/list_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddGrocerySubCategoryScreen extends StatefulWidget {
  final GroceryCategoryModel category;
  const AddGrocerySubCategoryScreen({super.key, required this.category});

  @override
  State<AddGrocerySubCategoryScreen> createState() =>
      _AddGrocerySubCategoryScreenState();
}

class _AddGrocerySubCategoryScreenState
    extends State<AddGrocerySubCategoryScreen> {
  var nameController = TextEditingController();
  var categoryController = TextEditingController();

  GroceryCategoryModel? selectedCategory;

  File? selectedImage;
  bool enableSubcategory = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    categoryController.text = widget.category.name ?? '';
  }

  void _onFilePicked(File? file) {
    setState(() {
      selectedImage = file;
    });
  }

  _onSubmitForm(GroceryViewModel groceryViewModel) async {
    if (_formKey.currentState!.validate()) {
      if (selectedImage == null) {
        showFlushbar(
            context: context,
            color: Colors.red,
            icon: Icons.error_outline,
            message: 'You must select an image for category');
      } else {
        MultipartFile imageFile =
            await MultipartFile.fromFile(selectedImage!.path);

        final data = {
          'category': selectedCategory?.id,
          'name': nameController.text.trim(),
          'subcategory_image': imageFile,
          'enable_subcategory': enableSubcategory,
        };

        await groceryViewModel.addSubCategory(context, data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final groceryViewModel =
        Provider.of<GroceryViewModel>(context, listen: false);

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
        title: const Text("Add Sub Category"),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth / 17),
            child: Column(
              children: [
                SizedBox(height: screenWidth * .06),
                FbCategoryFormField(
                    label: "Sub Category Name",
                    controller: nameController,
                    validator: customValidatornoSpaceError),
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
                  initialValue: enableSubcategory,
                  onToggleChanged: (value) {
                    setState(() {
                      enableSubcategory = value;
                    });
                  },
                ),
                SizedBox(height: screenWidth * .08),
                FbButton(
                    onClick: () => _onSubmitForm(groceryViewModel),
                    label: "Add to Sub Category")
              ],
            ),
          )),
    );
  }
}
