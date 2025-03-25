import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/placeholder.dart';
import 'package:fastbag_vendor_flutter/Commons/text_field_decortion.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/add_product_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/product_detail_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/product_edit_delete_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Model/food_categoryby_subCategory_model.dart';

class ListProductsScreen extends StatefulWidget {
  final FoodCategoryBySubcategoryModel subCategorys;
  final List<FoodCategoryBySubcategoryModel> subCategoriess;

  const ListProductsScreen(
      {super.key, required this.subCategorys, required this.subCategoriess});

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
        context: context, subCategoryId: widget.subCategorys.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final productProvider =
        Provider.of<ProductViewModel>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(247, 253, 247, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.08),
            SizedBox(
              height: screenWidth * 0.15,
              child: TextField(
                autofocus: false,
                  decoration: searchBarDecoration(hint: "Search Here")),
            ),
            Consumer<ProductViewModel>(builder: (context, data, _) {
              return productProvider.foodProducts.isEmpty
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
                                            fit: BoxFit.fill,
                                            image: NetworkImage(productProvider
                                                    .foodProducts[index]
                                                    .imageUrls?[0]
                                                    .image ??
                                                ''),
                                          ),
                                          border: Border.all(
                                              color: Colors.grey, width: 0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          imageUrl: productProvider
                                                  .foodProducts[index]
                                                  .imageUrls?[0]
                                                  .image ??
                                              '',
                                          placeholder: (context, url) =>
                                              Image.asset(PlaceholderImage
                                                  .placeholderimage),
                                        ),
                                      ),
                                    ),
                                    title: Text(productProvider
                                            .foodProducts[index].name ??
                                        ''),
                                    subtitle: Text(
                                        '₹${productProvider.foodProducts[index].price ?? 0}'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Switch(
                                          activeColor: Colors.green,
                                          inactiveThumbColor: Colors.white,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          value: productProvider
                                                  .foodProducts[index]
                                                  .isAvailable ??
                                              false,
                                          onChanged: (value) {
                                            // Handle switch toggle logic
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
                      ),
                    );
            }),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .07, vertical: .01),
              child: FbButton(
                  onClick: () {
                    navigate(
                        context: context,
                        screen: AddProductScreen(
                          subCategories: widget.subCategoriess,
                          subCategory: widget.subCategorys,
                        ));
                  },
                  label: "+ Add Product"),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .07, vertical: .01),
              child: FbButton(
                onClick: () {
                  navigate(
                      context: context,
                      screen: ProductEditDeleteScreen(
                          products: productProvider.foodProducts));
                },
                label: "Edit",
                icon: const FaIcon(
                  FontAwesomeIcons.penToSquare,
                  size: 20,
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
