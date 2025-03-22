import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/text_field_decortion.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/product_detail_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/ViewModel/grocery_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_catgeory_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view/add_grocery_product.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view/grocery_product_edit_delete_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view/product%20details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ListGroceryProducts extends StatefulWidget {
  final GrocerySubCategoryModel subCategory;

  const ListGroceryProducts({
    super.key,
    required this.subCategory,
  });

  @override
  State<ListGroceryProducts> createState() => _ListGroceryProductsState();
}

class _ListGroceryProductsState extends State<ListGroceryProducts> {
  @override
  void initState() {
    super.initState();
    final groceryViewModel =
    Provider.of<GroceryViewModel>(context, listen: false);
    groceryViewModel.fetchProductList(context, widget.subCategory.id);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final groceryViewModel = Provider.of<GroceryViewModel>(context);
    gap(value) {
      return SizedBox(height: screenWidth * value);
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 253, 247, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Consumer<GroceryViewModel>(builder: (context, groceryViewModel, _) {
              final products = groceryViewModel.subCategoryProducts;
              return products.isEmpty
                  ? Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/no_product.svg',
                          width: screenWidth * .45, // Set desired width
                          height: screenWidth * .3, // Set desired height
                        ),
                        SizedBox(
                          height: screenHeight * .004,
                        ),
                        Text("Nothing to show yet. Created", style: nunito()),
                        Text("Product list will appear here", style: nunito())
                      ],
                    ),
                  ))
                  : Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    print(
                        '-----------------> lenth ------------> ${products.length}');
                    print(
                        '-----------------> products ------------> ${products[index].name}');
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // navigate(
                            //     context: context,
                            //     screen: ProductDetailScreen(
                            //         productId: products[index].id));
                          },
                          child: ListTile(
                            onTap: () {
                              navigate(context: context, screen: ProductDetails(product: products[index],));
                            },
                            leading: Container(
                              height: screenHeight * .05,
                              width: screenHeight * .06,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: products[index].images.isNotEmpty
                                      ? NetworkImage(
                                      products[index].images[0].image)
                                      : const AssetImage(
                                      'assets/Images/grocery.jpeg'),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                    color: Colors.grey, width: 0.2),
                              ),
                            ),
                            title: Text(products[index].name),
                            subtitle:
                            Text(products[index].price.toString()),
                            trailing: Switch(
                              value: products[index].available,
                              activeColor: Colors.green,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.grey[300],
                              trackOutlineColor:
                              const WidgetStatePropertyAll(
                                  Colors.transparent),
                              materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                              onChanged: (value) {
                                groceryViewModel.updateProductAvailable(
                                    context,
                                    products[index].id,
                                    !products[index].available);
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 15, vertical: 5),
              child: FbButton(
                  onClick: () {
                    print('----------------------->${widget.subCategory.name}');

                    navigate(
                        context: context,
                        screen: AddGroceryProduct(
                          subCategory: widget.subCategory,
                        ));
                  },
                  label: "+ Add Product"),
            ),
            if (groceryViewModel.subCategoryProducts.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth / 15, vertical: 5),
                child: FbButton(
                  onClick: () {
                    navigate(
                        context: context,
                        screen: const GroceryProductEditDeleteScreen());
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
            gap(.02),
          ],
        ),
      ),
    );
  }
}