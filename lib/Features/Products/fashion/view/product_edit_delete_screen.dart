import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/placeholder.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/edit_fashion_product_screen.dart';
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final fashionProductViewModel =
        Provider.of<FashionProductViewModel>(context);
    //final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          fashionProductViewModel.fashionProducts.isEmpty
              ? "Edit Sub Category Products"
              : 'Edit ${fashionProductViewModel.fashionProducts.first.category} Products',
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
                      leading: Container(
                        height: screenHeight * .05,
                        width: screenHeight * .06,
                        child: (fashionProductViewModel
                                        .fashionProducts[index].images !=
                                    null &&
                                fashionProductViewModel
                                    .fashionProducts[index].images!.isNotEmpty)
                            ? CachedNetworkImage(
                                imageUrl: fashionProductViewModel
                                        .fashionProducts[index]
                                        .images?[0]
                                        .imageUrl ??
                                    '',
                                placeholder: (context, url) => Image.asset(
                                    PlaceholderImage.placeholderimage),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            : Image.asset(PlaceholderImage.placeholderimage),
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
