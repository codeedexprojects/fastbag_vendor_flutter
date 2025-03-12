import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/productname_field.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/select_field.dart';
import 'package:flutter/services.dart';
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
  XFile? pickedImage;
  bool _inStock = false;

  List<Map<String, dynamic>> sizeRules =
      []; // List to store size & color variants

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
      variants.add({"color_name": "", "color_image": null, "sizes": []});
    });
  }

  void removeVariant(int index) {
    setState(() {
      variants.removeAt(index);
    });
  }

  void addSize(int variantIndex) {
    setState(() {
      variants[variantIndex]["sizes"]
          .add({"size": "", "price": "", "stock": ""});
    });
  }

  void removeSize(int variantIndex, int sizeIndex) {
    setState(() {
      variants[variantIndex]["sizes"].removeAt(sizeIndex);
    });
  }

  Future<void> pickImage(int index) async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        variants[index]["color_image"] = File(pickedImage!.path);
      });
    }
  }

  void submitVariants() {
    final List<Map<String, dynamic>> formattedData = variants.map((variant) {
      return {
        "color_name": variant["color_name"],
        "color_image":
            variant["color_image"] != null ? variant["color_image"].path : "",
        "sizes": variant["sizes"]
            .map((size) => {
                  "size": size["size"],
                  "price": size["price"],
                  "stock": size["stock"]
                })
            .toList()
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
            ProductnameField(
                label: 'Describe the Product',
                controller: descriptionController),
            SelectField(
                label: 'Select Gender',
                controller: genderController,
                items: ['Male', 'Female']),
            FbProductsFilePicker(
              fileCategory: "Product",
              onFilesPicked: _onFilePicked,
            ),
            Row(
              children: [
                Expanded(
                  child: SelectField(
                      label: 'Category',
                      controller: categoryController,
                      items: ['Men', 'Women']),
                ),
                Expanded(
                  child: SelectField(
                      label: 'Sub Category',
                      controller: subcategoryController,
                      items: ['Shirts', 'Pants']),
                ),
              ],
            ),
            ProductnameField(
                label: 'Stock Unit', controller: stockUnitController),
            ProductnameField(
                label: 'Product Price (N)', controller: priceController),
            ProductnameField(
                label: 'Discount Price (Optional)',
                controller: discountPriceController),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .07, vertical: screenHeight * .01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Varient',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: addVariant,
                    child: Row(
                      children: const [
                        Icon(Icons.add, color: Colors.blue),
                        SizedBox(width: 5),
                        Text('Add', style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            for (int i = 0; i < variants.length; i++) _buildVariantSection(i),
            FbToggleSwitch(
              title: 'Mark Product in stock',
              initialValue: _inStock,
              onToggleChanged: (value) {
                setState(() {
                  _inStock = value;
                });
              },
            ),
            FbButton(onClick: () {}, label: 'Add to Product'),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildVariantSection(int index) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField("Color Name", true),
          const SizedBox(height: 10),
          _buildImagePicker(index),
          const SizedBox(height: 10),
          Column(
            children: [
              for (int j = 0; j < variants[index]["sizes"].length; j++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _buildSizeRow(index, j),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () => addSize(index),
                icon: const Icon(Icons.add, color: Colors.blue),
                label: const Text("Add Size", style: TextStyle(color: Colors.blue)),
              ),
              TextButton.icon(
                onPressed: () => removeVariant(index),
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text("Remove Variant", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSizeRow(int variantIndex, int sizeIndex) {
    return Row(
      children: [
        Expanded(child: _buildTextField("Size",true)),
        SizedBox(width: 10),
        Expanded(child: _buildTextField("Price",false)),
        SizedBox(width: 10),
        Expanded(child: _buildTextField("Stock",false)),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => removeSize(variantIndex, sizeIndex),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, bool isSize) {
    return TextFormField(
      inputFormatters: [
        if (!isSize) FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]+$')),
      ],
      keyboardType: (!isSize) ? TextInputType.phone : null,
      decoration: InputDecoration(
        hintText: label,
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

  Widget _buildDropdown(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        decoration:
            InputDecoration(labelText: label, border: OutlineInputBorder()),
        items: [DropdownMenuItem(value: label, child: Text(label))],
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildImagePicker(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Upload Color Image"),
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
      ),
    );
  }
}
