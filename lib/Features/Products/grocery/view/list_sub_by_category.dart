import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/ViewModel/grocery_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_catgeory_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListSubCategoryByCategory extends StatefulWidget {
  final GroceryCategoryModel category;
  const ListSubCategoryByCategory({super.key, required this.category});

  @override
  State<ListSubCategoryByCategory> createState() =>
      _ListSubCategoryByCategoryState();
}

class _ListSubCategoryByCategoryState extends State<ListSubCategoryByCategory> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final groceryViewModel =
        Provider.of<GroceryViewModel>(context, listen: false);
    groceryViewModel.currentPage = 1;
    groceryViewModel.hasMorePages = true;

    groceryViewModel.fetchSubCategoryForSubCategorySelection(
        context, widget.category.id);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        groceryViewModel.fetchSubCategoryForSubCategorySelection(
            context, widget.category.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final groceryViewModel = Provider.of<GroceryViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FbColors.backgroundcolor,
        title: Text(
          "Sub Categories",
          style: nunito(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.separated(
                controller: _scrollController,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var selectedSubCat =
                      groceryViewModel.subCategoriesListForSelection[index];
                  return ListTile(
                    onTap: () {
                      Navigator.pop(context, selectedSubCat);
                    },
                    leading: CircleAvatar(
                      radius: 32,
                      backgroundColor:
                          Colors.grey[200], // Optional: Background color
                      child: ClipOval(
                        child: groceryViewModel
                                    .subCategoriesListForSelection[index]
                                    .subcategoryImage ==
                                null
                            ? Image.asset('assets/Images/grocery.jpeg')
                            : Image.network(
                                groceryViewModel
                                        .subCategoriesListForSelection[index]
                                        .subcategoryImage ??
                                    '',
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
                    title: Text(
                      groceryViewModel
                              .subCategoriesListForSelection[index].name ??
                          "no name",
                      style: nunito(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount:
                    groceryViewModel.subCategoriesListForSelection.length),
          )
        ],
      ),
    );
  }
}
