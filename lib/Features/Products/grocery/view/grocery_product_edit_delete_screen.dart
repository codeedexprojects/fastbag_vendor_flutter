import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';

import 'package:fastbag_vendor_flutter/Features/Products/grocery/ViewModel/grocery_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view/edit_grocery_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroceryProductEditDeleteScreen extends StatelessWidget {
  const GroceryProductEditDeleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final groceryViewModel = Provider.of<GroceryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: FbColors.backgroundcolor,
        title: Text(
          "Edit Products",
          style: mainFont(
              fontsize: screenWidth * 0.05,
              fontweight: FontWeight.w500,
              color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * .05),
        child:
            Consumer<GroceryViewModel>(builder: (context, groceryViewModel, _) {
          return ListView.builder(
              itemCount: groceryViewModel.subCategoryProducts.length,
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
                          child: groceryViewModel
                                  .subCategoryProducts[index].images.isEmpty
                              ? Image.asset('assets/Images/grocery.jpeg')
                              : Image.network(
                                  groceryViewModel.subCategoryProducts[index]
                                      .images[0].image,
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
                          groceryViewModel.subCategoryProducts[index].name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                              onTap: () {
                                navigate(
                                    context: context,
                                    screen: EditGroceryProductScreen(
                                        product: groceryViewModel
                                            .subCategoryProducts[index]));
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.blueAccent,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        backgroundColor:
                                            FbColors.backgroundcolor,
                                        title: Text(
                                          "Confirm Deletion",
                                          style: normalFont2(
                                              fontsize: 20,
                                              fontweight: FontWeight.w700,
                                              color: FbColors.black),
                                        ),
                                        content: const Text(
                                            "Are you sure you want to delete this SubCategory?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                groceryViewModel.deleteProducts(
                                                    context,
                                                    groceryViewModel
                                                        .subCategoryProducts[
                                                            index]
                                                        .id);
                                              },
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: FbColors.errorcolor),
                                              ))
                                        ]);
                                  });
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }
}
