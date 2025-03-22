import 'dart:io';
import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_response.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/category_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/product_edit_delete_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_item_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_form_field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_products_file_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_toggle_switch.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/product_view_model.dart';

import '../../../Commons/custom_inputdecoration.dart';
import '../../../Commons/fonts.dart';

class EditProductScreen extends StatefulWidget {
  final FoodResponseModel product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var discountController = TextEditingController();
  var wholeSaleController = TextEditingController();
  var offerPriceController = TextEditingController();

  List<File>? _selectedImages;
  bool _inStock = false;
  bool _isOffer = false;
  bool _isPopular = false;
  var _formKey = GlobalKey<FormState>();

  // List of variants
  List<Map<String, dynamic>> variantFields = [];

  @override
  void initState() {
    super.initState();

    // Pre-fill the form with existing product data
    nameController.text = widget.product.name ?? '';
    descriptionController.text = widget.product.description ?? '';
    priceController.text = widget.product.price.toString();
    discountController.text = widget.product.discount.toString();
    wholeSaleController.text = widget.product.wholesalePrice.toString();
    offerPriceController.text = widget.product.offerPrice.toString();
    _inStock = widget.product.isAvailable ?? false;
    _isOffer = widget.product.isOfferProduct ?? false;
    _isPopular = widget.product.isPopularProduct ?? false;

    // Pre-fill variants
    for (var variant in widget.product.variants ?? []) {
      variantFields.add({
        'nameController': TextEditingController(text: variant.name ?? ""),
        'priceController':
            TextEditingController(text: variant.price?.toString() ?? ""),
        'stockStatus': variant.stock ?? '',
      });
    }
  }

  void _onFilePicked(List<File> files) {
    setState(() {
      _selectedImages = files;
    });
  }

  // Function to update product details
  void updateProduct() {
    var productProvider = Provider.of<ProductViewModel>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      List<Map<String, dynamic>> updatedVariants = [];
      for (var variant in variantFields) {
        String name = variant['nameController'].text.trim();
        String price = variant['priceController'].text.trim();
        String stockStatus = variant['stockStatus'];

        if (name.isNotEmpty && price.isNotEmpty) {
          updatedVariants.add({
            "name": name,
            "price": double.parse(price),
            "stock": stockStatus,
          });
        }
      }

      FoodItemModel updatedModel = FoodItemModel(
        id: widget.product.id,
        // Ensure product ID is retained
        vendor: widget.product.vendor ?? 0,
        category: widget.product.category ?? 0,
        subcategory: widget.product.subcategory ?? 0,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        price: priceController.text.trim(),
        offer_price: offerPriceController.text.trim(),
        discount: discountController.text.trim(),
        is_available: _inStock,
        image_urls: _selectedImages != null
            ? _selectedImages!.map((file) => file.path).toList()
            : [],
        is_popular_product: _isPopular,
        is_offer_product: _isOffer,
        wholesale_price: wholeSaleController.text.trim(),
        variants: updatedVariants,
      );

      productProvider
          .editFoodItem(context: context, product: updatedModel)
          .then((res) {
        productProvider.getProductCategories(
          context: context,
          subCategoryId: widget.product.subcategory ?? 0,
        );
      });
    }
  }

// Function to add a new variant field
  void addVariant() {
    setState(() {
      variantFields.add({
        'nameController': TextEditingController(),
        'priceController': TextEditingController(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FbColors.backgroundcolor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: FbColors.backgroundcolor,
        title: const Text("Edit Product"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              FbCategoryFormField(
                label: "Product Name",
                controller: nameController,
                validator: customValidatornoSpaceError,
              ),
              FbCategoryFormField(
                label: "Description",
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

              // Toggle Switches
              const SizedBox(height: 20),
              FbToggleSwitch(
                title: 'Mark Product in Stock',
                initialValue: _inStock,
                onToggleChanged: (value) {
                  setState(() {
                    _inStock = value;
                  });
                },
              ),
              FbToggleSwitch(
                title: 'Is Offer Available',
                initialValue: _isOffer,
                onToggleChanged: (value) {
                  setState(() {
                    _isOffer = value;
                  });
                },
              ),
              FbToggleSwitch(
                title: 'Is Popular Product',
                initialValue: _isPopular,
                onToggleChanged: (value) {
                  setState(() {
                    _isPopular = value;
                  });
                },
              ),

              // Dynamic Variant Fields
              const SizedBox(height: 20),
              Column(
                children: List.generate(variantFields.length, (index) {
                  return Column(
                    children: [
                      // Variant Name
                      TextFormField(
                        controller: variantFields[index]['nameController'],
                        decoration: CustumInputDecoration.getDecoration(
                            labelText: "Variant Name (e.g. Half, Full)"),
                        validator: (value) =>
                            value!.isEmpty ? "Enter a variant name" : null,
                      ),
                      // Price
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: variantFields[index]['priceController'],
                        decoration: CustumInputDecoration.getDecoration(
                            labelText: "Price"),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Enter price" : null,
                      ),
                      // Quantity
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        value: variantFields[index]['stockStatus'],
                        decoration: CustumInputDecoration.getDecoration(
                            labelText: "Stock"),
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
                      SizedBox(
                        height: 5,
                      ),
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
              GestureDetector(
                onTap: addVariant,
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

              const SizedBox(height: 20),
              FbButton(
                onClick: updateProduct,
                label: "Update Product",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
