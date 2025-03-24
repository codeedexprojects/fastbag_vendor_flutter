import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_file_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_form_field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_toggle_switch.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/category_request_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/list_categories.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view_model/fashion_product_view_model.dart';
import 'package:fastbag_vendor_flutter/storage/fb_local_storage.dart';
import 'package:fastbag_vendor_flutter/storage/fb_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/fashion_category_model.dart';
import '../model/fashion_sub_category_model.dart';
import '../view_model/fashion_category_view_model.dart';

class FashionEditSubCategoryScreen extends StatefulWidget {
  final FashionCategoryModel? category;
  final FashionSubCategoryModel subCategory;

  FashionEditSubCategoryScreen(
      {super.key, required this.category, required this.subCategory});

  @override
  State<FashionEditSubCategoryScreen> createState() =>
      _FashionEditSubCategoryScreenState();
}

class _FashionEditSubCategoryScreenState
    extends State<FashionEditSubCategoryScreen> {
  var _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryControler = TextEditingController();

  int? selectedCategoryId;
  File? _selectedImage;
  int vendorId = 0;
  bool? _switchValue;

  @override
  void initState() {
    FbStore.retrieveData(FbLocalStorage.vendorId);
    setState(() {
      nameController.text = widget.subCategory.name!;
      descriptionController.text = widget.subCategory.description!;
      categoryControler.text = widget.category?.name ?? '';
      selectedCategoryId = widget.category?.id;
      _switchValue = widget.subCategory.enableSubcategory;
    });

    super.initState();
  }

  void _onFilePicked(File? file) {
    setState(() {
      _selectedImage = file;
    });
  }

  void _onSubmitForm() async {
    MultipartFile? imageFile;
    final categoryViewModel =
        Provider.of<FashionCategoryViewModel>(context, listen: false);
    if (_formkey.currentState!.validate()) {
      if (_selectedImage != null) {
        imageFile = await MultipartFile.fromFile(_selectedImage!.path);
      }

      final data = {
        'category': selectedCategoryId,
        'name': nameController.text,
        'description': descriptionController.text,
        if (imageFile != null) 'subcategory_image': imageFile,
        'enable_subcategory': _switchValue
      };
      await categoryViewModel.editFashionSubCategory(
          context: context,
          data: data,
          subcategoryId: widget.subCategory.id ?? 0);
    }
    // else {
    //   showDialog(
    //     context: context,
    //     barrierDismissible: true, // Allow dismissing by tapping outside
    //     builder: (BuildContext context) => const FbBottomDialog(
    //       text: "Update not possible",
    //       descrription: "Change atleast one field to update",
    //       type: FbBottomDialogType.editSubCategoryNotPossible,
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<FashionProductViewModel>(context);

    final screenHeight = MediaQuery.of(context).size.height;
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
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.07, vertical: screenHeight * 0.01),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              FbCategoryFormField(
                  label: "Category Name",
                  controller: nameController,
                  keyboard: TextInputType.name,
                  validator: customValidatornoSpaceError),
              FbCategoryFilePicker(
                  image: widget.subCategory.subcategoryImage ?? '',
                  onFilePicked: (file) => _onFilePicked(file),
                  fileCategory: "Category"),
              FbCategoryFormField(
                label: 'Select Category',
                controller: categoryControler,
                validator: customValidatornoSpaceError,
                readOnly: true,
                onTap: () async {
                  productProvider.categoryRequestModel =
                      (await Navigator.push<CategoryRequestModel>(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ListCategoriesName())));
                  selectedCategoryId = productProvider.categoryRequestModel?.id;
                  categoryControler.text =
                      productProvider.categoryRequestModel?.name ?? '';
                },
              ),
              FbCategoryFormField(
                  label: "Description",
                  controller: descriptionController,
                  keyboard: TextInputType.name,
                  validator: customValidatornoSpaceError),
              FbToggleSwitch(
                title: 'Mark Category in stock',
                initialValue: _switchValue!,
                onToggleChanged: (value) {
                  setState(() {
                    _switchValue = value;
                  });
                },
              ),
              SizedBox(
                height: screenHeight * .04,
              ),
              FbButton(onClick: _onSubmitForm, label: "Update Sub Category")
            ],
          ),
        ),
      ),
    );
  }
}
