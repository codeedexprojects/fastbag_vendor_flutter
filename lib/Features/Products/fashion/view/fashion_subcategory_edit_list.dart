import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/edit_sub_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/fashion_category_model.dart';
import '../model/fashion_sub_category_model.dart';
import '../view_model/fashion_category_view_model.dart';
import 'edit_fashion_sub_category_screen.dart';

class FashionSubCategoryEditList extends StatefulWidget {
  final FashionCategoryModel category;

  const FashionSubCategoryEditList({super.key, required this.category});

  @override
  State<FashionSubCategoryEditList> createState() =>
      _FashionSubCategoryEditListState();
}

class _FashionSubCategoryEditListState
    extends State<FashionSubCategoryEditList> {
  void initState() {
    final categoryProvider =
        Provider.of<FashionCategoryViewModel>(context, listen: false);
    categoryProvider.getFashionCategorybySubCategories(
        categoryId: widget.category.id ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<FashionCategoryViewModel>(context);
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FbColors.backgroundcolor,
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
            itemCount: categoryProvider.selectsubCategory.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(screenWidth * .02),
                child: Container(
                  padding: EdgeInsets.all(screenWidth * .02),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 0.5)),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 32,
                      backgroundColor:
                          Colors.grey[200], // Optional: Background color
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          categoryProvider
                              .selectsubCategory[index].subcategoryImage
                              .toString(),
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
                    title: Text(categoryProvider.selectsubCategory[index].name
                        .toString()),
                    trailing: Wrap(
                      children: [
                        GestureDetector(
                            onTap: () {
                              print(
                                categoryProvider.selectsubCategory[index].name,
                              );
                              navigate(
                                  context: context,
                                  screen: FashionEditSubCategoryScreen(
                                    category: widget.category,
                                    subCategory: categoryProvider
                                        .selectsubCategory[index],
                                  ));
                            },
                            child: Icon(Icons.edit)),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              categoryProvider
                                  .deleteSubCategory(
                                      context: context,
                                      subcategoryId: categoryProvider
                                              .selectsubCategory[index].id ??
                                          0)
                                  .then((v) {
                                categoryProvider
                                    .getFashionCategorybySubCategories(
                                        categoryId: widget.category.id ?? 0);
                              });
                            },
                            child: Icon(
                              Icons.delete,
                              color: FbColors.errorcolor,
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
