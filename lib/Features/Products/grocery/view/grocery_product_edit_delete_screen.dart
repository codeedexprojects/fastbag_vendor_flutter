import 'package:fastbag_vendor_flutter/Commons/fonts.dart';

import 'package:fastbag_vendor_flutter/Features/Products/grocery/ViewModel/grocery_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_products_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroceryProductEditDeleteScreen extends StatelessWidget {
  final List<GroceryProductsModel> products;
  const GroceryProductEditDeleteScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final groceryViewModel = Provider.of<GroceryViewModel>(context);

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
        child:
            Consumer<GroceryViewModel>(builder: (context, groceryViewModel, _) {
          return ListView.builder(
              itemCount: groceryViewModel.subCategoryProducts.length,
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
                              groceryViewModel
                                  .subCategoryProducts[index].images[0].image,
                              fit: BoxFit.cover,
                              width: 64,
                              height: 64,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error,
                                    color: Colors
                                        .red); // Optional: Handle loading errors
                              },
                            ),
                          ),
                        ),
                        title: Text(
                            groceryViewModel.subCategoryProducts[index].name),
                        trailing: SizedBox(
                          width: screenWidth * .15, // Set an appropriate width
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Ensures spacing between icons
                            children: [
                              InkWell(
                                  onTap: () {
                                    // navigate(
                                    //     context: context,
                                    //     screen: EditProductScreen(
                                    //         product: groceryViewModel.subCategoryProducts[index]));
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.blueAccent,
                                  )),
                              InkWell(
                                onTap: () {
                                  // data
                                  //     .deleteFoodItem(
                                  //         context: context,
                                  //         productId: data.foodProducts[index].id
                                  //             as int)
                                  //     .then((res) {
                                  //   data.getProductCategories(
                                  //       context: context,
                                  //       subCategoryId: data
                                  //           .foodProducts[index].subcategory);
                                  // });
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
