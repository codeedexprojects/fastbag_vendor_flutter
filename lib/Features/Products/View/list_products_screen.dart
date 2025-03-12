import 'dart:io';

import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/text_field_decortion.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/add_product_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/product_detail_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/product_edit_delete_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ListProductsScreen extends StatefulWidget {
  final SubCategoryModel subCategory;
  final List<SubCategoryModel> subCategories;
  const ListProductsScreen(
      {super.key, required this.subCategory, required this.subCategories});

  @override
  State<ListProductsScreen> createState() => _ListProductsScreenState();
}

class _ListProductsScreenState extends State<ListProductsScreen> {
  Map<int, bool> isExpandedMap = {}; // Track expanded state per item

  @override
  void initState() {
    super.initState();
    final productProvider =
        Provider.of<ProductViewModel>(context, listen: false);
    productProvider.getProductCategories(
        context: context, subCategoryId: widget.subCategory.id as int);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final productProvider =
        Provider.of<ProductViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 253, 247, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.08),
            Row(
              children: [
                SizedBox(
                  height: screenWidth * 0.15,
                  width: screenWidth * 0.8,
                  child: TextField(
                      decoration: searchBarDecoration(hint: "Search Here")),
                ),
                const Icon(Icons.more_vert)
              ],
            ),
            Consumer<ProductViewModel>(builder: (context, data, _) {
              return productProvider.foodProducts.isEmpty
                  ? SizedBox(
                      height: screenHeight * .6,
                      child: Center(
                          child: SizedBox(
                        height: screenWidth * .45,
                        width: screenWidth * .5,
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/no_product.svg',
                              width: screenWidth * .45, // Set desired width
                              height: screenWidth * .3, // Set desired height
                            ),
                            SizedBox(
                              height: screenHeight * .004,
                            ),
                            const Text("Nothing to show yet. Created"),
                            const Text("Product list will appear here")
                          ],
                        ),
                      )))
                  : SizedBox(
                      height: screenHeight * .6,
                      child: ListView.builder(
                        itemCount: productProvider.foodProducts.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  navigate(
                                      context: context,
                                      screen: ProductDetailScreen(
                                        productId: productProvider
                                                .foodProducts[index].id ??
                                            0,
                                      ));
                                },
                                child: ListTile(
                                  leading: Container(
                                    height: screenHeight * .05,
                                    width: screenHeight * .06,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(productProvider
                                            .foodProducts[index].image_urls[0]),
                                      ),
                                      border: Border.all(
                                          color: Colors.grey, width: 0.2),
                                    ),
                                  ),
                                  title: Text(
                                      productProvider.foodProducts[index].name),
                                  subtitle: Text(productProvider
                                      .foodProducts[index].price),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Switch(
                                        activeColor: Colors.green,
                                        inactiveThumbColor: Colors.white,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        value: false,
                                        onChanged: (value) {
                                          // Handle switch toggle logic
                                        },
                                      ),
                                    ],
                                  ),
                                  // trailing: Switch(
                                  //             activeColor: Colors.green,
                                  //             inactiveThumbColor: Colors.white,
                                  //             materialTapTargetSize:
                                  //                 MaterialTapTargetSize
                                  //                     .shrinkWrap,
                                  //             value: false,
                                  //             onChanged: (value) {
                                  //               // Handle switch toggle logic
                                  //             },
                                  //           ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
            }),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 15, vertical: 5),
              child: FbButton(
                  onClick: () {
                    navigate(
                        context: context,
                        screen: AddProductScreen(
                          subCategories: widget.subCategories,
                          subCategory: widget.subCategory,
                        ));
                  },
                  label: "+ Add Product"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 15, vertical: 5),
              child: FbButton(
                onClick: () {
                  navigate(
                      context: context,
                      screen: ProductEditDeleteScreen(
                          products: productProvider.foodProducts));
                },
                label: "Export",
                icon: const FaIcon(
                  FontAwesomeIcons.arrowUpFromBracket,
                  size: 17,
                ),
                color: Colors.white,
                textColor: Colors.green,
                borderColor: Colors.green,
              ),
            ),
            SizedBox(height: screenHeight * .02),
          ],
        ),
      ),
    );
  }
}


class AddVariantScreen extends StatefulWidget {
  @override
  _AddVariantScreenState createState() => _AddVariantScreenState();
}

class _AddVariantScreenState extends State<AddVariantScreen> {
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
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Information Fields
            _buildTextField("Product Name"),
            _buildTextField("Describe the Product"),
            _buildDropdown("Select Gender"),
            _buildImagePicker("Upload Product Image", () {}),
            _buildDropdown("Category"),
            _buildDropdown("Sub Category"),
            _buildTextField("Stock Unit"),
            _buildTextField("Product Price"),
            _buildTextField("Discount Price (Optional)"),
            const SizedBox(height: 16),

            // Variants Section
            for (int i = 0; i < variants.length; i++)
              _buildVariantSection(i),

            // Add Variant Button
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: addVariant,
                child: Text("+ Add Variant"),
              ),
            ),

            const SizedBox(height: 20),

            // Submit Button
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: submitVariants,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text("Add to Product"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      ),
    );
  }

  Widget _buildDropdown(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        items: [DropdownMenuItem(value: label, child: Text(label))],
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildImagePicker(String label, VoidCallback onPick) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          SizedBox(height: 8),
          GestureDetector(
            onTap: onPick,
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Center(child: Icon(Icons.upload_file)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariantSection(int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Color Name"),
            _buildImagePicker("Upload Color Image", () => pickImage(index)),
            for (int j = 0; j < variants[index]["sizes"].length; j++)
              _buildSizeRow(index, j),
            TextButton(
              onPressed: () => addSize(index),
              child: Text("+ Add Size"),
            ),
            TextButton(
              onPressed: () => removeVariant(index),
              child: Text("Remove Variant", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeRow(int variantIndex, int sizeIndex) {
    return Row(
      children: [
        Expanded(child: _buildTextField("Size")),
        Expanded(child: _buildTextField("Price")),
        Expanded(child: _buildTextField("Stock")),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => removeSize(variantIndex, sizeIndex),
        ),
      ],
    );
  }
}