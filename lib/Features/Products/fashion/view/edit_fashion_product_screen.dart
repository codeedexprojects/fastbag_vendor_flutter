import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_drop_down.dart';
import 'package:fastbag_vendor_flutter/Commons/flush_bar.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_form_field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_products_file_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_toggle_switch.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/category_request_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/color_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/color_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/list_categories.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/list_sub_categories.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view_model/fashion_product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../model/fashion_item_model.dart' as fashion_model;

class EditFashionProductScreen extends StatefulWidget {
  final fashion_model.Results product;
  final FashionCategoryModel category;
  final FashionSubCategoryModel subCategory;

  const EditFashionProductScreen(
      {super.key,
      required this.product,
      required this.category,
      required this.subCategory});

  @override
  State<EditFashionProductScreen> createState() =>
      _EditFashionProductScreenState();
}

class _EditFashionProductScreenState extends State<EditFashionProductScreen> {
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var wholeSalePriceController = TextEditingController();
  var categoryController = TextEditingController();
  var subcategoryController = TextEditingController();
  var materialController = TextEditingController();
  List<File> selectedImages = [];
  String? selectedGender;
  bool _inStock = true;
  int? selectedCategoryId;
  int? selectedSubCategoryId;
  final List<Map<String, dynamic>> variants = [];

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    final product = widget.product;

    // Initialize basic fields
    nameController.text = product.name ?? '';
    descriptionController.text = product.description ?? '';
    priceController.text = product.price.toString();
    selectedGender = product.gender;
    materialController.text = product.material ?? '';
    _inStock = product.isActive ?? false;
    wholeSalePriceController.text = product.wholesalePrice?.toString() ?? '';
    categoryController.text = widget.category.name ?? '';
    subcategoryController.text = widget.subCategory.name ?? '';
    selectedCategoryId = widget.category.id;
    selectedSubCategoryId = widget.subCategory.id;

    // Initialize variants
    variants.addAll(product.colors!.map((color) {
      return {
        "color_name": TextEditingController(text: color.colorName),
        "color_code": TextEditingController(text: color.colorCode),
        "sizes": color.sizes!.map((size) {
          return {
            "selectedSize": size.size,
            "price": TextEditingController(text: size.price.toString()),
            "stock": TextEditingController(text: size.stock.toString()),
            "offer_price":
                TextEditingController(text: size.offerPrice.toString()),
          };
        }).toList(),
      };
    }));
  }

  void submitVariants() async {
    final productProvider =
        Provider.of<FashionProductViewModel>(context, listen: false);

    final formattedData = variants.map((variant) {
      return {
        "color_name": variant["color_name"].text,
        "color_code": variant["color_code"].text,
        "sizes": variant["sizes"]
            .map((size) => {
                  "size": size["selectedSize"],
                  "price": double.parse(size["price"].text),
                  "stock": int.parse(size["stock"].text),
                  "offer_price": double.parse(size["offer_price"].text),
                })
            .toList(),
      };
    }).toList();

    final data = {
      "name": nameController.text,
      "description": descriptionController.text,
      "gender": selectedGender,
      "price": double.parse(priceController.text),
      "category_id": selectedCategoryId,
      "subcategory_id": selectedSubCategoryId,
      "colors": formattedData,
      "material": materialController.text,
      "is_active": _inStock,
      "wholesale_price": wholeSalePriceController.text.isNotEmpty
          ? double.tryParse(wholeSalePriceController.text)
          : null,
    };

    final imageData = {
      "image_files": await Future.wait(
        selectedImages
            .map((file) async => await MultipartFile.fromFile(file.path)),
      ),
    };
    print(formattedData);
    if (_formKey.currentState!.validate()) {
      if (widget.product.images!.isEmpty && selectedImages.isEmpty) {
        showFlushbar(
            context: context,
            color: Colors.red,
            icon: Icons.error_outline,
            message: 'No Image Selected');
      } else {
        productProvider.editProduct(
          context: context,
          productId: widget.product.id,
          data: data,
          imageData: selectedImages.isNotEmpty ? imageData : null,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<FashionProductViewModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFFF5F5F5),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Edit Fashion Product',
          style: poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
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
                validator: customValidatornoSpaceError,
              ),
              FbCategoryFormField(
                label: 'Description',
                controller: descriptionController,
                validator: customValidatornoSpaceError,
              ),
              FbCustomDropdown(
                hintText: 'Select Gender',
                value: selectedGender,
                items: const ['M', 'W', 'K', 'U'],
                onChanged: (value) => setState(() => selectedGender = value),
              ),
              FbProductsFilePicker(
                images: widget.product.images ?? [],
                onImageRemove: (index) => setState(() {
                  productProvider.deleteProductImage(
                      context: context,
                      productId: widget.product.id!,
                      imageId: widget.product.images![index].id!);
                }),
                fileCategory: 'Product',
                onFilesPicked: (files) =>
                    setState(() => selectedImages = files),
              ),
              Row(
                children: [
                  Expanded(
                    child: FbCategoryFormField(
                      readOnly: true,
                      onTap: () async {
                        final category =
                            await Navigator.push<CategoryRequestModel>(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ListCategoriesName()),
                        );
                        if (category != null) {
                          setState(() {
                            selectedCategoryId = category.id;
                            categoryController.text = category.name!;
                            subcategoryController.text = '';
                            selectedSubCategoryId = null;
                          });
                        }
                      },
                      label: 'Category',
                      controller: categoryController,
                      validator: customValidatornoSpaceError,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FbCategoryFormField(
                      readOnly: true,
                      onTap: () async {
                        final subCategory =
                            await Navigator.push<CategoryRequestModel>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ListSubcategoriesName(
                              subcategoryId: selectedCategoryId,
                            ),
                          ),
                        );
                        if (subCategory != null) {
                          setState(() {
                            selectedSubCategoryId = subCategory.id;
                            subcategoryController.text = subCategory.name!;
                          });
                        }
                      },
                      label: 'Sub Category',
                      controller: subcategoryController,
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
                label: 'Material',
                controller: materialController,
                validator: customValidatornoSpaceError,
              ),
              FbCategoryFormField(
                label: 'Wholesale Price',
                controller: wholeSalePriceController,
                keyboard: TextInputType.number,
                validator: priceValidator,
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
                onTap: () => setState(() => variants.add({
                      "color_name": TextEditingController(),
                      "color_code": TextEditingController(),
                      "sizes": []
                    })),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Add Variant', style: TextStyle(color: Colors.blue)),
                      Icon(Icons.add, color: Colors.blue, size: 18),
                    ],
                  ),
                ),
              ),
              FbToggleSwitch(
                title: 'Mark Product in stock',
                initialValue: _inStock,
                onToggleChanged: (value) => setState(() => _inStock = value),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: FbButton(
                  onClick: submitVariants,
                  label: 'Update Product',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVariantSection(int index, FashionProductViewModel provider) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FbCategoryFormField(
                label: 'Color Name',
                controller: variants[index]["color_name"],
                onTap: () async => _onColorTap(provider, index),
              ),
            ),
            if (provider.colorPicker?.colorCode != null) ...[
              const SizedBox(width: 10),
              Expanded(
                child: FbCategoryFormField(
                  label: 'Color Code',
                  controller: variants[index]["color_code"],
                ),
              )
            ]
          ],
        ),
        for (int j = 0; j < variants[index]["sizes"].length; j++)
          _buildSizeRow(index, j),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => setState(() => variants[index]["sizes"].add({
                    "selectedSize": '',
                    "price": TextEditingController(),
                    "stock": TextEditingController(),
                    "offer_price": TextEditingController(),
                  })),
              child: const Text('+ Add Size',
                  style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () => setState(() => variants.removeAt(index)),
              child: const Text('Remove Variant',
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSizeRow(int variantIndex, int sizeIndex) {
    final sizes = variants[variantIndex]["sizes"];
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
                        onChanged: (value) => setState(
                            () => sizes[sizeIndex]["selectedSize"] = value),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FbCategoryFormField(
                        label: 'Price',
                        controller: sizes[sizeIndex]["price"],
                        keyboard: TextInputType.number,
                        validator: priceValidator,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: FbCategoryFormField(
                        label: 'Stock',
                        controller: sizes[sizeIndex]["stock"],
                        keyboard: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: customValidatornoSpaceError,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FbCategoryFormField(
                        label: 'Offer Price',
                        controller: sizes[sizeIndex]["offer_price"],
                        keyboard: TextInputType.number,
                        validator: priceValidator,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => setState(() => sizes.removeAt(sizeIndex)),
          ),
        ],
      ),
    );
  }

  void _onColorTap(FashionProductViewModel provider, int index) async {
    provider.colorPicker = await Navigator.push<ColorPickerModel>(
      context,
      MaterialPageRoute(builder: (_) => ColorPickerScreen()),
    );
    if (provider.colorPicker != null) {
      setState(() {
        variants[index]["color_name"].text = provider.colorPicker!.colorName;
        variants[index]["color_code"].text = provider.colorPicker!.colorCode;
      });
    }
  }
}
