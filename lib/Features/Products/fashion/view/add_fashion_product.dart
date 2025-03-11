import 'dart:io';

import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/productname_field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/select_field.dart';
import 'package:flutter/material.dart';

import '../../../../Commons/colors.dart';
import '../../../../Commons/fonts.dart';
import '../../../../Commons/validators.dart';
import '../../../Authentication/View/Widgets/Fb_Text_Form_Field.dart';
import '../../View/widgets/fb_category_file_picker.dart';
import '../../View/widgets/fb_category_form_field.dart';
import '../../View/widgets/fb_products_file_picker.dart';
import '../../View/widgets/fb_toggle_switch.dart';

class AddFashionProduct extends StatefulWidget {
  const AddFashionProduct({super.key});

  @override
  State<AddFashionProduct> createState() => _AddFashionProductState();
}

class _AddFashionProductState extends State<AddFashionProduct> {
  var nameController=TextEditingController();
  var descriptionController=TextEditingController();
  var genderController=TextEditingController();
  var stockUnitController=TextEditingController();
  var priceController=TextEditingController();
  var discountpriceController=TextEditingController();
  var categoryController=TextEditingController();
  var subcategoryController=TextEditingController();
  List? _selectedImages;
  bool _inStock=false;


  void _onFilePicked(List<File> files) {
    print(files);
    setState(() {
      _selectedImages = files;
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(245, 245, 245, 1),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Add Product',
          style: mainFont(
              fontsize: 16, fontweight: FontWeight.w600, color: FbColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductnameField(label: 'Product Name', controller: nameController),
            ProductnameField(label: 'Describe the Product', controller: descriptionController),
           SelectField(label: 'Select Gender', controller: genderController, items: [
             'Male','Female'
           ]),
            FbProductsFilePicker(
              fileCategory: "Product",
              onFilesPicked: _onFilePicked,
            ),
            Row(
              children: [
                Expanded(
                  child: SelectField(label: 'Category', controller: categoryController, items: [
                    'Male','Female'
                  ]),
                ),
                Expanded(
                  child: SelectField(label: 'Sub Category', controller: subcategoryController, items: [
                  'Male','Female'
                ]),),
              ],
            ),
            ProductnameField(label: 'Stock Unit', controller:stockUnitController ),
            ProductnameField(label: 'Product Price', controller: priceController),
            ProductnameField(label: 'Discount Price', controller: discountpriceController),
            Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: screenWidth * .07,
                vertical: screenHeight * .01,
              ),
              child: Row(
                children: [
                Expanded(child: Text('Select Varient')),
                  SizedBox(
                    width: screenWidth*.4
                  ),

        Expanded(child:
                    Row(
                      children: [
                        Icon(Icons.add),
                        Text('New Rule'),
                      ],
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: screenWidth * .07,
                vertical: screenHeight * .01,
              ),
              child: Row(
                children: [
                  Expanded(child: Text('Select Size')),
                  SizedBox(
                      width: screenWidth*.4
                  ),

                     Expanded(child:
                    Row(
                      children: [
                        Icon(Icons.add),
                        Text('New Rule'),
                      ],
                    ),
                  )
                ],
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
            FbButton(onClick: (){}, label: 'Add to Product'),
            SizedBox(
              height: 10,
            ),


          ],
        ),
      ),
    );
  }
}
