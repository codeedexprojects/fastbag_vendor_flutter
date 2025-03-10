import 'dart:io';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
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

class EditProductScreen extends StatefulWidget {
  final FoodItemModel product;

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
    nameController.text = widget.product.name;
    descriptionController.text = widget.product.description;
    priceController.text = widget.product.price.toString();
    discountController.text = widget.product.discount.toString();
    wholeSaleController.text = widget.product.wholesale_price.toString();
    offerPriceController.text = widget.product.offer_price.toString();
    _inStock = widget.product.is_available;
    _isOffer = widget.product.is_offer_product;
    _isPopular = widget.product.is_popular_product;

    // Pre-fill variants
    for (var variant in widget.product.variants) {
      variantFields.add({
        'nameController': TextEditingController(text: variant.keys.first),
        'priceController':
            TextEditingController(text: variant.values.first['price'].toString()),
        'quantityController':
            TextEditingController(text: variant.values.first['quantity'].toString()),
        'stockStatus': variant.values.first['stock_status'],
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
        String quantity = variant['quantityController'].text.trim();
        String stockStatus = variant['stockStatus'];

        if (name.isNotEmpty && price.isNotEmpty && quantity.isNotEmpty) {
          updatedVariants.add({
            name: {
              "price": double.parse(price),
              "quantity": int.parse(quantity),
              "stock_status": stockStatus,
            }
          });
        }
      }

      FoodItemModel updatedModel = FoodItemModel(
        id: widget.product.id, // Ensure product ID is retained
        vendor: widget.product.vendor,
        category: widget.product.category,
        subcategory: widget.product.subcategory,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        price: priceController.text.trim(),
        offer_price: offerPriceController.text.trim(),
        discount: discountController.text.trim(),
        is_available: _inStock,
        image_urls: _selectedImages != null
            ? _selectedImages!.map((file) => file.path).toList()
            : widget.product.image_urls,
        is_popular_product: _isPopular,
        is_offer_product: _isOffer,
        wholesale_price: wholeSaleController.text.trim(),
        variants: updatedVariants,
      );

      productProvider.editFoodItem(context: context, product: updatedModel).then((res){
        //navigate(context: context, screen: const ListCategoryScreen());
      });
    }
  }

  // Function to add a new variant field
  void addVariant() {
    setState(() {
      variantFields.add({
        'nameController': TextEditingController(),
        'priceController': TextEditingController(),
        'quantityController': TextEditingController(),
        'stockStatus': 'in stock', // Default value
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
      appBar: AppBar(
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
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: variantFields[index]['nameController'],
                            decoration:
                                const InputDecoration(labelText: "Variant Name"),
                          ),
                          TextFormField(
                            controller: variantFields[index]['priceController'],
                            decoration: const InputDecoration(labelText: "Price"),
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                            controller: variantFields[index]['quantityController'],
                            decoration: const InputDecoration(labelText: "Quantity"),
                            keyboardType: TextInputType.number,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => removeVariant(index),
                              child: const Text("Remove",
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
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
