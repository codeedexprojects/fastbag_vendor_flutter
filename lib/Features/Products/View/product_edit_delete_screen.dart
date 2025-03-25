import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_item_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_response.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/edit_product_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../fashion/view_model/fashion_product_view_model.dart';

class ProductEditDeleteScreen extends StatelessWidget {
  final List<FoodResponseModel> products;

  const ProductEditDeleteScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final productProvider =
        Provider.of<FashionProductViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: FbColors.backgroundcolor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: FbColors.backgroundcolor,
        title: Text(
          "Edit Product Screen",
          style: mainFont(
              fontsize: screenWidth * 0.05,
              fontweight: FontWeight.w500,
              color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * .05),
        child: Consumer<ProductViewModel>(builder: (context, data, _) {
          return data.foodProducts.isEmpty
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
                  itemCount: data.foodProducts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(screenWidth * .02),
                      child: InkWell(
                        onTap: () {
                          //navigate(context: context, screen: EditSubCategoryScreen(categories: categories, category: categories[0],subCategory: subCategories[index],));
                        },
                        child: Container(
                          padding: EdgeInsets.all(screenWidth * .02),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.grey, width: 0.5)),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors
                                  .grey[200], // Optional: Background color
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    data.foodProducts[index].imageUrls?[0]
                                            .image ??
                                        '',
                                    fit: BoxFit
                                        .fill, // Ensures the image fills the circle
                                    width:
                                        60, // Diameter of the CircleAvatar (radius * 2)
                                    height:
                                        55, // Diameter of the CircleAvatar (radius * 2)
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error,
                                          color: Colors
                                              .red); // Optional: Handle loading errors
                                    },
                                  ),
                                ),
                              ),
                            ),
                            title: Text(data.foodProducts[index].name ?? ''),
                            trailing: Wrap(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      navigate(
                                          context: context,
                                          screen: EditProductScreen(
                                              product:
                                                  data.foodProducts[index]));
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.blueAccent,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    data
                                        .deleteFoodItem(
                                            context: context,
                                            productId: data
                                                .foodProducts[index].id as int)
                                        .then((res) {
                                      data.getProductCategories(
                                          context: context,
                                          subCategoryId: data
                                                  .foodProducts[index]
                                                  .subcategory ??
                                              0);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                ), // Changed one icon to "delete" to make sense
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
        }),
      ),
    );
  }
}
