import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/productname_field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/select_field.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Commons/colors.dart';
import '../../../../Commons/fonts.dart';
import '../../View/widgets/fb_products_file_picker.dart';
import '../../View/widgets/fb_toggle_switch.dart';

class AddFashionProduct extends StatefulWidget {
  const AddFashionProduct({super.key});

  @override
  State<AddFashionProduct> createState() => _AddFashionProductState();
}

class _AddFashionProductState extends State<AddFashionProduct> {
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var genderController = TextEditingController();
  var stockUnitController = TextEditingController();
  var priceController = TextEditingController();
  var discountPriceController = TextEditingController();
  var categoryController = TextEditingController();
  var subcategoryController = TextEditingController();
  List<File>? _selectedImages;
  bool _inStock = false;

  List<Map<String, dynamic>> sizeRules = []; // List to store size & color variants
  List <Map<String,dynamic>> addVarient=[];
  void addVarientRule() {
    setState(() {
      addVarient.add({
        "size": "",
        "image":"",

      });
    });
  }
  void removeRuleVarient(int index) {
    setState(() {
      addVarient.removeAt(index);
    });
  }

  void _onFilePicked(List<File> files) {
    setState(() {
      _selectedImages = files;
    });
  }

  void addNewSizeRule() {
    setState(() {
      sizeRules.add({
        "size": "",
        "price": "",
        "color": "",
        "stock": "",
      });
    });
  }

  void removeRule(int index) {
    setState(() {
      sizeRules.removeAt(index);
    });
  }

  ////////////////////////////////////////////

  final List<Map<String, dynamic>> variants = [];

  void addVariant() {
    setState(() {
      variants.add({
        "color_name": "",
        "color_image": null,
        "sizes": []
      });
    });
  }

  void removeVariant(int index) {
    setState(() {
      variants.removeAt(index);
    });
  }

  void addSize(int variantIndex) {
    setState(() {
      variants[variantIndex]["sizes"].add({"size": "", "price": "", "stock": ""});
    });
  }

  void removeSize(int variantIndex, int sizeIndex) {
    setState(() {
      variants[variantIndex]["sizes"].removeAt(sizeIndex);
    });
  }

  Future<void> pickImage(int index) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        variants[index]["color_image"] = File(pickedFile.path);
      });
    }
  }

  void submitVariants() {
    final List<Map<String, dynamic>> formattedData = variants.map((variant) {
      return {
        "color_name": variant["color_name"],
        "color_image": variant["color_image"] != null ? variant["color_image"].path : "",
        "sizes": variant["sizes"].map((size) => {
          "size": size["size"],
          "price": size["price"],
          "stock": size["stock"]
        }).toList()
      };
    }).toList();
    print(formattedData);
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
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
        child: Column(
          children: [
            ProductnameField(label: 'Product Name', controller: nameController),
            ProductnameField(label: 'Describe the Product', controller: descriptionController),
            SelectField(label: 'Select Gender', controller: genderController, items: ['Male', 'Female']),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight*.01,
                horizontal: screenWidth*.07
              ),
              child: FbProductsFilePicker(
                fileCategory: "Product",
                onFilesPicked: _onFilePicked,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SelectField(label: 'Category', controller: categoryController, items: ['Men', 'Women']),
                ),
                Expanded(
                  child: SelectField(label: 'Sub Category', controller: subcategoryController, items: ['Shirts', 'Pants']),
                ),
              ],
            ),
            ProductnameField(label: 'Stock Unit', controller: stockUnitController),
            ProductnameField(label: 'Product Price (N)', controller: priceController),
            ProductnameField(label: 'Discount Price (Optional)', controller: discountPriceController),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .07, vertical: screenHeight * .01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Varient', style: normalFont4(fontsize: 16, fontweight: FontWeight.w400, color: FbColors.black2)),
                  GestureDetector(
                    onTap: addVarientRule,
                    child: Row(
                      children:  [
                        Icon(Icons.add, color: Color.fromRGBO(76, 76, 76, 1),size: 14,),
                        SizedBox(width: 5),
                        Text('New Rule', style:normalFont5(fontsize: 14, fontweight: FontWeight.w500, color: Color.fromRGBO(76, 76, 76, 1))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: addVarient.asMap().entries.map((entry) {
                int index = entry.key;
                var varientRule = entry.value;
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * .07, vertical: 5),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        // Size, Price, Color, and Stock fields
                        Row(
                          children: [
                            Expanded(
                              child: Text('Color Name'),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                initialValue: varientRule["color"],
                                decoration: const InputDecoration(labelText: "Color"),
                                onChanged: (value) {
                                  setState(() {
                                    varientRule[index]["color"] = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [

                            const SizedBox(width: 10),
                            Expanded(
                              child:FbProductsFilePicker(
                                fileCategory: "Product",
                                onFilesPicked: _onFilePicked,
                              ),

                            ),
                            IconButton(
                              onPressed: () => removeRuleVarient(index),
                              icon: const Icon(Icons.close, color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .07, vertical: screenHeight * .01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Size', style: normalFont4(fontsize: 16, fontweight: FontWeight.w400, color: FbColors.black2)),
                  GestureDetector(
                    onTap: addNewSizeRule,
                    child: Row(
                      children:  [
                        Icon(Icons.add, color: Color.fromRGBO(76, 76, 76, 1),size: 14,),
                        SizedBox(width: 5),
                        Text('New Rule', style: normalFont5(fontsize: 14, fontweight: FontWeight.w500, color: Color.fromRGBO(76, 76, 76, 1))),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Dynamically generated size & color rules
            Column(
              children: sizeRules.asMap().entries.map((entry) {
                int index = entry.key;
                var sizeRule = entry.value;
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * .07, vertical: 5),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        // Size, Price, Color, and Stock fields
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: sizeRule["size"],
                                decoration: const InputDecoration(labelText: "Size"),
                                onChanged: (value) {
                                  setState(() {
                                    sizeRules[index]["size"] = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                initialValue: sizeRule["price"],
                                decoration: const InputDecoration(labelText: "Price"),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    sizeRules[index]["price"] = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: sizeRule["color"],
                                decoration: const InputDecoration(labelText: "Color"),
                                onChanged: (value) {
                                  setState(() {
                                    sizeRules[index]["color"] = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                initialValue: sizeRule["stock"],
                                decoration: const InputDecoration(labelText: "Available Stock"),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    sizeRules[index]["stock"] = value;
                                  });
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () => removeRule(index),
                              icon: const Icon(Icons.close, color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:  screenWidth * .07,
                  vertical: screenHeight * .01),
              child: FbToggleSwitch(
                title: 'Mark Product in stock',
                initialValue: _inStock,
                onToggleChanged: (value) {
                  setState(() {
                    _inStock = value;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:  screenWidth * .07,
                  vertical: screenHeight * .01),
              child: FbButton(onClick: () {}, label: 'Add to Product'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
