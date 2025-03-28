import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/placeholder.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/edit_fashion_product_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view_model/fashion_product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../Commons/flush_bar.dart';

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
  ScrollController _scrollController = ScrollController();
  late FashionProductViewModel fashionViewModel = FashionProductViewModel();

  @override
  void initState() {
    super.initState();
    fashionViewModel =
        Provider.of<FashionProductViewModel>(context, listen: false);
    fashionViewModel.allproductPage = 1;
    fashionViewModel.getAllProducts(subCategoryId: widget.subCategory.id ?? 0);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fashionViewModel.getAllProductLoading(
            subCategoryId: widget.subCategory.id ?? 0);
      }
    });
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
        backgroundColor: FbColors.backgroundcolor,
        scrolledUnderElevation: 0,
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
        child: fashionProductViewModel.fashionProducts.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/no_product.svg',
                      width: screenWidth * .45, // Set desired width
                      height: screenWidth * .3, // Set desired height
                    ),
                    Text(
                      'No Products Available',
                      style: inter(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                controller: _scrollController,
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
                              product: fashionProductViewModel
                                  .fashionProducts[index],
                            ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * .02),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 0.5)),
                        child: ListTile(
                          leading: Container(
                            height: screenHeight * .05,
                            width: screenHeight * .06,
                            child: (fashionProductViewModel
                                            .fashionProducts[index].images !=
                                        null &&
                                    fashionProductViewModel
                                        .fashionProducts[index]
                                        .images!
                                        .isNotEmpty)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: fashionProductViewModel
                                              .fashionProducts[index]
                                              .images?[0]
                                              .imageUrl ??
                                          '',
                                      placeholder: (context, url) =>
                                          Image.asset(PlaceholderImage
                                              .placeholderimage),
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  )
                                : Image.asset(
                                    PlaceholderImage.placeholderimage),
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
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:  Text("Confirm Deletion"),
                                        content: const Text("Are you sure you want to delete this product?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {

                                              fashionProductViewModel.deleteProduct(
                                                context: context,
                                                productId: fashionProductViewModel.fashionProducts[index].id!,
                                              );
                                            },
                                            child: const Text("Delete", style: TextStyle(color: Colors.red)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),

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
