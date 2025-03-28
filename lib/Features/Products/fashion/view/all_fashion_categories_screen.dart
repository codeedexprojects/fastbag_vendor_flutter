import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Commons/circle_icon.dart';
import '../model/fashion_category_model.dart';
import '../model/fashion_sub_category_model.dart';
import '../view_model/fashion_category_view_model.dart';
import 'all_fashion_sub_category_screen.dart';
import 'fashion_categoryby_subcategory.dart';

class FashionAllCategoriesScreen extends StatelessWidget {
  final List<FashionCategoryModel> categories;
  final List<FashionSubCategoryModel> subCategories;

  FashionAllCategoriesScreen(
      {super.key, required this.categories, required this.subCategories});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:FbColors.backgroundcolor ,
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
              child: Consumer<FashionCategoryViewModel>(
                builder: (context, data, _) {
                  return GridView.builder(
                    padding: EdgeInsets.only(top: screenHeight * .015),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, childAspectRatio: 0.7),
                    itemCount: data.categories.length,
                    itemBuilder: (context, index) {
                      return categoryCard(
                        text: data.categories[index]?.name,
                        onTap: () {
                          navigate(
                              context: context,
                              screen: FashionCategorybySubcategory(
                                isOperable: true,
                                category: data.categories[index],
                              ));
                        },
                        radius: screenWidth * .091,
                        image: NetworkImage(
                          data.categories[index]?.categoryImage ?? '',
                        ),
                      );
                    },
                  );
                },
              ),
              // GridView.builder(
              //     padding: EdgeInsets.only(top: screenHeight * .015),
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 4, childAspectRatio: 0.7),
              //     itemCount: categories.length,
              //     itemBuilder: (context, index) {
              //       return SizedBox(
              //         width: screenWidth * .23,
              //         child: Column(
              //           children: [
              //             GestureDetector(
              //               onTap: () {
              //
              //
              //
              //                 // List<FashionSubCategoryModel> filteredSubCategories =
              //                 //     subCategories
              //                 //         .where((subCat) =>
              //                 //             subCat.id ==
              //                 //             categories[index]?.id)
              //                 //         .toList();
              //                 // navigate(
              //                 //     context: context,
              //                 //     screen: FashionAllSubCategoryScreen(
              //                 //       subCategories: filteredSubCategories,
              //                 //       categories: categories,
              //                 //       isOperable: true,
              //                 //     ));
              //               },
              //               child: CircleAvatar(
              //                 radius: screenWidth * .1,
              //                 backgroundImage: NetworkImage(
              //                     categories[index]?.categoryImage??''),
              //               ),
              //             ),
              //             Text(
              //               categories[index]?.name??'',
              //               overflow: TextOverflow.ellipsis,
              //             )
              //           ],
              //         ),
              //       );
              //     }),
            )
          ],
        ),
      ),
    );
  }
}
