import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/edit_fashion_product_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view_model/fashion_category_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view_model/fashionproduct_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductEditDeleteScreen extends StatefulWidget {
  // final List<FashionSubCategoryModel> subCategories;
  // final List<FashionCategoryModel> categories;

  final FashionCategoryModel category;
  final FashionSubCategoryModel subCategory;

  const ProductEditDeleteScreen({
    super.key,
    required this.category,
    required this.subCategory,
  });

  @override
  State<ProductEditDeleteScreen> createState() =>
      _ProductEditDeleteScreenState();
}

class _ProductEditDeleteScreenState extends State<ProductEditDeleteScreen> {
  void initState() {
    final fashionProductViewModel =
        Provider.of<FashionProductViewModel>(context, listen: false);
    fashionProductViewModel.getFashionProductCategories(
        subCategoryId: widget.subCategory.id ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fashionProductViewModel =
        Provider.of<FashionProductViewModel>(context);
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          fashionProductViewModel.fashionProducts.isEmpty
              ? "Edit Products"
              : 'Edit ${fashionProductViewModel.fashionProducts.first.category} SubCategories',
          style: mainFont(
              fontsize: screenWidth * 0.04,
              fontweight: FontWeight.w500,
              color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * .05),
        child: ListView.builder(
            itemCount: fashionProductViewModel.fashionProducts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(screenWidth * .02),
                child: InkWell(
                  onTap: () {
                    navigate(
                        context: context,
                        screen: EditFashionProductScreen(
                          category: widget.category,
                          subCategory: widget.subCategory,
                          product:
                              fashionProductViewModel.fashionProducts[index],
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * .02),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 32,
                        backgroundColor:
                            Colors.grey[200], // Optional: Background color
                        child: ClipOval(
                          child: Image.network(
                            fashionProductViewModel
                                .fashionProducts[index].images!.first.image
                                .toString(),
                            fit: BoxFit
                                .cover, // Ensures the image fills the circle
                            width:
                                64, // Diameter of the CircleAvatar (radius * 2)
                            height:
                                64, // Diameter of the CircleAvatar (radius * 2)
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error,
                                  color: Colors
                                      .red); // Optional: Handle loading errors
                            },
                          ),
                        ),
                      ),
                      title: Text(fashionProductViewModel
                          .fashionProducts[index].name
                          .toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                              onTap: () => navigate(
                                  context: context,
                                  screen: EditFashionProductScreen(
                                    category: widget.category,
                                    subCategory: widget.subCategory,
                                    product: fashionProductViewModel
                                        .fashionProducts[index],
                                  )),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.blueAccent,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                fashionProductViewModel.deleteProduct(
                                    context: context,
                                    productId: fashionProductViewModel
                                        .fashionProducts[index].id!);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
