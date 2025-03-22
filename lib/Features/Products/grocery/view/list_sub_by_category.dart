import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/ViewModel/grocery_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_catgeory_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_sub_category_model.dart';
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
  List<GrocerySubCategoryModel> subCategories = [];

  @override
  void initState() {
    super.initState();
    final groceryViewModel =
        Provider.of<GroceryViewModel>(context, listen: false);

    subCategories = groceryViewModel.allSubCategories
        .where((sub) => sub.category == widget.category.id)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var groceryViewModel = Provider.of<GroceryViewModel>(context);
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
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var selectedSubCat = subCategories[index];
                return ListTile(
                  onTap: () {
                    Navigator.pop(context, selectedSubCat);
                  },
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
                  title: Text(
                    subCategories[index].name ?? "no name",
                    style: nunito(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: subCategories.length)
        ],
      ),
    );
  }
}
