import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/category_request_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/list_categories.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/list_sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/productname_field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/select_field.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Commons/colors.dart';
import '../../../../Commons/fonts.dart';
import '../../../../storage/fb_local_storage.dart';
import '../../View/widgets/fb_products_file_picker.dart';
import '../../View/widgets/fb_toggle_switch.dart';
import '../model/addproduct_model.dart';
import '../view_model/fashionproduct_view_model.dart';

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
  var wholeSalePriceController = TextEditingController();
  var categoryController = TextEditingController();
  var subcategoryController = TextEditingController();
  var materialController = TextEditingController();
  List<File> selectedImages = [];
  List<File>? _selectedImages;
  File? imageFile;
  XFile? pickedImage;
  bool _inStock = true;

  int? selectedCategoryId;
  int? selectedSubCategoryId;

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
        "color_image": null,
        "sizes": []
      });
    });
  }

  void addSize(int variantIndex) {
    setState(() {
      variants[variantIndex]["sizes"] ??= [];

      variants[variantIndex]["sizes"].add({
        "size": TextEditingController(), // ✅ Store controller
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

  Future<void> pickImage(int index) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        variants[index]["color_image"] = File(pickedFile.path);
      });
    }
  }

  void submitVariants() async {
    var productProvider = Provider.of<FashionProductViewModel>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('access_token');
    var vendor = prefs.getInt(FbLocalStorage.vendorId);

    List<MultipartFile> imageFiles = await Future.wait(
      selectedImages.map((file) async => await MultipartFile.fromFile(file.path)),
    );

    final List<Map<String, dynamic>> formattedData = await Future.wait(
      variants.map((variant) async {
        return {
          "color_name": variant["color_name"].text,
          "color_image": variant["color_image"] != null
              ? await MultipartFile.fromFile(variant["color_image"].path)
              : null,
          "sizes": variant["sizes"].map((size) => {
            "size": size["size"].text,
            "price": size["price"].text,
            "stock": size["stock"].text,
            "offer_price": size["offer_price"].text
          }).toList(),
        };
      }),
    );

    // Prepare API request data
    var data = FormData.fromMap({
      'image_files': imageFiles, // Attach images
      "vendor": vendor,
      "category_id": selectedCategoryId,
      "subcategory_id": selectedSubCategoryId,
      "name": nameController.text,
      "description": descriptionController.text,
      "gender": genderController.text,
      "colors": formattedData, // ✅ No jsonEncode() here!
      "material": materialController.text,
      "is_active": _inStock,
      "wholesale_price": wholeSalePriceController.text,
    });

    // Call API function
    productProvider.addFashionProduct(
      context: context,
      model: data,
    );
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
        child: Column(
          children: [
            ProductnameField(
              label: 'Product Name',
              controller: nameController,
              keyboard: TextInputType.text,
            ),
            ProductnameField(
              label: 'Describe the Product',
              controller: descriptionController,
              keyboard: TextInputType.text,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .07, vertical: screenHeight * .01),
              child: SelectField(
                  label: 'Select Gender',
                  controller: genderController,
                  items: ['M', 'W', 'K', 'U']),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .07, vertical: screenHeight * .01),
              child: FbProductsFilePicker(
                  fileCategory: 'Product',
                  onFilesPicked: (List<File> files) {
                    setState(() {
                      selectedImages = files;
                    });
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: ProductnameField(
                    readOnly: true,
                    onTap: () async {
                      productProvider.categoryRequestModel =
                          (await Navigator.push<CategoryRequestModel>(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ListCategoriesName())));
                      selectedCategoryId =
                          productProvider.categoryRequestModel?.id;
                      categoryController.text =
                          productProvider.categoryRequestModel?.name ?? '';
                    },
                    label: 'Category',
                    controller: categoryController,
                    keyboard: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: ProductnameField(
                    readOnly: true,
                    onTap: () async {
                      productProvider.categoryRequestModel =
                          (await Navigator.push<CategoryRequestModel>(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ListSubcategoriesName())));
                      selectedSubCategoryId =
                          productProvider.categoryRequestModel?.id;
                      subcategoryController.text =
                          productProvider.categoryRequestModel?.name ?? '';
                    },
                    label: 'Sub Category',
                    controller: subcategoryController,
                    keyboard: TextInputType.number,
                  ),
                ),
              ],
            ),
            ProductnameField(
              label: 'Stock Unit',
              controller: stockUnitController,
              keyboard: TextInputType.number,
            ),
            ProductnameField(
              label: 'Material',
              controller: materialController,
              keyboard: TextInputType.text,
            ),
            ProductnameField(
              label: 'Wholesale Price (Optional)',
              controller: wholeSalePriceController,
              keyboard: TextInputType.number,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .07, vertical: screenHeight * .01),
              child: GestureDetector(
                onTap: addVariant,
                child: Row(
                  children: [
                    Text('Add Variant',
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
            for (int i = 0; i < variants.length; i++) _buildVariantSection(i),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .07, vertical: screenHeight * .01),
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
                  horizontal: screenWidth * .07, vertical: screenHeight * .01),
              child: FbButton(
                  onClick: () {
                    submitVariants();
                  },
                  label: 'Add to Product'),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildVariantSection(int index) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * .07, vertical: screenHeight * .01),
      child: Column(
        children: [
          _buildTextField("Color Name", true, variants[index]["color_name"]),
          _buildImagePicker(index),
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
      ),
    );
  }

  Widget _buildSizeRow(int variantIndex, int sizeIndex) {
    final sizes =
        variants[variantIndex]["sizes"] ?? []; // ✅ Ensure sizes is not null

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: _buildTextField("Size", true, sizes[sizeIndex]["size"])),
            SizedBox(width: 10),
            Expanded(
                child:
                    _buildTextField("Price", false, sizes[sizeIndex]["price"])),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => removeSize(variantIndex, sizeIndex),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
                child:
                    _buildTextField("Stock", false, sizes[sizeIndex]["stock"])),
            SizedBox(width: 10),
            Expanded(
                child: _buildTextField(
                    "Offer Price", false, sizes[sizeIndex]["offer_price"])),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => removeSize(variantIndex, sizeIndex),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(
      String label, bool isSize, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      inputFormatters: [
        if (!isSize) FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]+$')),
      ],
      keyboardType: (!isSize) ? TextInputType.phone : null,
      onChanged: (value) {
        setState(() {}); // ✅ Update UI when user types
      },
      decoration: InputDecoration(
        hintText: label,
        hintStyle: normalFont4(
            fontsize: 14,
            fontweight: FontWeight.w400,
            color: Color.fromRGBO(26, 26, 26, 1)),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
          borderRadius: BorderRadius.circular(
            0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
          borderRadius: BorderRadius.circular(
            0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
          borderRadius: BorderRadius.circular(
            0,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: normalFont4(
              fontsize: 14,
              fontweight: FontWeight.w400,
              color: Color.fromRGBO(26, 26, 26, 1)),
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
            borderRadius: BorderRadius.circular(
              0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
            borderRadius: BorderRadius.circular(
              0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
            borderRadius: BorderRadius.circular(
              0,
            ),
          ),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildImagePicker(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upload Color Image",
          style: normalFont4(
              fontsize: 14,
              fontweight: FontWeight.w400,
              color: Color.fromRGBO(26, 26, 26, 1)),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => pickImage(index),
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: const Color(0xFFF5F5F5),
            ),
            child: variants[index]["color_image"] != null
                ? Image.file(
                    variants[index]["color_image"],
                    fit: BoxFit.cover,
                  )
                : const Center(child: Icon(Icons.upload_file)),
          ),
        ),
      ],
    );
  }
}
