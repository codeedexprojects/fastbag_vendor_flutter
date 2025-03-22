import 'dart:io';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_item_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_form_field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_product_category_dropdown.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_products_file_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_toggle_switch.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/category_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/product_view_model.dart';
import 'package:fastbag_vendor_flutter/storage/fb_local_storage.dart';
import 'package:fastbag_vendor_flutter/storage/fb_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Commons/custom_inputdecoration.dart';
import '../../../Commons/fonts.dart';

class AddProductScreen extends StatefulWidget {
  final SubCategoryModel subCategory;
  final List<SubCategoryModel> subCategories;

  const AddProductScreen(
      {super.key, required this.subCategory, required this.subCategories});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var discountController = TextEditingController();
  var wholeSaleController = TextEditingController();
  var offerPriceController = TextEditingController();
  List<File>? _selectedImages;
  int vendorId = 0;
  bool _inStock = false;
  bool _isOffer = false;
  bool _isPopular = false;
  var _formKey = GlobalKey<FormState>();
  SubCategoryModel? selectedCategory;

  // Map to store variants data
  List<Map<String, dynamic>> variants = [];

  // Text Editing Controllers for dynamic variants
  List<Map<String, dynamic>> variantFields = [];

  @override
  void initState() {
    // FbStore.retrieveData(FbLocalStorage.vendorId).then((data) {
    //   setState(() {
    //     vendorId = data;
    //   });
    // }
    //  );
    super.initState();
  }

  final List<Map<String, dynamic>> sizes = [];
  final TextEditingController colorController = TextEditingController();
  final TextEditingController wholesalePriceController =
      TextEditingController();
  final TextEditingController offerPrice = TextEditingController();

  void _onFilePicked(List<File> files) {
    print(files);
    setState(() {
      _selectedImages = files;
    });
  }

  // Function to add a new variant field
  void addVariant() {
    setState(() {
      variantFields.add({
        'nameController': TextEditingController(),
        'priceController': TextEditingController(),
        'quantityController': TextEditingController(),
        'stockStatus': 'in stock', // Default stock status
      });
    });
  }

  // Function to remove a variant field
  void removeVariant(int index) {
    setState(() {
      variantFields.removeAt(index);
    });
  }

  // Function to save product data
  void saveProduct() {
    var productProvider = Provider.of<ProductViewModel>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      if (_selectedImages != null && _selectedImages!.isNotEmpty) {
        variants.clear();
        for (var variant in variantFields) {
          String name = variant['nameController'].text.trim();
          String price = variant['priceController'].text.trim();
          String stockStatus = variant['stockStatus'];

          if (name.isNotEmpty && price.isNotEmpty) {
            variants.add({
              "name": name,
              "price": double.parse(price),
              "stock": stockStatus,
            });
          }
        }

        FoodItemModel model = FoodItemModel(
          vendor: widget.subCategory.vendor,
          category: widget.subCategory.categoryId,
          subcategory: widget.subCategory.id as int,
          name: nameController.text.trim(),
          description: descriptionController.text.trim(),
          price: priceController.text.trim(),
          offer_price: offerPriceController.text.trim(),
          discount: discountController.text.trim(),
          is_available: _inStock,
          image_urls:
              _selectedImages!.map<String>((file) => file.path).toList(),
          is_popular_product: _isPopular,
          is_offer_product: _isOffer,
          wholesale_price: wholeSaleController.text.trim(),
          variants: variants,
        );
        productProvider.addFoodItem(context: context, model: model);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
          elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Color(0xFFF5F5F5),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Add Product"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 17),
          child: Column(
            children: [
              SizedBox(height: screenWidth * .06),

              FbCategoryFormField(
                label: "Product Name",
                controller: nameController,
                validator: customValidatornoSpaceError,
              ),
              FbCategoryFormField(
                label: "Describe the product",
                controller: descriptionController,
                validator: customValidatornoSpaceError,
              ),
              FbProductsFilePicker(
                fileCategory: "Product",
                onFilesPicked: _onFilePicked,
              ),
              FbCategoryFormField(
                keyboard: TextInputType.number,
                label: "Product Price",
                controller: priceController,
                validator: customValidatornoSpaceError,
              ),
              FbCategoryFormField(
                keyboard: TextInputType.number,
                label: "Discount Price",
                controller: discountController,
                validator: customValidatornoSpaceError,
              ),
              FbCategoryFormField(
                keyboard: TextInputType.number,
                label: "Wholesale Price",
                controller: wholeSaleController,
                validator: customValidatornoSpaceError,
              ),
              FbCategoryFormField(
                keyboard: TextInputType.number,
                label: "Offer Price",
                controller: offerPriceController,
                validator: customValidatornoSpaceError,
              ),
              // Dynamic Variant Fields
              const SizedBox(height: 10),

              Column(
                children: List.generate(variantFields.length, (index) {
                  return Column(
                    children: [
                      // Variant Name
                      TextFormField(
                        controller: variantFields[index]['nameController'],
                        decoration: CustumInputDecoration.getDecoration(labelText: "Variant Name (e.g. Half, Full)"),
                        validator: (value) =>
                            value!.isEmpty ? "Enter a variant name" : null,
                      ),
                      // Price
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: variantFields[index]['priceController'],
                        decoration:CustumInputDecoration.getDecoration(labelText: "Price")
                        ,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Enter price" : null,
                      ),
                      // Quantity
                      SizedBox(height: 10,),
                      DropdownButtonFormField<String>(
                        value: variantFields[index]['stockStatus'],
                        decoration: CustumInputDecoration.getDecoration(labelText: "Stock Status"),
                           
                        items: ["in stock", "out of stock"].map((status) {
                          return DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            variantFields[index]['stockStatus'] = newValue!;
                          });
                        },
                      ),
                      SizedBox(height: 5,),
                      // Remove Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => removeVariant(index),
                          child: Text("Remove",
                              style: const TextStyle(color: Colors.red)),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              // Add Variant Button
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * .01, vertical: screenHeight * .01),
                child: GestureDetector(
                  onTap:addVariant ,
                  child: Row(
                    children: [
                      Text('Add Varient',
                          style: normalFont4(
                              fontsize: 18,
                              fontweight: FontWeight.w400,
                              color: Colors.blue)),
                      SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.blue,
                            size: 18,
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Center(
              //   child: ElevatedButton(
              //     style: ButtonStyle(
              //       minimumSize: WidgetStateProperty.all(
              //           Size(screenWidth * .9, screenHeight * .05)),
              //       shape: WidgetStateProperty.all(
              //         RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(
              //               0), // Set the borderRadius to 0
              //         ),
              //       ),
              //     ),
              //     onPressed: addVariant,
              //     child: const Text("+ Add Variant"),
              //   ),
              // ),

              // SizedBox(height: screenHeight * 0.03),
              FbToggleSwitch(
                title: 'Mark Product in stock',
                initialValue: _inStock,
                onToggleChanged: (value) {
                  setState(() {
                    _inStock = value;
                  });
                },
              ),
              FbToggleSwitch(
                title: 'Is offer available',
                initialValue: _isOffer,
                onToggleChanged: (value) {
                  setState(() {
                    _isOffer = value;
                  });
                },
              ),
              FbToggleSwitch(
                title: 'Is popular',
                initialValue: _isPopular,
                onToggleChanged: (value) {
                  setState(() {
                    _isPopular = value;
                  });
                },
              ),
              FbButton(
                onClick: saveProduct,
                label: "Add to Sub Category",
              ),
              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
