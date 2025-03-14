import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/placeholder.dart';
import 'package:fastbag_vendor_flutter/Commons/text_field_decortion.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/add_product_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/product_detail_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/product_edit_delete_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/product_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/product_fashion_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../model/fashion_sub_category_model.dart';
import '../view_model/fashionproduct_view_model.dart';
import 'add_fashion_product.dart';

class FashionListProductsScreen extends StatefulWidget {
  final FashionSubCategoryModel? subCategory;

  final List<FashionSubCategoryModel?> subCategories;

  const FashionListProductsScreen({
    super.key,
    required this.subCategory,
    required this.subCategories,
  });

  @override
  State<FashionListProductsScreen> createState() => _ListProductsScreenState();
}

class _ListProductsScreenState extends State<FashionListProductsScreen> {
  Map<int, bool> isExpandedMap = {}; // Track expanded state per item

  @override
  void initState() {
    super.initState();
    final productProvider =
        Provider.of<FashionProductViewModel>(context, listen: false);
    productProvider.getFashionProductCategories(
        subCategoryId: widget.subCategory?.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final productProvider = Provider.of<FashionProductViewModel>(
      context,
    );

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
            Consumer<FashionProductViewModel>(builder: (context, data, _) {
              return productProvider.fashionProducts.isEmpty
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
                        itemCount: productProvider.fashionProducts.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  navigate(
                                      context: context,
                                      screen: FashionProductDetailScreen(
                                        productId: productProvider
                                                .fashionProducts[index].id ??
                                            0,
                                      ));
                                },
                                child: ListTile(
                                  leading: Container(
                                    height: screenHeight * .05,
                                    width: screenHeight * .06,
                                    child: (productProvider
                                                    .fashionProducts[index]
                                                    ?.images !=
                                                null &&
                                            productProvider
                                                .fashionProducts[index]!
                                                .images!
                                                .isNotEmpty)
                                        ? CachedNetworkImage(
                                            imageUrl: productProvider
                                                    .fashionProducts[index]
                                                    ?.images?[0]
                                                    .imageUrl ??
                                                '',
                                            placeholder: (context, url) =>
                                                Image.asset(PlaceholderImage.placeholderimage),
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          )
                                        : Image.asset(
                                            'assets/profileicon/shop.png'),
                                  ),
                                  title: Text(productProvider
                                          .fashionProducts[index]?.name ??
                                      ''),
                                  subtitle: Text(productProvider
                                          .fashionProducts[index]?.price ??
                                      ''),
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
                        screen: AddFashionProduct(
                            // subCategories: widget.subCategories,
                            // subCategory: widget.subCategory,
                            ));
                  },
                  label: "+ Add Product"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 15, vertical: 5),
              child: FbButton(
                onClick: () {
                  // navigate(
                  //     context: context,
                  //     screen: ProductEditDeleteScreen(
                  //         products: productProvider.foodProducts));
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
