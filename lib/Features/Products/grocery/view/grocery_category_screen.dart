import 'package:fastbag_vendor_flutter/Commons/circle_icon.dart';
import 'package:fastbag_vendor_flutter/Commons/text_field_decortion.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/serach_item.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/ViewModel/grocery_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view/all_grocery_sub_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';

import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';

class GroceryCategoryScreen extends StatefulWidget {
  const GroceryCategoryScreen({super.key});

  @override
  State<GroceryCategoryScreen> createState() => _ListCategoryScreenState();
}

class _ListCategoryScreenState extends State<GroceryCategoryScreen> {
  int selectedCategoryId = 1;
  late List<SerachItem> combinedList = [];
  List<SerachItem> filteredList = []; // Filtered list for search suggestions
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Fetch categories and subcategories
    final groceryViewModel =
        Provider.of<GroceryViewModel>(context, listen: false);
    groceryViewModel.fetchGroceryCategory(context);

    ///   groceryViewModel.fetchGrocerySubCategory(context);
  }

  void _filterSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList = []; // Reset when the search text is cleared
      });
    } else {
      setState(() {
        // Filter the combined list based on the query
        filteredList = combinedList
            .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  void _onSubmitted(SerachItem item, GroceryViewModel groceryViewModel) {}

  @override
  Widget build(BuildContext context) {
    final groceryViewModel = Provider.of<GroceryViewModel>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // // Ensure categories and subcategories are loaded
    // if (groceryViewModel.categories.isNotEmpty ||
    //     groceryViewModel.allSubCategories.isNotEmpty) {
    //   // Combine category and subcategory names once data is available
    //   List<SerachItem> categoryItems = groceryViewModel.categories.isNotEmpty
    //       ? groceryViewModel.categories
    //           .map<SerachItem>((category) => SerachItem(
    //               id: category.id ?? 0,
    //               name: category.name ?? "",
    //               type: "category",
    //               model: category))
    //           .toList()
    //       : [];
    //   List<SerachItem> subCategoryItems =
    //       groceryViewModel.allSubCategories.isNotEmpty
    //           ? groceryViewModel.allSubCategories
    //               .map<SerachItem>((subCategory) => SerachItem(
    //                   id: subCategory.id,
    //                   name: subCategory.name,
    //                   type: "sub_category",
    //                   model: subCategory))
    //               .toList()
    //           : [];
    //   combinedList = [...categoryItems, ...subCategoryItems];
    //   print("Combined List: $combinedList"); // Debugging output
    // }
    gap(value) {
      return SizedBox(height: screenWidth * value);
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard and suggestions when tapping outside
          searchFocusNode.unfocus();
          setState(() {
            filteredList = []; // Reset suggestions when tapping outside
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.08),
              SizedBox(
                height: screenWidth * 0.15,
                child: TextField(
                  controller: searchController,
                  focusNode: searchFocusNode,
                  decoration: searchBarDecoration(
                    hint: 'Search here',
                  ),
                  onChanged: _filterSearch,
                ),
              ),
              gap(0.04),
              Text(
                "Select Categories",
                style: mainFont(
                    fontsize: 18,
                    fontweight: FontWeight.w600,
                    color: FbColors.greendark),
              ),
              gap(0.04),

              // Category List Horizontal
              Expanded(
                child: Consumer<GroceryViewModel>(
                  builder: (context, data, _) {
                    if (data.categories.isEmpty) {
                      return Center(
                          child: Text('No Categories Added', style: nunito()));
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.all(0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 0.7),
                      itemCount: data.categories.length,
                      itemBuilder: (context, index) {
                        return categoryCard(
                          text: data.categories[index].name,
                          onTap: () {
                            searchController.clear();
                            searchFocusNode.unfocus();
                            navigate(
                                context: context,
                                screen: AllGrocerySubCategoryScreen(
                                  category: data.categories[index],
                                ));
                          },
                          radius: screenWidth * .115,
                          image: NetworkImage(
                            data.categories[index].categoryImage ?? "",
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Widget subCategoriesSection(double screenHeight, double screenWidth,
//     GroceryViewModel groceryViewModel) {
//   List<GrocerySubCategoryModel> filteredSubCategories =
//       groceryViewModel.subCategoriesByCategory(selectedCategoryId);

//   return Column(
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Select Sub Categories",
//             style: mainFont(
//                 fontsize: 18,
//                 fontweight: FontWeight.w600,
//                 color: FbColors.greendark),
//           ),
//           if (filteredSubCategories.isNotEmpty)
//             TextButton(
//               onPressed: () {
//                 navigate(
//                     context: context,
//                     screen: const AllGrocerySubCategoryScreen());
//               },
//               child: const Text(
//                 "View All",
//                 style: TextStyle(
//                     color: Colors.grey, decoration: TextDecoration.underline),
//               ),
//             )
//         ],
//       ),
//       SizedBox(
//           height: screenHeight * 0.5, // Constrain height for GridView
//           child: filteredSubCategories.isEmpty
//               ? Center(
//                   child: Text('No Sub Categories Added', style: nunito()))
//               : GridView.builder(
//                   padding: const EdgeInsets.all(5),
//                   gridDelegate:
//                       const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3,
//                           childAspectRatio: .57,
//                           crossAxisSpacing: 14),
//                   itemCount: filteredSubCategories.length,
//                   itemBuilder: (context, index) {
//                     return subCategoryCard(
//                       height: screenWidth * 0.33,
//                       text: filteredSubCategories[index].name,
//                       image:
//                           filteredSubCategories[index].subcategoryImage ?? '',
//                       onTap: () {
//                         navigate(
//                             context: context,
//                             screen: ListGroceryProducts(
//                                 subCategory: filteredSubCategories[index],
//                                 category:
//                                     groceryViewModel.categories[index]));
//                       },
//                     );
//                   },
//                 )),
//     ],
//   );
// }
}
