import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_drop_down.dart';
import 'package:fastbag_vendor_flutter/Commons/flush_bar.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_form_field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_products_file_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_toggle_switch.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/ViewModel/grocery_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_catgeory_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_sub_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddGroceryProduct extends StatefulWidget {
  final GroceryCategoryModel category;
  final GrocerySubCategoryModel subCategory;

  const AddGroceryProduct(
      {super.key, required this.category, required this.subCategory});

  @override
  State<AddGroceryProduct> createState() => _AddGroceryProductState();
}

class _AddGroceryProductState extends State<AddGroceryProduct> {
  final _formkey = GlobalKey<FormState>();
  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedColor;
  String? selectWight;
  String? selectedMeasurment;
  String? selectPrice;
  String? selectQuantity;
  List<File> selectedImages = [];
  bool isOfferProduct = false;
  bool isPopularProduct = false;
  bool isProductInStock = false;
  bool hasValidatedOnce = false;
  List<Map<String, dynamic>> variantFields = []; // Corrected declaration
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  late TextEditingController categoryController;
  late TextEditingController subCategoryController;
  var priceController = TextEditingController();
  var discountController = TextEditingController();
  var discountedPriceController = TextEditingController();
  var wholesalePriceController = TextEditingController();
  var weightController = TextEditingController();

  List<String> categories = ["Electronics", "Clothing", "Groceries"];
  List<String> subCategories = ["Phones", "Laptops", "Accessories"];

  void _onFilePicked(List<File> files) {}

  final List<String> itemMeasurements = [
    'kg',
    'g',
    'ml',
    'L',
    'Pack',
    'Box',
    'Piece'
  ];

  void addVariant() {
    setState(() {
      variantFields.add({
        'weightController': TextEditingController(),
        'priceController': TextEditingController(),
        'selectedQuantity': null, // Track selected quantity here
        'selectedVariantMeasurment': null,
        'stockStatus': false,
      });
    });
  }

  void removeVariant(int index) {
    setState(() {
      variantFields.removeAt(index);
    });
  }

  void _updateDiscountedPrice(value) {
    final price = double.tryParse(priceController.text) ?? 0.0;
    final discount = double.tryParse(discountController.text) ?? 0.0;

    setState(() {
      if (price > 0 && discount > 0) {
        final discountedPrice = price - ((discount / 100) * price);
        discountedPriceController.text = discountedPrice.toStringAsFixed(2);
      } else {
        discountedPriceController.clear();
      }
    });
  }

  onAddProductClicked() async {
    final groceryViewModel =
        Provider.of<GroceryViewModel>(context, listen: false);

    hasValidatedOnce = true;

    // Convert selected images into multipart files
    List<MultipartFile> imageFiles = await Future.wait(
      selectedImages
          .map((file) async => await MultipartFile.fromFile(file.path)),
    );

    final data = {
      "vendor": 18,
      "category": widget.category.id,
      "sub_category": widget.subCategory.id,
      "name": nameController.text.trim(),
      "wholesale_price": double.tryParse(wholesalePriceController.text.trim())
          ?.toStringAsFixed(2),
      "price": double.tryParse(priceController.text.trim())?.toStringAsFixed(2),

      "discount":
          double.tryParse(discountController.text.trim())?.toStringAsFixed(2) ??
              0.0,

      "description": descriptionController.text.trim(),
      "weight_measurement": selectedMeasurment,
      "Available": isProductInStock,
      "is_offer_product": isOfferProduct,
      "is_popular_product": isPopularProduct,
      "weights": [
        for (var variant in variantFields)
          if (variant['weightController']!.text.isNotEmpty &&
              variant['priceController']!.text.isNotEmpty &&
              variant['selectedQuantity'] != null)
            {
              "weight":
                  "${(variant['weightController']!.text)}${variant['selectedVariantMeasurment']}",
              "price": double.tryParse(variant['priceController']!.text.trim())
                  ?.toStringAsFixed(2),
              "quantity": int.parse(variant['selectedQuantity']),
              "is_in_stock": variant['stockStatus'],
            }
      ],
      "images": imageFiles, // Sending images as MultipartFile
    };

    if (_formkey.currentState!.validate()) {
      if (selectedImages.isEmpty) {
        showFlushbar(
          context: context,
          color: Colors.red,
          icon: Icons.image,
          message: 'Select at least one Image',
        );
      } else {
        await groceryViewModel.addProduct(context, data);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryController = TextEditingController(text: widget.category.name);
    subCategoryController =
        TextEditingController(text: widget.subCategory.name);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final gap = SizedBox(height: width * 0.03);
    return Scaffold(
      backgroundColor: OrderColor.backGroundColor,
      appBar: AppBar(
        backgroundColor: OrderColor.backGroundColor,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded)),
        centerTitle: true,
        title: Text(
          'Add product',
          style: poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width / 17),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              gap,
              FbCategoryFormField(
                  label: 'Product Name',
                  controller: nameController,
                  validator: customValidatornoSpaceError),
              FbCategoryFormField(
                  label: 'Describe the Product',
                  controller: descriptionController,
                  validator: customValidatornoSpaceError),
              FbProductsFilePicker(
                  fileCategory: 'Product',
                  onFilesPicked: (List<File> files) {
                    setState(() {
                      selectedImages = files;
                    });
                  }),
              SizedBox(height: height * 0.013),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: FbCategoryFormField(
                    label: 'Category',
                    controller: categoryController,
                    readOnly: true,
                  )),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Expanded(
                      child: FbCategoryFormField(
                    label: 'Sub Category',
                    controller: subCategoryController,
                    readOnly: true,
                  )),
                ],
              ),
              FbCategoryFormField(
                  label: 'Wholesale Price',
                  controller: wholesalePriceController,
                  keyboard:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    LengthLimitingTextInputFormatter(8)
                  ],
                  validator: priceValidator),
              FbCategoryFormField(
                  label: 'Product Price',
                  controller: priceController,
                  keyboard:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    LengthLimitingTextInputFormatter(8)
                  ],
                  onChanged: _updateDiscountedPrice,
                  validator: priceValidator),
              FbCategoryFormField(
                label: 'Discount Price (%)',
                controller: discountController,
                onChanged: _updateDiscountedPrice,
                validator: discountValidator,
                keyboard: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  LengthLimitingTextInputFormatter(4)
                ],
              ),
              if (discountController.text.isNotEmpty &&
                  priceController.text.isNotEmpty &&
                  (double.tryParse(discountedPriceController.text) ?? 0) > 0)
                Row(
                  children: [
                    const Text('Discounted Price  ='),
                    const SizedBox(width: 15),
                    Expanded(
                      child: FbCategoryFormField(
                        label: 'Discounted Price',
                        controller: discountedPriceController,
                        readOnly: true,
                        validator: discountValidator,
                      ),
                    ),
                  ],
                ),
              FbCustomDropdown(
                value: selectedMeasurment,
                hintText: "Weight Measurement",
                items: itemMeasurements,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMeasurment = newValue;
                  });
                },
              ),
              FbToggleSwitch(
                title: 'Offer Product',
                initialValue: isOfferProduct,
                onToggleChanged: (value) {
                  setState(() {
                    isOfferProduct = value;
                  });
                },
              ),
              FbToggleSwitch(
                title: 'Popular Product',
                initialValue: isPopularProduct,
                onToggleChanged: (value) {
                  setState(() {
                    isPopularProduct = value;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: width * 0.04,
                  horizontal: width * 0.03,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select Weight Variant',
                        style:
                            nunito(fontSize: 17, fontWeight: FontWeight.w600)),
                    GestureDetector(
                      onTap: () {
                        addVariant();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: OrderColor.black,
                            size: width * 0.05,
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          Text('New Rule', style: nunito())
                        ],
                      ),
                    )
                  ],
                ),
              ),
              genaratevariantFields(),
              FbToggleSwitch(
                title: 'Mark Product Is Available',
                initialValue: isProductInStock,
                onToggleChanged: (value) {
                  setState(() {
                    isProductInStock = value;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: width * .04),
                child: FbButton(
                    onClick: onAddProductClicked, label: 'Add to Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  genaratevariantFields() {
    return Column(
        children: List.generate(variantFields.length, (index) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FbCategoryFormField(
                    keyboard:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    label: 'Weight',
                    controller: variantFields[index]['weightController'],
                    validator: customValidatornoSpaceError),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: FbCustomDropdown(
                  value: variantFields[index]['selectedVariantMeasurment'],
                  items: itemMeasurements,
                  hintText: "Kg",
                  onChanged: (String? newValue) {
                    setState(() {
                      variantFields[index]['selectedVariantMeasurment'] =
                          newValue;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: FbCategoryFormField(
                      keyboard:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*')),
                        LengthLimitingTextInputFormatter(8)
                      ],
                      label: 'Price',
                      controller: variantFields[index]['priceController'],
                      validator: priceValidator)),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: FbCustomDropdown(
                  value: variantFields[index]['selectedQuantity'],
                  hintText: "Quantity",
                  items: List.generate(10, (index) => (index + 1).toString()),
                  onChanged: (String? newValue) {
                    setState(() {
                      variantFields[index]['selectedQuantity'] = newValue;
                    });
                  },
                ),
              )
            ],
          ),
          FbToggleSwitch(
            title: 'Mark Product In Stock',
            initialValue: variantFields[index]['stockStatus'],
            onToggleChanged: (value) {
              setState(() {
                variantFields[index]['stockStatus'] = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () => removeVariant(index),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Remove',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                )),
          ),
        ],
      );
    }));
  }
}
