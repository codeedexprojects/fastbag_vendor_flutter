import 'package:fastbag_vendor_flutter/Commons/circle_icon.dart';
import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_categoryby_subcategory.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/fashion_subcategory_edit_list.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/sub_fashion_category_edit_list.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view_model/fashion_category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../model/fashion_category_model.dart';
import 'add_fashion_sub_category_screen.dart';
import 'list_fashion_products_screen.dart';

class FashionCategorybySubcategory extends StatefulWidget {
  final FashionCategoryModel category;

  final bool isOperable;

  FashionCategorybySubcategory({
    super.key,
    required this.isOperable,
    required this.category,
    // this.selectSubCategory
  });

  @override
  State<FashionCategorybySubcategory> createState() =>
      _FashionCategorybySubcategoryState();
}

class _FashionCategorybySubcategoryState
    extends State<FashionCategorybySubcategory> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    final categoryProvider =
        Provider.of<FashionCategoryViewModel>(context, listen: false);
    categoryProvider.allcategorypage = 1;
    categoryProvider.getFashionCategorybySubCategories(
        categoryId: widget.category.id ?? 0);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        categoryProvider.getAllSubCategoryLoading(
            categoryId: widget.category.id ?? 0);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<FashionCategoryViewModel>(context);

    print("subcategories :- ${categoryProvider.selectsubCategory}");
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
              Icons.arrow_back_ios_new), // Replace with your desired icon
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          categoryProvider.selectsubCategory.isEmpty
              ? " Sub Categories"
              : categoryProvider.selectsubCategory.first.categoryName ?? '',
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
            SizedBox(
              height: screenHeight * .02,
            ),
            Text(
              "Select Sub Categories",
              style: mainFont(
                  fontsize: 18,
                  fontweight: FontWeight.w600,
                  color: FbColors.greendark),
            ),
            SizedBox(
              height: screenHeight * .02,
            ),
            categoryProvider.selectsubCategory.isNotEmpty
                ? Expanded(
                    child: GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.57,
                            crossAxisSpacing: 14),
                    itemCount: categoryProvider.selectsubCategory.length,
                    itemBuilder: (context, index) {
                      return subCategoryCard(
                        height: screenWidth * 0.33,
                        text: categoryProvider.selectsubCategory[index]?.name ??
                            '',
                        image: categoryProvider
                                .selectsubCategory[index]?.subcategoryImage ??
                            '',
                        onTap: () {
                          navigate(
                            context: context,
                            screen: FashionListProductsScreen(
                              category: widget.category,
                              subCategory:
                                  categoryProvider.selectsubCategory[index],
                            ),
                          );
                        },
                      );
                    },
                  ))
                : Expanded(
                    child: SizedBox(
                      height: screenHeight,
                      width: screenWidth,
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
                          SizedBox(
                            height: screenHeight * .004,
                          ),
                          Text("Nothing to show yet. Created", style: nunito()),
                          Text(
                            "Sub Category list will appear here",
                            style: nunito(),
                          ),
                        ],
                      ),
                    ),
                  ),
            if (widget.isOperable)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth / 15, vertical: 5),
                child: FbButton(
                    onClick: () {
                      navigate(
                          context: context,
                          screen: FashionAddSubCategoryScreen(
                            categories: categoryProvider.categories,
                          ));
                    },
                    label: "+ Add SubCategory"),
              ),
            if (widget.isOperable &&
                categoryProvider.selectsubCategory.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth / 15, vertical: 5),
                child: FbButton(
                  onClick: () {
                    navigate(
                        context: context,
                        screen: FashionSubCategoryEditList(
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
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
