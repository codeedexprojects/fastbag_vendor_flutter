import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/placeholder.dart';
import 'package:fastbag_vendor_flutter/Commons/text_field_decortion.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/edit_fashion_product_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/product_edit_delete_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/product_fashion_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../Commons/fonts.dart';
import '../model/fashion_categoryby_subcategory.dart';
import '../model/fashion_sub_category_model.dart';
import '../view_model/fashion_product_view_model.dart';
import 'add_fashion_product.dart';

class FashionListProductsScreen extends StatefulWidget {
  final FashionSubCategoryModel subCategory;
  final FashionCategoryModel category;

  const FashionListProductsScreen({
    super.key,
    required this.subCategory,
    required this.category,
  });

  @override
  State<FashionListProductsScreen> createState() => _ListProductsScreenState();
}

class _ListProductsScreenState extends State<FashionListProductsScreen> {
  Map<int, bool> isExpandedMap = {}; // Track expanded state per item
  final FocusNode searchFocusNode = FocusNode();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final productProvider =
        Provider.of<FashionProductViewModel>(context, listen: false);
    productProvider.allproductPage = 1;
    productProvider.getAllProducts(subCategoryId: widget.subCategory.id ?? 0);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        productProvider.getAllProductLoading(
            subCategoryId: widget.subCategory.id ?? 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final FocusNode searchFocusNode = FocusNode();
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
            SizedBox(
              height: screenWidth * 0.15,
              child: TextFormField(
                  onTapOutside: (e) => searchFocusNode.unfocus(),
                  onTap: () {},
                  focusNode: searchFocusNode,
                  autofocus: false,
                  decoration: searchBarDecoration(hint: "Search Here")),
            ),
            Consumer<FashionProductViewModel>(builder: (context, data, _) {
              return productProvider.fashionProducts.isEmpty
                  ? Expanded(
                      child: SizedBox(
                          height: screenHeight * .6,
                          child: Center(
                              child: SizedBox(
                            height: screenWidth * .8,
                            width: screenWidth * .5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/no_product.svg',
                                  width: screenWidth * .3, // Set desired width
                                  // Set desired height
                                ),
                                SizedBox(
                                  height: screenHeight * .004,
                                ),
                                Text(
                                  "No Product Available",
                                  style: inter(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ))),
                    )
                  : Expanded(
                      child: SizedBox(
                      height: screenHeight * .15,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: productProvider.fashionProducts.length,
                        itemBuilder: (context, index) {
                          print("${productProvider.fashionProducts.length}");

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
                                  leading: SizedBox(
                                    height: screenHeight * .05,
                                    width: screenHeight * .06,
                                    child: (productProvider
                                                    .fashionProducts[index]
                                                    .images !=
                                                null &&
                                            productProvider
                                                .fashionProducts[index]
                                                .images!
                                                .isNotEmpty)
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: CachedNetworkImage(
                                              imageUrl: productProvider
                                                      .fashionProducts[index]
                                                      .images?[0]
                                                      .imageUrl ??
                                                  '',
                                              placeholder: (context, url) =>
                                                  Image.asset(PlaceholderImage
                                                      .placeholderimage),
                                              fit: BoxFit.cover,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          )
                                        : Image.asset(
                                            PlaceholderImage.placeholderimage),
                                  ),
                                  title: Text(productProvider
                                          .fashionProducts[index].name ??
                                      ''),
                                  subtitle: Text(productProvider
                                          .fashionProducts[index]
                                          .wholesalePrice ??
                                      ''),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Switch(
                                        value: productProvider
                                                .fashionProducts[index]
                                                .isActive ??
                                            false,
                                        activeColor: Colors.green,
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor: Colors.grey[300],
                                        trackOutlineColor:
                                            const WidgetStatePropertyAll(
                                                Colors.transparent),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onChanged: (value) {
                                          productProvider.enableDisdableProduct(
                                              context: context,
                                              productId: productProvider
                                                      .fashionProducts[index]
                                                      .id ??
                                                  0,
                                              isActive: !(productProvider
                                                      .fashionProducts[index]
                                                      .isActive ??
                                                  false));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ));
            }),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 15, vertical: 5),
              child: FbButton(
                  onClick: () {
                    navigate(
                        context: context,
                        screen: AddFashionProduct(
                          category: widget.category,
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
                          category: widget.category,
                          subCategory: widget.subCategory));
                },
                label: "Edit",
                icon: const FaIcon(
                  FontAwesomeIcons.penToSquare,
                  size: 17,
                ),
                color: Colors.white,
                textColor: Colors.blue,
                borderColor: Colors.blue,
              ),
            ),
            SizedBox(height: screenHeight * .02),
          ],
        ),
      ),
    );
  }
}
