import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/edit_sub_category_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../grocery/model/grocery_catgeory_model.dart';

class SubCategoryEditList extends StatefulWidget {
  final int? categoryId;

  const SubCategoryEditList({super.key, this.categoryId});

  @override
  State<SubCategoryEditList> createState() => _SubCategoryEditListState();
}

class _SubCategoryEditListState extends State<SubCategoryEditList> {
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
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
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
            controller: _scrollController,
            itemCount: categoryProvider.selectsubCategories.length,
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
                          categoryProvider.selectsubCategories[index]
                                  .subcategoryImage ??
                              '',
                          fit:
                              BoxFit.fill, // Ensures the image fills the circle
                          width:
                              60, // Diameter of the CircleAvatar (radius * 2)
                          height:
                              55, // Diameter of the CircleAvatar (radius * 2)
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error,
                                color: Colors
                                    .red); // Optional: Handle loading errors
                          },
                        ),
                      ),
                    ),
                    title: Text(
                        categoryProvider.selectsubCategories[index].name ?? ''),
                    trailing: Wrap(
                      children: [
                        GestureDetector(
                            onTap: () {
                              navigate(
                                  context: context,
                                  screen: EditSubCategoryScreen(
                                    categories: categoryProvider.categories,
                                    category: categoryProvider.categories[0],
                                    subCategory: categoryProvider
                                        .selectsubCategories[index],
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
                                              .selectsubCategories[index].id ??
                                          0)
                                  .then((v) {
                                categoryProvider.getFoodCategorybySubCategories(
                                    categoryId: widget.categoryId ?? 0);
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
