import 'package:fastbag_vendor_flutter/Commons/circle_icon.dart';
import 'package:fastbag_vendor_flutter/Commons/text_field_decortion.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/serach_item.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/list_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/category_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/all_categories_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/all_sub_category_screen.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _ListCategoryScreenState();
}

class _ListCategoryScreenState extends State<CategoryScreen> {
  late List<SerachItem> combinedList =
      []; // Combined list of categories and subcategories
  List<SerachItem> filteredList = []; // Filtered list for search suggestions
  final TextEditingController searchController =
      TextEditingController(); // SearchBar controller
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Fetch categories and subcategories asynchronously using provider
    var categoryProvider =
        Provider.of<CategoryViewModel>(context, listen: false);
    categoryProvider.getProductCategories(context: context);
    categoryProvider.getProductSubCategories(context: context);
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

  void _onSubmitted(SerachItem item) {
    var categoryProvider =
        Provider.of<CategoryViewModel>(context, listen: false);
    // Handle search submission
    print('Search submitted: $item');
    if (item.type == "category") {
      navigate(
          context: context,
          screen: AllCategoriesScreen(
              categories: [item.model],
              subCategories: categoryProvider.subCategories));
    } else {
      navigate(
          context: context,
          screen: AllSubCategoryScreen(
              subCategories: [item.model],
              categories: categoryProvider.categories,
              isOperable: false));
    }
    setState(() {
      filteredList = []; // Optionally clear search results after submission
    });
  }

  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<CategoryViewModel>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Ensure categories and subcategories are loaded
    if (categoryProvider.categories.isNotEmpty ||
        categoryProvider.subCategories.isNotEmpty) {
      // Combine category and subcategory names once data is available
      List<SerachItem> categoryItems = categoryProvider.categories.isNotEmpty
          ? categoryProvider.categories
              .map<SerachItem>((category) => SerachItem(
                  id: category.id,
                  name: category.name,
                  type: "category",
                  model: category))
              .toList()
          : [];
      List<SerachItem> subCategoryItems =
          categoryProvider.subCategories.isNotEmpty
              ? categoryProvider.subCategories
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
      //resizeToAvoidBottomInset: true,
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
              if (filteredList.isEmpty)
                Expanded(
                    child: Column(
                  children: [
                    if (searchController.text.isNotEmpty)
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenWidth * 0.07),
                        child: const Text("No results"),
                      ),
                    gap,
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
                                screen: AllCategoriesScreen(
                                  categories: categoryProvider.categories,
                                  subCategories: categoryProvider.subCategories,
                                ));
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    //  category  List  Horzontal
                    SizedBox(
                      height: screenHeight * .17,
                      child: Consumer<CategoryViewModel>(
                        builder: (context, data, _) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.categories.length,
                            itemBuilder: (context, index) {
                              return categoryCard(
                                text: data.categories[index].name,
                                onTap: () {
                                  navigate(
                                    context: context,
                                    screen: AllSubCategoryScreen(
                                      subCategories: data.subCategories,
                                      categories: data.categories,
                                      isOperable: true,
                                    ),
                                  );
                                },
                                radius: screenWidth * .115,
                                image: NetworkImage(
                                  data.categories[index].category_image,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
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
                        if (categoryProvider.subCategories.isNotEmpty)
                          TextButton(
                            onPressed: () {
                              navigate(
                                context: context,
                                screen: AllSubCategoryScreen(
                                  subCategories: categoryProvider.subCategories,
                                  categories: categoryProvider.categories,
                                  isOperable: false,
                                ),
                              );
                            },
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                      ],
                    ),
                    Expanded(
                      child: Consumer<CategoryViewModel>(
                        builder: (context, data, _) {
                          return GridView.builder(
                            padding: const EdgeInsets.all(5),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: .57,
                                    crossAxisSpacing: 14),
                            itemCount: data.subCategories.length,
                            itemBuilder: (context, index) {
                              return subCategoryCard(
                                height: screenWidth * 0.33,
                                text: data.subCategories[index].name,
                                image: data
                                    .subCategories[index].sub_category_image,
                                onTap: () {
                                  navigate(
                                    context: context,
                                    screen: ListProductsScreen(
                                      subCategory: data.subCategories[index],
                                      subCategories: data.subCategories,
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ))
              else
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredList[index].name),
                      onTap: () {
                        searchController.text = filteredList[index].name;
                        _onSubmitted(filteredList[index]);
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
}
