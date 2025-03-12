import 'dart:io';

import 'package:fastbag_vendor_flutter/Commons/colors.dart';
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
  List<File>? _selectedImages;
  bool isOfferProduct = false;
  bool isPopularProduct = false;
  bool markProduct = false;
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var discountController = TextEditingController();
  var wholeSaleController = TextEditingController();
  var weightController = TextEditingController();

  List<String> categories = ["Electronics", "Clothing", "Groceries"];
  List<String> subCategories = ["Phones", "Laptops", "Accessories"];
  List<String> colors = ["Red", "yellow", "green"];
  List<String> weight = ["67", "43", "88"];
  List<String> kg = ["g", "kg", "mm"];
  List<String> price = ["500", "100", "10000"];
  List<String> Quantity = ["500", "100", "10000"];

  void _onFilePicked(List<File> files) {
    if (files.isNotEmpty) {
      setState(() {
        _selectedImages = files;
      });
    }
  }

  final List<String> itemMeasurements = [
    'kg',
    'g',
    'ml',
    'L',
    'Pack',
    'Box',
    'Piece'
  ];
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                        style:
                            nunito(fontSize: 17, fontWeight: FontWeight.w600)),
                    GestureDetector(
                      onTap: () {},
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: FbCategoryFormField(
                              keyboard: TextInputType.number,
                              label: 'Wieght',
                              controller: weightController),
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
                                controller: weightController)),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Expanded(
                            child: FbCustomDropdown(
                          value: selectQuantity,
                          hintText: "Quantity",
                          items: List.generate(
                              10, (index) => (index + 1).toString()),
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
                      initialValue: isPopularProduct,
                      onToggleChanged: (value) {
                        setState(() {
                          isPopularProduct = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              Container(
                height: height * 0.07,
                width: width * 0.94,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.017),
                    color: OrderColor.green),
                child: Center(
                  child: Text(
                    'Add to Product',
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: OrderColor.white),
                  ),
                ),
              ),
              SizedBox(height: height * 0.015),
            ],
          ),
        ),
      ),
    );
  }
}
