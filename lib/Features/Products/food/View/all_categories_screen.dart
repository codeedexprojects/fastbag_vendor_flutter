import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/food/Model/category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/food/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/food/View/all_sub_category_screen.dart';
import 'package:flutter/material.dart';

class AllCategoriesScreen extends StatelessWidget {
  final List<CategoryModel> categories;
  final List<SubCategoryModel> subCategories;
  const AllCategoriesScreen(
      {super.key, required this.categories, required this.subCategories});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
              Icons.arrow_back_ios_new), // Replace with your desired icon
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "All Categories",
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
              height: screenHeight * 0.008,
            ),
            SizedBox(
              height: screenHeight * .02,
            ),
            Text(
              "Select Categories",
              style: mainFont(
                  fontsize: 18,
                  fontweight: FontWeight.w600,
                  color: FbColors.greendark),
            ),
            SizedBox(
              height: screenHeight * .4,
              child: GridView.builder(
                  padding: EdgeInsets.only(top: screenHeight * .015),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 0.7),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: screenWidth * .23,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              List<SubCategoryModel> filteredSubCategories =
                                  subCategories
                                      .where((subCat) =>
                                          subCat.categoryId ==
                                          categories[index].id)
                                      .toList();
                              navigate(
                                  context: context,
                                  screen: AllSubCategoryScreen(
                                    subCategories: filteredSubCategories,
                                    categories: categories,
                                    isOperable: true,
                                  ));
                            },
                            child: CircleAvatar(
                              radius: screenWidth * .1,
                              backgroundImage: NetworkImage(
                                  categories[index].category_image),
                            ),
                          ),
                          Text(
                            categories[index].name,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
