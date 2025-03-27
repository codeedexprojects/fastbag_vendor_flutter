import 'package:fastbag_vendor_flutter/Commons/circle_icon.dart';
import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/sub_category_edit_list.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/category_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_categoryby_subcategory.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/fashion_subcategory_edit_list.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/sub_fashion_category_edit_list.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view_model/fashion_category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../fashion/view/add_fashion_sub_category_screen.dart';
import 'add_sub_category_screen.dart';
import 'list_products_screen.dart';

class FoodCategorybySubcategory extends StatefulWidget {
  final int? categoryId;

  final bool isOperable;

  FoodCategorybySubcategory({
    super.key,
    required this.isOperable,
    required this.categoryId,
    // this.selectSubCategory
  });

  @override
  State<FoodCategorybySubcategory> createState() =>
      _FashionCategorybySubcategoryState();
}

class _FashionCategorybySubcategoryState
    extends State<FoodCategorybySubcategory> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    final categoryProvider =
        Provider.of<CategoryViewModel>(context, listen: false);
    categoryProvider.allsubcategorypage = 1;
    categoryProvider.getFoodCategorybySubCategories(
        categoryId: widget?.categoryId ?? 0);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        categoryProvider.getAllSubCategoryLoading(
            categoryId: widget?.categoryId ?? 0);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryViewModel>(context);

    print("subcategories :- ${categoryProvider.selectsubCategories}");
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: FbColors.backgroundcolor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: FbColors.backgroundcolor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
              Icons.arrow_back_ios_new), // Replace with your desired icon
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          categoryProvider.selectsubCategories.isEmpty
              ? " Sub Categories"
              : categoryProvider.selectsubCategories.first.categoryName ?? '',
          style: mainFont(
              fontsize: screenWidth * 0.05,
              fontweight: FontWeight.w500,
              color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     SizedBox(
            //       width: screenWidth * 0.8,
            //       child: SearchBar(
            //         backgroundColor: const WidgetStatePropertyAll(Colors.white),
            //         elevation: const WidgetStatePropertyAll(0),
            //         shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(5))),
            //         side: WidgetStatePropertyAll(
            //             BorderSide(color: FbColors.black, width: 0.5)),
            //         trailing: const [
            //           Icon(
            //             Icons.search,
            //             size: 35,
            //           )
            //         ],
            //         hintText: "search here",
            //       ),
            //     ),
            //     const Icon(Icons.more_vert)
            //   ],
            // ),
            SizedBox(
              height: screenHeight * .02,
            ),
            Text(
              //
              // categoryProvider.selectsubCategory.isEmpty
              //     ?
              "Select Sub Categories",
              //     : "No Sub Categories added",
              style: mainFont(
                  fontsize: 18,
                  fontweight: FontWeight.w600,
                  color: FbColors.greendark),
            ),
            SizedBox(
              height: screenHeight * .02,
            ),
            categoryProvider.selectsubCategories.isNotEmpty
                ? Expanded(
                    child: GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.57,
                            crossAxisSpacing: 14),
                    itemCount: categoryProvider.selectsubCategories.length,
                    itemBuilder: (context, index) {
                      return subCategoryCard(
                        height: screenWidth * 0.33,
                        text:
                            categoryProvider.selectsubCategories[index]?.name ??
                                '',
                        image: categoryProvider
                                .selectsubCategories[index]?.subcategoryImage ??
                            '',
                        onTap: () {
                          navigate(
                            context: context,
                            screen: ListProductsScreen(
                              subCategorys:
                                  categoryProvider.selectsubCategories[index],
                              subCategoriess:
                                  categoryProvider.selectsubCategories,
                            ),
                          );
                        },
                      );
                    },
                  ))
                : const Center(
                    child: Text("Start adding your sub category now"),
                  ),
            if (widget.isOperable)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth / 15, vertical: 5),
                child: FbButton(
                    onClick: () {
                      navigate(
                          context: context,
                          screen: AddSubCategoryScreen(
                            categories: categoryProvider.categories,
                          ));
                    },
                    label: "+ Add Sub Category"),
              ),
            if (widget.isOperable &&
                categoryProvider.selectsubCategories.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth / 15, vertical: 5),
                child: FbButton(
                  onClick: () {
                    navigate(
                        context: context,
                        screen: SubCategoryEditList(
                          categoryId: widget.categoryId,
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
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
