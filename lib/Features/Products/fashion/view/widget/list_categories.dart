import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/category_request_model.dart';
import '../../view_model/fashion_category_view_model.dart';

class ListCategoriesName extends StatefulWidget {
  const ListCategoriesName({super.key});

  @override
  State<ListCategoriesName> createState() => _ListCategoriesNameState();
}

class _ListCategoriesNameState extends State<ListCategoriesName> {
  @override
  void initState() {
    var categoryProvider =
    Provider.of<FashionCategoryViewModel>(context, listen: false);
    categoryProvider.getfashionProductCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<FashionCategoryViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: nunito(
              color: Colors.black, fontSize: 16, fontBold: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var category = categoryProvider.categories[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(
                          context,
                          CategoryRequestModel(
                            id: category?.id,
                            name: category?.name,
                          ));
                    },
                    child: Text(
                      categoryProvider.categories[index]?.name ?? "",
                      style: nunito(
                          color: Colors.black,
                          fontSize: 16,
                          fontBold: FontWeight.w500),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: categoryProvider.categories.length)
        ],
      ),
    );
  }
}