import 'package:fastbag_vendor_flutter/Commons/circle_icon.dart';
import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/text_field_decortion.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/ViewModel/grocery_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_catgeory_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view/add_grocery_sub_category_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view/grocery_sub_category_edit_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'list_groceey_products_screen.dart';

class AllGrocerySubCategoryScreen extends StatefulWidget {
  final GroceryCategoryModel category;
  const AllGrocerySubCategoryScreen({super.key, required this.category});

  @override
  State<AllGrocerySubCategoryScreen> createState() =>
      _AllGrocerySubCategoryScreenState();
}

class _AllGrocerySubCategoryScreenState
    extends State<AllGrocerySubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
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
            groceryViewModel.filteredSubCategories.isNotEmpty
                ? Expanded(
                    child: GridView.builder(
                    padding: const EdgeInsets.all(0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.57,
                            crossAxisSpacing: 14),
                    itemCount: groceryViewModel.filteredSubCategories.length,
                    itemBuilder: (context, index) {
                      return subCategoryCard(
                        height: screenWidth * 0.33,
                        text:
                            groceryViewModel.filteredSubCategories[index].name,
                        image: groceryViewModel.filteredSubCategories[index]
                                .subcategoryImage ??
                            '',
                        onTap: () {
                          print(
                              '----------------------->${groceryViewModel.filteredSubCategories[index].name}');

                          navigate(
                            context: context,
                            screen: ListGroceryProducts(
                              subCategory:
                                  groceryViewModel.filteredSubCategories[index],
                            ),
                          );
                        },
                      );
                    },
                  ))
                : Expanded(
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
                        Text(
                          "Sub Category list will appear here",
                          style: nunito(),
                        )
                      ],
                    ),
                  )),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 15, vertical: 5),
              child: FbButton(
                  onClick: () {
                    navigate(
                        context: context,
                        screen: AddGrocerySubCategoryScreen(
                          category: widget.category,
                        ));
                  },
                  label: "+ Add Sub Category"),
            ),
            if (groceryViewModel.filteredSubCategories.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth / 15, vertical: 5),
                child: FbButton(
                  onClick: () {
                    navigate(
                        context: context,
                        screen: GrocerySubCategoryEditList(
                          subCategories: groceryViewModel.filteredSubCategories,
                          category: widget.category,
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
            gap(.02),
          ],
        ),
      ),
    );
  }
}
