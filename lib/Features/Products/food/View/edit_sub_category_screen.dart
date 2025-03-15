import 'dart:io';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/food/Model/category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/food/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/food/View/widgets/fb_category_file_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/food/View/widgets/fb_category_form_field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/food/View/widgets/fb_product_category_dropdown.dart';
import 'package:fastbag_vendor_flutter/Features/Products/food/View/widgets/fb_toggle_switch.dart';
import 'package:fastbag_vendor_flutter/Features/Products/food/ViewModel/category_view_model.dart';
import 'package:fastbag_vendor_flutter/storage/fb_local_storage.dart';
import 'package:fastbag_vendor_flutter/storage/fb_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditSubCategoryScreen extends StatefulWidget {
  final List<CategoryModel> categories;
  final CategoryModel category;
  final SubCategoryModel subCategory;
  const EditSubCategoryScreen(
      {super.key,
      required this.categories,
      required this.category,
      required this.subCategory});

  @override
  State<EditSubCategoryScreen> createState() => _EditSubCategoryScreenState();
}

class _EditSubCategoryScreenState extends State<EditSubCategoryScreen> {
  var nameController = TextEditingController();
  File? _selectedImage;
  int vendorId = 0;
  bool? _switchValue;
  CategoryModel? selectedCategory;

  @override
  void initState() {
    FbStore.retrieveData(FbLocalStorage.vendorId).then((data) {
      setState(() {
        vendorId = data;
        selectedCategory = widget.category;
        _switchValue = widget.subCategory.is_enabled;
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
    if (nameController.text.isNotEmpty ||
        _selectedImage != null ||
        widget.category.name != selectedCategory!.name ||
        widget.subCategory.is_enabled != _switchValue) {
      SubCategoryModel category = SubCategoryModel(
          id: widget.subCategory.id,
          categoryId: widget.subCategory.categoryId,
          is_enabled: _switchValue!,
          name: nameController.text.isEmpty
              ? widget.subCategory.name
              : nameController.text,
          sub_category_image: _selectedImage?.path ?? "",
          vendor: vendorId);

      await categoryViewModel.editProductSubCategory(
          subCategories: category, context: context);

      setState(() {
        nameController.clear();
        _selectedImage = null;
        _switchValue = false;
      });
    } else {
      showDialog(
        context: context,
        barrierDismissible: true, // Allow dismissing by tapping outside
        builder: (BuildContext context) => const FbBottomDialog(
          text: "Update not possible",
          descrription: "Change atleast one field to update",
          type: FbBottomDialogType.editSubCategoryNotPossible,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          FbCategoryFormField(
              label: "Category Name",
              hint: widget.subCategory.name,
              controller: nameController,
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
                selectedCategory = category; // Update the selected category
              });
              print('Selected Category: ${category?.name}');
            },
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
          FbButton(onClick: _onSubmitForm, label: "Update Sub Category")
        ],
      ),
    );
  }
}
