import 'package:fastbag_vendor_flutter/Commons/circle_icon.dart';
import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/text_field_decortion.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/ViewModel/grocery_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view/add_grocery_sub_category_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view/grocery_sub_category_edit_list.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view/list_groceey_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../model/grocery_catgeory_model.dart';

class AllGrocerySubCategoryScreen extends StatefulWidget {
  final List<GroceryCategoryModel> categories;
  final List<GrocerySubCategoryModel> subCategories;
  const AllGrocerySubCategoryScreen(
      {super.key, required this.subCategories, required this.categories});

  @override
  State<AllGrocerySubCategoryScreen> createState() =>
      _AllGrocerySubCategoryScreenState();
}

class _AllGrocerySubCategoryScreenState
    extends State<AllGrocerySubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final FocusNode searchFocusNode = FocusNode();
    final groceryViewModel = Provider.of<GroceryViewModel>(context);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    gap(value) {
      return SizedBox(height: screenWidth * value);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.08),
            SizedBox(
              height: screenWidth * 0.15,
              child: TextField(
                controller: searchController,
                focusNode: searchFocusNode,
                decoration: searchBarDecoration(
                  hint: 'Search here',
                ),
                onChanged: (value) {},
              ),
            ),
            gap(0.04),
            Text(
              "Select Sub Categories",
              style: nunito(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: FbColors.greendark),
            ),
            gap(0.04),
            widget.subCategories.isNotEmpty
                ? Expanded(
                    child: GridView.builder(
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.57,
                            crossAxisSpacing: 14),
                    itemCount: widget.subCategories.length,
                    itemBuilder: (context, index) {
                      return subCategoryCard(
                        height: screenWidth * 0.33,
                        text: widget.subCategories[index].name,
                        image:
                            widget.subCategories[index].subcategoryImage ?? '',
                        onTap: () {
                          navigate(
                            context: context,
                            screen: ListGroceryProducts(
                              category: widget.categories[index],
                              subCategory: widget.subCategories[index],
                            ),
                          );
                        },
                      );
                    },
                  ))
                : Expanded(
                    child: Center(
                      child: Text(
                        "Start adding your sub category now",
                        style: nunito(),
                      ),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 15, vertical: 5),
              child: FbButton(
                  onClick: () {
                    navigate(
                        context: context,
                        screen: AddGrocerySubCategoryScreen(
                          categories: widget.categories,
                        ));
                  },
                  label: "+ Add Category"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 15, vertical: 5),
              child: FbButton(
                onClick: () {
                  navigate(
                      context: context,
                      screen: GrocerySubCategoryEditList(
                        subCategories: widget.subCategories,
                        categories: widget.categories,
                      ));
                },
                icon: const FaIcon(
                  FontAwesomeIcons.penToSquare,
                  size: 20,
                ),
                label: "Edit",
                color: Colors.white,
                textColor: Colors.blue,
                borderColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
