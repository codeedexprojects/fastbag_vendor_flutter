import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/category_request_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_categoryby_subcategory.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_sub_category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../Commons/fonts.dart';
import '../../view_model/fashion_category_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/category_request_model.dart';

class ListSubcategoriesName extends StatefulWidget {
  final int? subcategoryId;

  const ListSubcategoriesName({
    super.key,
    this.subcategoryId,
  });

  @override
  State<ListSubcategoriesName> createState() => _ListSubcategoriesNameState();
}

class _ListSubcategoriesNameState extends State<ListSubcategoriesName> {
  FashionSubCategoryModel? categoryModel;

  @override
  void initState() {
    var categoryProvider =
        Provider.of<FashionCategoryViewModel>(context, listen: false);
    categoryProvider.getFashionCategorybySubCategories(
        categoryId: widget.subcategoryId ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<FashionCategoryViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sub Categories",
          style: nunito(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var category = categoryProvider.selectsubCategory[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(
                          context,
                          CategoryRequestModel(
                            id: category.id,
                            name: category.name,
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 8, bottom: 8),
                      child: Text(
                          categoryProvider.selectsubCategory[index]?.name ??
                              ""),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: categoryProvider.selectsubCategory.length)
          ],
        ),
      ),
    );
  }
}
