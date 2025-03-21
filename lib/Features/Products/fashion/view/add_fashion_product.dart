// import 'dart:io';
// import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/addproduct_model.dart';
// import 'package:fastbag_vendor_flutter/Features/Products/fashion/view_model/fashionproduct_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
// import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/productname_field.dart';
// import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/widget/select_field.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../Commons/colors.dart';
// import '../../../../Commons/fonts.dart';
// import '../../View/widgets/fb_products_file_picker.dart';
// import '../../View/widgets/fb_toggle_switch.dart';
//
// class AddFashionProduct extends StatefulWidget {
//   const AddFashionProduct({super.key});
//
//   @override
//   State<AddFashionProduct> createState() => _AddFashionProductState();
// }
//
// class _AddFashionProductState extends State<AddFashionProduct> {
//   var nameController = TextEditingController();
//   var descriptionController = TextEditingController();
//   var genderController = TextEditingController();
//   var stockUnitController = TextEditingController();
//   var priceController = TextEditingController();
//   var discountPriceController = TextEditingController();
//   var categoryController = TextEditingController();
//   var subcategoryController = TextEditingController();
//   var materialController=TextEditingController();
//   List<File>? _selectedImages;
//   var _formKey = GlobalKey<FormState>();
//   XFile? pickedImage;
//   bool _inStock = false;
//   List<Map<String, dynamic>> variants = [];
//
//   List<Map<String, dynamic>> variantFields = [];
//
//
//   void _onFilePicked(List<File> files) {
//     setState(() {
//       _selectedImages = files;
//     });
//   }
//
//   ////////////////////////////////////////////
//
//   void saveProduct() {
//     var productProvider = Provider.of<FashionProductViewModel>(context, listen: false);
//
//
//     // Convert variants to ColorsS list
//     for(var varient in variantFields){
//       String name = varient["color_name"].text.trim();
//       File? imageFile = varient["color_image"];
//       String imagePath = imageFile?.path ?? "";
//       String price = varient['price'].text.trim();
//       String size=varient["size"].selection.toString();
//       String stock= varient['stock'];
//       if(name.isNotEmpty&&imagePath.isNotEmpty){
//         variants.add({
//           name:{
//             "size":size,
//             "price":price,
//             "stock":int.tryParse(stock)
//           }
//         });
//       }
//     }
//
//     int? categoryId = int.tryParse(categoryController.selection.toString());
//     int? subcategoryId = int.tryParse(subcategoryController.selection.toString());
//     if (_formKey.currentState!.validate()) {
//       AddFashionProductModel model = AddFashionProductModel(
//         name: nameController.text.trim(),
//         description: descriptionController.text.trim(),
//         gender: genderController.selection.toString(),
//         material: materialController.text.trim(),
//         price: double.tryParse(priceController.text) ?? 0.0,
//         discount: double.tryParse(discountPriceController.text) ?? 0.0,
//         isActive: _inStock,
//         variants: variants, categoryId: categoryId, subcategoryId: subcategoryId,
//       );
//       productProvider.addFashionProduct(context: context, model: model);
//     }
//   }
//
//   void addVariant() {
//     setState(() {
//       variantFields.add({"color_name": TextEditingController, "color_image": [], "sizes":[]});
//     });
//   }
//
//   void removeVariant(int index) {
//     setState(() {
//       variants.removeAt(index);
//     });
//   }
//
//   void addSize(int variantIndex) {
//     setState(() {
//       variants[variantIndex]["sizes"]
//           .add({"size": "", "price": "", "stock": 0});
//     });
//   }
//
//   void removeSize(int variantIndex, int sizeIndex) {
//     setState(() {
//       variants[variantIndex]["sizes"].removeAt(sizeIndex);
//     });
//   }
//
//   Future<void> pickImage(int index) async {
//     pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         variants[index]["color_image"] = File(pickedImage!.path);
//       });
//     }
//   }
//
//   void submitVariants() {
//     final List<Map<String, dynamic>> formattedData = variants.map((variant) {
//       return {
//         "color_name": variant["color_name"],
//         "color_image":
//             variant["color_image"] != null ? variant["color_image"].path : "",
//         "sizes": variant["sizes"]
//             .map((size) => {
//                   "size": size["size"],
//                   "price": size["price"],
//                   "stock": size["stock"]
//                 })
//             .toList()
//       };
//     }).toList();
//     print(formattedData);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF5F5F5),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//         title: Text(
//           'Add Fashion Product',
//           style: mainFont(
//             fontsize: 16,
//             fontweight: FontWeight.w600,
//             color: FbColors.black,
//           ),
//         ),
//       ),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               ProductnameField(
//                 label: 'Product Name',
//                 controller: nameController,
//                 keyboard: TextInputType.text,
//               ),
//               ProductnameField(
//                 label: 'Describe the Product',
//                 controller: descriptionController,
//                 keyboard: TextInputType.text,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: screenWidth * .07, vertical: screenHeight * .01),
//                 child: SelectField(
//                     label: 'Select Gender',
//                     controller: genderController,
//                     items: ['M', 'F','U','K']),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: screenWidth * .07, vertical: screenHeight * .01),
//                 child: FbProductsFilePicker(
//                   fileCategory: "Product",
//                   onFilesPicked: _onFilePicked,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: screenWidth * .07, vertical: screenHeight * .01),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: SelectField(
//                           label: 'Category',
//                           controller: categoryController,
//                           items: ['Men', 'Women']),
//                     ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Expanded(
//                       child: SelectField(
//                           label: 'Sub Category',
//                           controller: subcategoryController,
//                           items: ['Shirts', 'Pants']),
//                     ),
//                   ],
//                 ),
//               ),
//               ProductnameField(
//                 label: 'Material',
//                 controller: materialController,
//                 keyboard: TextInputType.text,
//               ),
//
//               ProductnameField(
//                 label: 'Product Price (N)',
//                 controller: priceController,
//                 keyboard: TextInputType.number,
//               ),
//               ProductnameField(
//                 label: 'Discount Price (Optional)',
//                 controller: discountPriceController,
//                 keyboard: TextInputType.number,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: screenWidth * .07, vertical: screenHeight * .01),
//                 child: Row(
//                   children: [
//                     Text('Add Varient',
//                         style: normalFont4(
//                             fontsize: 18,
//                             fontweight: FontWeight.w400,
//                             color: Colors.blue)),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     GestureDetector(
//                       onTap: addVariant,
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.add,
//                             color: Colors.blue,
//                             size: 18,
//                           ),
//                           SizedBox(width: 5),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               for (int i = 0; i < variantFields.length; i++) _buildVariantSection(i),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: screenWidth * .07, vertical: screenHeight * .01),
//                 child: FbToggleSwitch(
//                   title: 'Mark Product in stock',
//                   initialValue: _inStock,
//                   onToggleChanged: (value) {
//                     setState(() {
//                       _inStock = value;
//                     });
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: screenWidth * .07, vertical: screenHeight * .01),
//                 child: FbButton(onClick: saveProduct, label: 'Add to Product'),
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildVariantSection(int index) {
//     final screenheight = MediaQuery.of(context).size.height;
//     final screenwidth = MediaQuery.of(context).size.width;
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           vertical: screenheight * .01, horizontal: screenwidth * .07),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildTextField("Color Name", true),
//           const SizedBox(height: 10),
//           _buildImagePicker(index),
//           const SizedBox(height: 10),
//           Column(
//             children: [
//               for (int j = 0; j < variants[index]["sizes"].length; j++)
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 8.0),
//                   child: _buildSizeRow(index, j),
//                 ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextButton.icon(
//                 onPressed: () => addSize(index),
//                 icon: const Icon(Icons.add, color: Colors.blue),
//                 label: const Text("Add Size",
//                     style: TextStyle(color: Colors.blue)),
//               ),
//               TextButton.icon(
//                 onPressed: () => removeVariant(index),
//                 icon: const Icon(Icons.delete, color: Colors.red),
//                 label: const Text("Remove Variant",
//                     style: TextStyle(color: Colors.red)),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSizeRow(int variantIndex, int sizeIndex) {
//     return Row(
//       children: [
//         Expanded(
//             child: _buildDropdown('Size', ["XS", "S", "M", "L", "Xl", "XXL"])),
//         SizedBox(width: 10),
//         Expanded(child: _buildTextField("Price", false)),
//         SizedBox(width: 10),
//         Expanded(child: _buildTextField("Stock", false)),
//         IconButton(
//           icon: Icon(Icons.delete, color: Colors.red),
//           onPressed: () => removeSize(variantIndex, sizeIndex),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTextField(String label, bool isSize) {
//     return TextFormField(
//       inputFormatters: [
//         if (!isSize) FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]+$')),
//       ],
//       keyboardType: (!isSize) ? TextInputType.phone : null,
//       decoration: InputDecoration(
//         hintText: label,
//         hintStyle: normalFont4(
//             fontsize: 14,
//             fontweight: FontWeight.w400,
//             color: Color.fromRGBO(26, 26, 26, 1)),
//         border: OutlineInputBorder(
//           borderSide: const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
//           borderRadius: BorderRadius.circular(
//             0,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
//           borderRadius: BorderRadius.circular(
//             0,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
//           borderRadius: BorderRadius.circular(
//             0,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDropdown(String label, List<String> items) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: DropdownButtonFormField(
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: normalFont4(
//               fontsize: 14,
//               fontweight: FontWeight.w400,
//               color: Color.fromRGBO(26, 26, 26, 1)),
//           border: OutlineInputBorder(
//             borderSide:
//                 const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
//             borderRadius: BorderRadius.circular(
//               0,
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide:
//                 const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
//             borderRadius: BorderRadius.circular(
//               0,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide:
//                 const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
//             borderRadius: BorderRadius.circular(
//               0,
//             ),
//           ),
//         ),
//         items: items.map((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//         onChanged: (value) {},
//       ),
//     );
//   }
//
//   Widget _buildImagePicker(int index) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Upload Color Image",
//           style: normalFont4(
//               fontsize: 14,
//               fontweight: FontWeight.w400,
//               color: Color.fromRGBO(26, 26, 26, 1)),
//         ),
//         const SizedBox(height: 8),
//         GestureDetector(
//           onTap: () => pickImage(index),
//           child: Container(
//             width: double.infinity,
//             height: 100,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               color: const Color(0xFFF5F5F5),
//             ),
//             child: variants[index]["color_image"] != null
//                 ? Image.file(
//                     variants[index]["color_image"],
//                     fit: BoxFit.cover,
//                   )
//                 : const Center(child: Icon(Icons.upload_file)),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'dart:io';
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

import '../../../../Commons/colors.dart';
import '../../../../Commons/fonts.dart';
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
  var discountPriceController = TextEditingController();
  var categoryController = TextEditingController();
  var subcategoryController = TextEditingController();
  var materialController = TextEditingController();

  List<File>? _selectedImages;
  XFile? pickedImage;
  bool _inStock = false;

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
      variants[variantIndex]["sizes"].add({
        "size": TextEditingController(), // ✅ Store controllers
        "price": TextEditingController(),
        "stock": TextEditingController(),
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

  void submitVariants() {
    var productProvider =
        Provider.of<FashionProductViewModel>(context, listen: false);

    final List<Map<String, dynamic>> formattedData = variants.map((variant) {
      return {
        "color_name": variant["color_name"].text, // ✅ Get text from controller
        "color_image":
            variant["color_image"] != null ? variant["color_image"].path : "",
        "sizes": variant["sizes"]
            .map((size) => {
                  "size": size["size"].text, // ✅ Get text from controller
                  "price": size["price"].text,
                  "stock": size["stock"].text
                })
            .toList()
      };
    }).toList();

    print(formattedData);

//    if (_formKey.currentState!.validate()) {
    AddFashionProductModel model = AddFashionProductModel(
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      gender: genderController.selection.toString(),
      material: materialController.text.trim(),
      price: priceController.text,
      discount: discountPriceController.text,
      isActive: _inStock,
      colors: formattedData,
      categoryId: selectedCategoryId,
      subcategoryId: selectedSubCategoryId,
    );
    productProvider.addFashionProduct(context: context, model: model);
    //}
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
                  items: ['M', 'F']),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .07, vertical: screenHeight * .01),
              child: FbProductsFilePicker(
                fileCategory: "Product",
                onFilesPicked: _onFilePicked,
              ),
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
                // Expanded(
                //   child: SelectField(
                //       label: 'Category',
                //       controller: categoryController,
                //       items: ['Men', 'Women']),
                // ),
                // SizedBox(
                //   width: 5,
                // ),
                // Expanded(
                //   child: SelectField(
                //       label: 'Sub Category',
                //       controller: subcategoryController,
                //       items: ['Shirts', 'Pants']),
                // ),
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
              label: 'Product Price (N)',
              controller: priceController,
              keyboard: TextInputType.number,
            ),
            ProductnameField(
              label: 'Discount Price (Optional)',
              controller: discountPriceController,
              keyboard: TextInputType.number,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .07, vertical: screenHeight * .01),
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
                  GestureDetector(
                    onTap: addVariant,
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.blue,
                          size: 18,
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                  ),
                ],
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
    return Row(
      children: [
        Expanded(
            child: _buildTextField(
          "Size",
          true,
          variants[variantIndex]["sizes"][sizeIndex]
              ["size"], // ✅ Now works correctly
        )),
        SizedBox(width: 10),
        Expanded(
            child: _buildTextField(
          "Price",
          false,
          variants[variantIndex]["sizes"][sizeIndex]["price"], // ✅ Corrected
        )),
        SizedBox(width: 10),
        Expanded(
            child: _buildTextField(
          "Stock",
          false,
          variants[variantIndex]["sizes"][sizeIndex]["stock"], // ✅ Corrected
        )),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => removeSize(variantIndex, sizeIndex),
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
