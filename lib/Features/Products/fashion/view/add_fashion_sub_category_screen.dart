import 'dart:io';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Features/Products/food/View/widgets/fb_category_form_field.dart';
import 'package:fastbag_vendor_flutter/storage/fb_local_storage.dart';
import 'package:fastbag_vendor_flutter/storage/fb_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Authentication/Model/category_model.dart';
import '../../food/Model/sub_category_model.dart';
import '../../food/View/widgets/fb_category_file_picker.dart';
import '../../food/View/widgets/fb_product_category_dropdown.dart';
import '../../food/View/widgets/fb_toggle_switch.dart';
import '../../food/ViewModel/category_view_model.dart';
import '../model/fashion_category_model.dart';

class FashionAddSubCategoryScreen extends StatefulWidget {
  final List<FashionCategoryModel?> categories;
  const FashionAddSubCategoryScreen({super.key, required this.categories});

  @override
  State<FashionAddSubCategoryScreen> createState() => _AddSubCategoryScreenState();
}

class _AddSubCategoryScreenState extends State<FashionAddSubCategoryScreen> {
  var nameController = TextEditingController();
  var subCategoryController=TextEditingController();
  File? _selectedImage;
  int vendorId = 0;
  bool _switchValue = false;
  var _formKey = GlobalKey<FormState>();
  CategoryModel? selectedCategory;

  @override
  void initState() {
    FbStore.retrieveData(FbLocalStorage.vendorId).then((data) {
      setState(() {
        vendorId = data;
      });
    });
    super.initState();
  }

  void _onFilePicked(File? file) {
    setState(() {
      _selectedImage = file;
    });
  }

  void _onSubmitForm() async {
    final categoryViewModel =
        Provider.of<CategoryViewModel>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("You must select an image for category")),
        );
        return;
      }
      SubCategoryModel category = SubCategoryModel(
          id: 0,
          categoryId: selectedCategory!.id,
          is_enabled: _switchValue,
          name: nameController.text,
          sub_category_image: _selectedImage?.path ?? "",
          vendor: vendorId);

      await categoryViewModel.addProductSubCategory(
          subCategories: category, context: context);

      setState(() {
        nameController.clear();
        _selectedImage = null;
        _switchValue = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
                FbCategoryFormField(
                    label: "Describe Sub Category",
                    controller: subCategoryController,
                    validator: customValidatornoSpaceError),
                FbCategoryFilePicker(
                  onFilePicked: (file) => _onFilePicked(file),
                  fileCategory: "Category",
                ),
                FbProductCategoryDropdown(
                  categories: widget.categories,
                  selectedCategory: selectedCategory,
                  onChanged: (dynamic category) {
                    setState(() {
                      selectedCategory =
                          category; // Update the selected category
                    });
                    print('Selected Category: ${category?.name}');
                  },
                ),
                FbToggleSwitch(
                  title: 'Mark Category in stock',
                  initialValue: _switchValue,
                  onToggleChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
                SizedBox(height: screenWidth * .08),
                FbButton(onClick: _onSubmitForm, label: "Add to Sub Category")
              ],
            ),
          )),
    );
  }
}
