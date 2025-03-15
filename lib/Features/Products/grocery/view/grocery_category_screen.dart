import 'package:fastbag_vendor_flutter/Commons/circle_icon.dart';
import 'package:fastbag_vendor_flutter/Commons/text_field_decortion.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/serach_item.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/ViewModel/grocery_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view/all_grocery_categories_screen.dart';
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
  late List<SerachItem> combinedList =
      []; // Combined list of categories and subcategories
  List<SerachItem> filteredList = []; // Filtered list for search suggestions
  final TextEditingController searchController =
      TextEditingController(); // SearchBar controller
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Fetch categories and subcategories
    final groceryViewModel =
        Provider.of<GroceryViewModel>(context, listen: false);
    groceryViewModel.fetchGroceryCategory(context);
    groceryViewModel.fetchGrocerySubCategory(context);
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

  void _onSubmitted(SerachItem item, GroceryViewModel groceryViewModel) {
    // Handle search submission
    if (item.type == "category") {
      navigate(
          context: context,
          screen: AllGroceryCategoriesScreen(
              categories: [item.model],
              subCategories: groceryViewModel.subCategories));
    } else {
      navigate(
          context: context,
          screen: AllGrocerySubCategoryScreen(
            subCategories: [item.model],
            categories: groceryViewModel.categories,
          ));
    }
    setState(() {
      filteredList = []; // Optionally clear search results after submission
    });
  }

  @override
  Widget build(BuildContext context) {
    final groceryViewModel = Provider.of<GroceryViewModel>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Ensure categories and subcategories are loaded
    if (groceryViewModel.categories.isNotEmpty ||
        groceryViewModel.subCategories.isNotEmpty) {
      // Combine category and subcategory names once data is available
      List<SerachItem> categoryItems = groceryViewModel.categories.isNotEmpty
          ? groceryViewModel.categories
              .map<SerachItem>((category) => SerachItem(
                  id: category.id ?? 0,
                  name: category.name ?? "",
                  type: "category",
                  model: category))
              .toList()
          : [];
      List<SerachItem> subCategoryItems =
          groceryViewModel.subCategories.isNotEmpty
              ? groceryViewModel.subCategories
                  .map<SerachItem>((subCategory) => SerachItem(
                      id: subCategory.id,
                      name: subCategory.name,
                      type: "sub_category",
                      model: subCategory))
                  .toList()
              : [];
      combinedList = [...categoryItems, ...subCategoryItems];
      print("Combined List: $combinedList"); // Debugging output
    }

    final gap = SizedBox(height: screenWidth * 0.02);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard and suggestions when tapping outside
          searchFocusNode.unfocus();
          setState(() {
            filteredList = []; // Reset suggestions when tapping outside
          });
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const NeverScrollableScrollPhysics(),
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
              if (filteredList.isEmpty)
                Column(
                  children: [
                    if (searchController.text.isNotEmpty)
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenWidth * 0.07),
                        child: const Text("No results"),
                      ),
                    gap,
                    // Horizontal List of Categories
                    categoriesSection(
                        screenHeight, screenWidth, groceryViewModel),
                    // Grid View List of Sub Categories
                    subCategoriesSection(
                        screenHeight, screenWidth, groceryViewModel),
                  ],
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredList[index].name),
                      onTap: () {
                        searchController.text = filteredList[index].name;
                        _onSubmitted(filteredList[index], groceryViewModel);
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoriesSection(double screenHeight, double screenWidth,
      GroceryViewModel groceryViewModel) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Select Categories",
              style: mainFont(
                  fontsize: 18,
                  fontweight: FontWeight.w600,
                  color: FbColors.greendark),
            ),
            TextButton(
              onPressed: () {
                navigate(
                    context: context,
                    screen: AllGroceryCategoriesScreen(
                      categories: groceryViewModel.categories,
                      subCategories: groceryViewModel.subCategories,
                    ));
              },
              child: const Text(
                "View All",
                style: TextStyle(
                    color: Colors.grey, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
        // Category List Horizontal
        SizedBox(
          height: screenHeight * .17,
          child: Consumer<GroceryViewModel>(
            builder: (context, data, _) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.categories.length,
                itemBuilder: (context, index) {
                  return categoryCard(
                    text: data.categories[index].name,
                    onTap: () {
                      // Handle category tap
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
    );
  }

  Widget subCategoriesSection(double screenHeight, double screenWidth,
      GroceryViewModel groceryViewModel) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Select Sub Categories",
              style: mainFont(
                  fontsize: 18,
                  fontweight: FontWeight.w600,
                  color: FbColors.greendark),
            ),
            if (groceryViewModel.subCategories.isNotEmpty)
              TextButton(
                onPressed: () {
                  navigate(
                      context: context,
                      screen: AllGrocerySubCategoryScreen(
                        subCategories: groceryViewModel.subCategories,
                        categories: groceryViewModel.categories,
                      ));
                },
                child: const Text(
                  "View All",
                  style: TextStyle(
                      color: Colors.grey, decoration: TextDecoration.underline),
                ),
              )
          ],
        ),
        SizedBox(
          height: screenHeight * 0.5, // Constrain height for GridView
          child: Consumer<GroceryViewModel>(
            builder: (context, data, _) {
              return GridView.builder(
                padding: const EdgeInsets.all(5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: .57,
                    crossAxisSpacing: 14),
                itemCount: data.subCategories.length,
                itemBuilder: (context, index) {
                  return subCategoryCard(
                    height: screenWidth * 0.33,
                    text: data.subCategories[index].name,
                    image: data.subCategories[index].subcategoryImage ?? '',
                    onTap: () {
                      // Handle subcategory tap
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
