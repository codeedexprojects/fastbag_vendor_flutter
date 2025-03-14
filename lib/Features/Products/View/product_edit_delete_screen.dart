import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_item_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/edit_product_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../fashion/view_model/fashionproduct_view_model.dart';

class ProductEditDeleteScreen extends StatelessWidget {
  final List<FoodItemModel> products;
  const ProductEditDeleteScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final productProvider =
        Provider.of<FashionProductViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Sub Categories",
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
          return ListView.builder(
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
                          border: Border.all(color: Colors.grey, width: 0.5)),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 32,
                          backgroundColor:
                              Colors.grey[200], // Optional: Background color
                          child: ClipOval(
                            child: Image.network(
                              data.foodProducts[index].image_urls[0],
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
                        title: Text(data.foodProducts[index].name),
                        trailing: SizedBox(
                          width: screenWidth * .15, // Set an appropriate width
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Ensures spacing between icons
                            children: [
                              InkWell(
                                  onTap: () {
                                    navigate(
                                        context: context,
                                        screen: EditProductScreen(
                                            product: data.foodProducts[index]));
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blueAccent,
                                  )),
                              InkWell(
                                onTap: () {
                                  data
                                      .deleteFoodItem(
                                          context: context,
                                          productId: data.foodProducts[index].id
                                              as int)
                                      .then((res) {
                                    data.getProductCategories(
                                        context: context,
                                        subCategoryId: data
                                            .foodProducts[index].subcategory);
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
                  ),
                );
              });
        }),
      ),
    );
  }
}
