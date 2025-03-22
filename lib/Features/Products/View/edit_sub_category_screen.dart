import 'dart:io';
import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/localvariables.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_categoryby_subCategory_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_file_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_form_field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_product_category_dropdown.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_toggle_switch.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/category_view_model.dart';
import 'package:fastbag_vendor_flutter/storage/fb_local_storage.dart';
import 'package:fastbag_vendor_flutter/storage/fb_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Commons/flush_bar.dart';

class EditSubCategoryScreen extends StatefulWidget {
  final List<CategoryModel> categories;
  final CategoryModel category;
  final FoodCategoryBySubcategoryModel subCategory;
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
  bool _switchValue = false;
  CategoryModel? selectedCategory;

  @override
  void initState() {
    FbStore.retrieveData(FbLocalStorage.vendorId).then((data) {
      // setState(() {
        vendorId = data;
        selectedCategory = widget.category;
        _switchValue = widget.subCategory.enableSubcategory ?? false;
        print(_switchValue);
      // });
        nameController.text = widget.subCategory.name ?? '';
        print("object    ${ widget.subCategory.enableSubcategory}");
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
        widget.subCategory.enableSubcategory != _switchValue) {
      FoodCategoryBySubcategoryModel category = FoodCategoryBySubcategoryModel(
          id: widget.subCategory.id,
          category: widget.subCategory.category,
          enableSubcategory: _switchValue!,
          name: nameController.text.isEmpty
              ? widget.subCategory.name
              : nameController.text,
          subcategoryImage: _selectedImage?.path ?? "",
          vendor: vendorId);
      print("djbdjbdkjdb $_switchValue");

      await categoryViewModel.editProductSubCategory(
          subCategories: category, context: context).then((v){
         categoryViewModel.getFoodCategorybySubCategories(categoryId: selectedCategory!.id);
      });

      // setState(() {
      //   print("djbdjbdkjdb $_switchValue");
      //
      //   nameController.clear();
      //   _selectedImage = null;
      //   // _switchValue = false;
      // });
    }
    // else {
    //   print("djbdjbdkjdb $_switchValue");
    //
    //   showFlushbar(context: context, color: FbColors.errorcolor, icon: Icons.check, message: "Change atleast one field to update");
    // }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: FbColors.backgroundcolor,
      appBar: AppBar(
        backgroundColor: FbColors.backgroundcolor,
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth*0.07,vertical: screenHeight*0.01),
        child: SizedBox(
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
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
                SizedBox(height: screenHeight*0.025,),
                FbButton(onClick: _onSubmitForm, label: "Update Sub Category")
              ],
            ),
<<<<<<< HEAD
          ),
=======
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
              initialValue: _switchValue,
              onToggleChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            ),
            SizedBox(height: 25,),
            FbButton(onClick: _onSubmitForm, label: "Update Sub Category")
          ],
>>>>>>> 7317fe5cc4d2705ece17318cddd70f852b5e77be
        ),
      ),
    );
  }
}
