import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/edit_sub_category_screen.dart';
import 'package:flutter/material.dart';

import '../model/fashion_category_model.dart';
import '../model/fashion_sub_category_model.dart';
import 'edit_fashion_sub_category_screen.dart';

class FashionAllSubCategoryEditList extends StatelessWidget {
  final List<FashionSubCategoryModel> subCategories;
  final List<FashionCategoryModel> categories;

  const FashionAllSubCategoryEditList(
      {super.key, required this.subCategories, required this.categories});

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
        child: ListView.builder(
            itemCount: subCategories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(screenWidth * .02),
                child: InkWell(
                  onTap: () {
                    navigate(
                        context: context,
                        screen: FashionEditSubCategoryScreen(
                          categories: categories,
                          category: categories[0],
                          subCategory: subCategories[index],
                        ));
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
                            subCategories[index].subcategoryImage.toString(),
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
                      title: Text(subCategories[index].name.toString()),
                      trailing: const Icon(Icons.edit),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
