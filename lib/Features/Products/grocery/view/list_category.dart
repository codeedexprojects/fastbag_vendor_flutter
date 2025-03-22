import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/ViewModel/grocery_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCategoriesName extends StatefulWidget {
  const ListCategoriesName({super.key});

  @override
  State<ListCategoriesName> createState() => _ListCategoriesNameState();
}

class _ListCategoriesNameState extends State<ListCategoriesName> {
  @override
  void initState() {
    var groceryViewModel =
        Provider.of<GroceryViewModel>(context, listen: false);
    groceryViewModel.fetchGroceryCategory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var groceryViewModel = Provider.of<GroceryViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FbColors.backgroundcolor,
        title: Text(
          "Categories",
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
                var category = groceryViewModel.categories[index];
                return ListTile(
                  onTap: () {
                    Navigator.pop(context, category);
                  },
                  leading: CircleAvatar(
                    radius: 32,
                    backgroundColor:
                        Colors.grey[200], // Optional: Background color
                    child: ClipOval(
                      child: groceryViewModel.categories[index].categoryImage ==
                              null
                          ? Image.asset('assets/Images/grocery.jpeg')
                          : Image.network(
                              groceryViewModel
                                      .categories[index].categoryImage ??
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
                    groceryViewModel.categories[index].name ?? "no name",
                    style: nunito(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: groceryViewModel.categories.length)
        ],
      ),
    );
  }
}
