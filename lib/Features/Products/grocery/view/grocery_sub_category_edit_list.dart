import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/ViewModel/grocery_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_catgeory_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view/edit_sub_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GrocerySubCategoryEditList extends StatelessWidget {
  final GroceryCategoryModel category;
  final List<GrocerySubCategoryModel> subCategories;
  const GrocerySubCategoryEditList(
      {super.key, required this.category, required this.subCategories});

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final groceryViewModel = Provider.of<GroceryViewModel>(context);

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
                        child: subCategories[index].subcategoryImage == null
                            ? Image.asset('assets/Images/grocery.jpeg')
                            : Image.network(
                                subCategories[index].subcategoryImage ?? '',
                                fit: BoxFit.cover,
                                width: 64,
                                height: 64,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error,
                                      color: Colors
                                          .red); // Optional: Handle loading errors
                                },
                              ),
                      ),
                    ),
                    title: Text(subCategories[index].name),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      GestureDetector(
                        onTap: () {
                          navigate(
                              context: context,
                              screen: EditGrocerySubCategoryScreen(
                                category: category,
                                subCategory: subCategories[index],
                              ));
                        },
                        child: const Icon(Icons.edit),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          groceryViewModel.deleteSubCategory(
                              context, subCategories[index].id);
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                    ]),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
