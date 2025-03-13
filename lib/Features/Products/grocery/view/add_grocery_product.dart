import 'dart:io';

import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_drop_down.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/Fb_Text_Form_Field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_file_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_form_field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_products_file_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Commons/localvariables.dart';
import '../../../Authentication/View/Widgets/fb_file_picker.dart';

class AddGroceryProduct extends StatefulWidget {
  const AddGroceryProduct({super.key});

  @override
  State<AddGroceryProduct> createState() => _AddGroceryProductState();
}

class _AddGroceryProductState extends State<AddGroceryProduct> {
  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedColor;
  String? selectWight;
  String? selectKg;
  String? selectPrice;
  String? selectQuantity;
  bool isOfferProduct = false;
  bool isPopularProduct = false;
  bool markProduct = false;
  List<Map<String, dynamic>> variantFields = [];
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var discountController = TextEditingController();
  var wholeSaleController = TextEditingController();
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
  addVariant() {
    setState(() {
      variantFields.add({
        'weightController': TextEditingController(),
        'priceController': TextEditingController(),
        'quantityController': TextEditingController(),
        'stockStatus': bool,
      });
    });
  }
  // Function to remove a variant field

  void removeVariant(int index) {
    setState(() {
      variantFields.removeAt(index);
    });
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
        leading: const Icon(Icons.arrow_back_ios_new_rounded),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            gap,
            FbCategoryFormField(
                label: 'Product Name', controller: nameController),
            FbCategoryFormField(
                label: 'Describe the Product',
                controller: descriptionController),
            FbProductsFilePicker(
                fileCategory: 'Product', onFilesPicked: _onFilePicked),
            SizedBox(height: height * 0.013),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FbCustomDropdown(
                    value: selectedCategory,
                    hintText: "Category",
                    items: categories,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                Expanded(
                  child: FbCustomDropdown(
                    value: selectedSubCategory,
                    hintText: "Sub Category",
                    items: subCategories,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSubCategory = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            FbCategoryFormField(
                label: 'Wholesale Price', controller: wholeSaleController),
            FbCategoryFormField(
                label: 'Product Price', controller: priceController),
            FbCategoryFormField(
                label: 'Discount Price (Optional)',
                controller: discountController),
            FbCustomDropdown(
              value: selectKg,
              hintText: "Weight Measurement",
              items: itemMeasurements,
              onChanged: (String? newValue) {
                setState(() {
                  selectKg = newValue;
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
                      style: nunito(fontSize: 17, fontWeight: FontWeight.w600)),
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: width * .04),
              child: FbButton(onClick: () {}, label: 'Add to Product'),
            ),
          ],
        ),
      ),
    );
  }

  genaratevariantFields() {
    return Column(
        children: List.generate(variantFields.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: FbCategoryFormField(
                      keyboard: TextInputType.number,
                      label: 'Wieght',
                      controller: variantFields[index]['weightController']),
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                Expanded(
                  child: FbCustomDropdown(
                    value: selectKg,
                    items: itemMeasurements,
                    hintText: "Kg",
                    onChanged: (String? newValue) {
                      setState(() {
                        selectKg = newValue;
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
                        keyboard: TextInputType.number,
                        label: 'Price',
                        controller: variantFields[index]['priceController'])),
                SizedBox(
                  width: width * 0.03,
                ),
                Expanded(
                    child: FbCustomDropdown(
                  value: selectQuantity,
                  hintText: "Quantity",
                  items: List.generate(10, (index) => (index + 1).toString()),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectQuantity = newValue;
                    });
                  },
                ))
              ],
            ),
            FbToggleSwitch(
              title: 'Mark Product In Stock',
              initialValue: variantFields[index]['stockStatus'],
              onToggleChanged: (value) {
                setState(() {
                  isPopularProduct = value;
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
        ),
      );
    }));
  }
}
