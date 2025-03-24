import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_drop_down.dart';
import 'package:fastbag_vendor_flutter/Commons/flush_bar.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_form_field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/category_request_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/color_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/color_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/list_categories.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/list_sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../Commons/colors.dart';
import '../../../../Commons/fonts.dart';
import '../../View/widgets/fb_products_file_picker.dart';
import '../../View/widgets/fb_toggle_switch.dart';
import '../view_model/fashionproduct_view_model.dart';

class AddFashionProduct extends StatefulWidget {
  final FashionCategoryModel category;
  final FashionSubCategoryModel subCategory;
  const AddFashionProduct({
    super.key,
    required this.category,
    required this.subCategory,
  });

  @override
  State<AddFashionProduct> createState() => _AddFashionProductState();
}

class _AddFashionProductState extends State<AddFashionProduct> {
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var stockUnitController = TextEditingController();
  var priceController = TextEditingController();
  var wholeSalePriceController = TextEditingController();
  var categoryController = TextEditingController();
  var subcategoryController = TextEditingController();
  var materialController = TextEditingController();
  List<File> selectedImages = [];
  String? selectedGender;
  List<File>? _selectedImages;
  File? imageFile;
  XFile? pickedImage;
  bool _inStock = true;

  int? selectedCategoryId;
  int? selectedSubCategoryId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCategoryId = widget.category.id;
    selectedSubCategoryId = widget.subCategory.id;
    categoryController.text = widget.category.name ?? '';
    subcategoryController.text = widget.subCategory.name ?? '';
  }

  void _onFilePicked(List<File> files) {
    setState(() {
      _selectedImages = files;
    });
  }

  final _formKey = GlobalKey<FormState>();

  ////////////////////////////////////////////

  final List<Map<String, dynamic>> variants = [];

  void addVariant() {
    setState(() {
      variants.add({
        "color_name": TextEditingController(), // ✅ Store controller
        "color_code": TextEditingController(),
        "sizes": []
      });
    });
    print('Variants after adding: $variants');
  }

  void addSize(int variantIndex) {
    setState(() {
      variants[variantIndex]["sizes"] ??= [];

      variants[variantIndex]["sizes"].add({
        "selectedSize": '',
        "price": TextEditingController(),
        "stock": TextEditingController(),
        "offer_price": TextEditingController(),
      });
    });
  }

  void removeVariant(int index) {
    setState(() {
      variants.removeAt(index);
    });
  }

  void removeSize(int variantIndex, int sizeIndex) {
    setState(() {
      variants[variantIndex]["sizes"].removeAt(sizeIndex);
    });
  }

  void submitVariants() async {
    final productProvider =
        Provider.of<FashionProductViewModel>(context, listen: false);

    // Clone files for potential reuse
    final originalFiles = await Future.wait(selectedImages
        .map((file) async => await MultipartFile.fromFile(file.path)));
    // Clone files for first use
    final firstUseFiles = originalFiles.map((f) => f.clone()).toList();

    // if (selectedImages.isNotEmpty) {
    //   final data = {"image_files": firstUseFiles}; // Use cloned files
    //   productProvider.updateImage(context, 91, data);
    // }
    final formattedData = variants.map((variant) {
      return {
        "color_name": (variant["color_name"].text),
        "color_code": variant["color_code"].text,
        "sizes": variant["sizes"]
            .map((size) => {
                  "size": '${size["selectedSize"]}',
                  "price": double.tryParse(size["price"].text),
                  "stock": int.tryParse(size["stock"].text),
                  "offer_price": double.tryParse(size["offer_price"].text),
                })
            .toList(),
      };
    }).toList();
    final vendorId = await StoreManager().getVendorId();
    var data = {
      "vendor": vendorId,
      "category_id": selectedCategoryId,
      "subcategory_id": selectedSubCategoryId,
      "name": nameController.text,
      "description": descriptionController.text,
      "gender": selectedGender,
      "price": double.tryParse(priceController.text),
      "colors": formattedData,
      "material": materialController.text,
      "is_active": _inStock,
      "wholesale_price": wholeSalePriceController.text.isNotEmpty
          ? double.tryParse(wholeSalePriceController.text)
          : null,
    };
    final imageData = {
      "image_files": firstUseFiles,
    };

    if (_formKey.currentState!.validate()) {
      if (firstUseFiles.isEmpty) {
        showFlushbar(
            context: context,
            color: const Color(0xffFF5252),
            icon: Icons.error_outline,
            message: 'Please select an image');
        return;
      } else {
        productProvider.addFashionProduct(
            context: context, data: data, imageData: imageData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<FashionProductViewModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFFF5F5F5),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Add Fashion Product',
          style: mainFont(
            fontsize: 16,
            fontweight: FontWeight.w600,
            color: FbColors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth / 17),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FbCategoryFormField(
                label: 'Product Name',
                controller: nameController,
                keyboard: TextInputType.text,
                validator: customValidatornoSpaceError,
              ),
              FbCategoryFormField(
                label: 'Describe the Product',
                controller: descriptionController,
                keyboard: TextInputType.text,
                validator: customValidatornoSpaceError,
              ),
              FbCustomDropdown(
                hintText: 'Select Gender',
                value: selectedGender,
                items: const ['M', 'W', 'K', 'U'],
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
              FbProductsFilePicker(
                  fileCategory: 'Product',
                  onFilesPicked: (List<File> files) {
                    setState(() {
                      selectedImages = files;
                    });
                  }),
              Row(
                children: [
                  Expanded(
                    child: FbCategoryFormField(
                      readOnly: true,
                      onTap: () async {
                        productProvider.categoryRequestModel =
                            (await Navigator.push<CategoryRequestModel>(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const ListCategoriesName())));
                        selectedCategoryId =
                            productProvider.categoryRequestModel?.id;
                        categoryController.text =
                            productProvider.categoryRequestModel?.name ?? '';
                      },
                      label: 'Category',
                      controller: categoryController,
                      keyboard: TextInputType.number,
                      validator: customValidatornoSpaceError,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: FbCategoryFormField(
                      readOnly: true,
                      onTap: () async {
                        productProvider.categoryRequestModel =
                            (await Navigator.push<CategoryRequestModel>(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ListSubcategoriesName(
                                          subcategoryId: selectedCategoryId,
                                        ))));
                        selectedSubCategoryId =
                            productProvider.categoryRequestModel?.id;
                        subcategoryController.text =
                            productProvider.categoryRequestModel?.name ?? '';
                      },
                      label: 'Sub Category',
                      controller: subcategoryController,
                      keyboard: TextInputType.number,
                      validator: customValidatornoSpaceError,
                    ),
                  ),
                ],
              ),
              FbCategoryFormField(
                label: 'Price',
                controller: priceController,
                keyboard: TextInputType.number,
                validator: priceValidator,
              ),
              FbCategoryFormField(
                label: 'Stock Unit',
                controller: stockUnitController,
                keyboard: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: customValidatornoSpaceError,
              ),
              FbCategoryFormField(
                label: 'Material',
                controller: materialController,
                keyboard: TextInputType.text,
                validator: customValidatornoSpaceError,
              ),
              FbCategoryFormField(
                label: 'Wholesale Price ',
                controller: wholeSalePriceController,
                validator: priceValidator,
                keyboard: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Variant Section',
                        style:
                            nunito(fontSize: 17, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              for (int i = 0; i < variants.length; i++)
                _buildVariantSection(i, productProvider),
              GestureDetector(
                onTap: addVariant,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Add Variant',
                          style: normalFont4(
                              fontsize: 18,
                              fontweight: FontWeight.w400,
                              color: Colors.blue)),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.add,
                        color: Colors.blue,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
              FbToggleSwitch(
                title: 'Mark Product in stock',
                initialValue: _inStock,
                onToggleChanged: (value) {
                  setState(() {
                    _inStock = value;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * .07,
                    vertical: screenHeight * .01),
                child: FbButton(
                    onClick: () {
                      submitVariants();
                    },
                    label: 'Add to Product'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVariantSection(
      int index, FashionProductViewModel productProvider) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: FbCategoryFormField(
              label: 'Select Color',
              controller: variants[index]["color_name"],
              validator: customValidatornoSpaceError,
              onTap: () async => onColorTap(productProvider, index),
            )),
            if (productProvider.colorPicker?.colorCode != null) ...[
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: FbCategoryFormField(
                label: 'Color Code',
                controller: variants[index]["color_code"],
                validator: customValidatornoSpaceError,
              ))
            ]
          ],
        ),
        //  _buildImagePicker(index),
        for (int j = 0; j < variants[index]["sizes"].length; j++)
          _buildSizeRow(index, j),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => addSize(index),
              child: Text(
                "+ Add Size",
                style: normalFont(
                    fontsize: 15,
                    fontweight: FontWeight.w600,
                    color: Colors.blue),
              ),
            ),
            TextButton(
                onPressed: () => removeVariant(index),
                child: Text(
                  "Remove Variant",
                  style: normalFont(
                      fontsize: 15,
                      fontweight: FontWeight.w600,
                      color: Colors.red),
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildSizeRow(int variantIndex, int sizeIndex) {
    final sizes = variants[variantIndex]["sizes"] ?? [];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FbCustomDropdown(
                        value: sizes[sizeIndex]["selectedSize"].isEmpty
                            ? null
                            : sizes[sizeIndex]["selectedSize"],
                        items: const ['S', 'M', 'L', 'XL', 'XXL', 'XXXL'],
                        hintText: "Size",
                        onChanged: (String? newValue) {
                          print('------------->$newValue');
                          setState(() {
                            sizes[sizeIndex]["selectedSize"] = newValue;
                          });
                          print(
                              '------------------------->${sizes[sizeIndex]["selectedSize"]}');
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: FbCategoryFormField(
                            label: 'Price',
                            controller: sizes[sizeIndex]["price"],
                            validator: priceValidator,
                            keyboard: TextInputType.number)),
                  ],
                ),
                const SizedBox(height: 10), // Space between rows
                Row(
                  children: [
                    Expanded(
                        child: FbCategoryFormField(
                            label: 'Stock',
                            controller: sizes[sizeIndex]["stock"],
                            validator: customValidatornoSpaceError,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboard: TextInputType.number)),
                    const SizedBox(width: 10),
                    Expanded(
                        child: FbCategoryFormField(
                            label: 'Offer Price',
                            controller: sizes[sizeIndex]["offer_price"],
                            validator: priceValidator,
                            keyboard: TextInputType.number)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 15), // Space between inputs and delete button

          // 🛑 Delete Button (Vertically Centered)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red, size: 28),
                onPressed: () {
                  setState(() {
                    variants[variantIndex]["sizes"].removeAt(sizeIndex);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  onColorTap(productProvider, index) async {
    productProvider.colorPicker = (await Navigator.push<ColorPickerModel>(
        context, MaterialPageRoute(builder: (_) => ColorPickerScreen())));
    print(productProvider.colorPicker?.colorName);
    print(productProvider.colorPicker?.colorCode);
    variants[index]["color_name"].text = productProvider.colorPicker?.colorName;
    variants[index]["color_code"].text = productProvider.colorPicker?.colorCode;
  }
}
