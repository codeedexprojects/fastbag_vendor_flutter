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
  // final List<SubCategoryModel> subCategories;
  // final List<CategoryModel> categories;
  final int? categoryId;
  const SubCategoryEditList(
      {super.key,  this.categoryId});

  @override
  State<SubCategoryEditList> createState() => _SubCategoryEditListState();
}

class _SubCategoryEditListState extends State<SubCategoryEditList> {
  @override
  void initState() {
    final categoryProvider=Provider.of<CategoryViewModel>(context,listen: false);
    categoryProvider.getFoodCategorybySubCategories(categoryId: widget?.categoryId??0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryViewModel>(context);
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FbColors.backgroundcolor,
<<<<<<< HEAD
        title: Text(categoryProvider.selectsubCategories.isEmpty? "Edit Sub Categories"
          :"${categoryProvider.selectsubCategories.first.categoryName??""} Edit Sub Categories",
=======
        title: Text("Edit Sub Categories",
>>>>>>> 7317fe5cc4d2705ece17318cddd70f852b5e77be
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
            itemCount: categoryProvider.selectsubCategories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(screenWidth * .02),
                child: InkWell(
                  onTap: () {
                    navigate(
                        context: context,
                        screen: EditSubCategoryScreen(
                          categories: categoryProvider.categories,
                          category: categoryProvider.categories[0],
                          subCategory: categoryProvider.selectsubCategories[index],
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
                            categoryProvider.selectsubCategories[index].subcategoryImage??'',
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
                      title: Text(categoryProvider.selectsubCategories[index].name??''),
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
