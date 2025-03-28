// <<<<<<< HEAD
// import 'package:fastbag_vendor_flutter/Commons/circle_icon.dart';
// import 'package:fastbag_vendor_flutter/Commons/colors.dart';
// import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
// import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
// import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
// import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
// import 'package:fastbag_vendor_flutter/Features/Products/Model/category_model.dart';
// import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
// import 'package:fastbag_vendor_flutter/Features/Products/View/add_sub_category_screen.dart';
// import 'package:fastbag_vendor_flutter/Features/Products/View/list_products_screen.dart';
// import 'package:fastbag_vendor_flutter/Features/Products/View/sub_category_edit_list.dart';
// import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_catgeory_model.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class AllSubCategoryScreen extends StatelessWidget {
//   final List<CategoryModel> categories;
//   final List<SubCategoryModel> subCategories;
//   final bool isOperable;
//   const AllSubCategoryScreen(
//       {super.key,
//       required this.subCategories,
//       required this.categories,
//       required this.isOperable});
//
//   @override
//   Widget build(BuildContext context) {
//     print("subcategories :- $subCategories");
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: FbColors.backgroundcolor,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(
//               Icons.arrow_back_ios_new), // Replace with your desired icon
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: Text(
//           "All Sub Categories",
//           style: mainFont(
//               fontsize: screenWidth * 0.05,
//               fontweight: FontWeight.w500,
//               color: Colors.black),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //   children: [
//             //     SizedBox(
//             //       width: screenWidth * 0.8,
//             //       child: SearchBar(
//             //         backgroundColor: const WidgetStatePropertyAll(Colors.white),
//             //         elevation: const WidgetStatePropertyAll(0),
//             //         shape: WidgetStatePropertyAll(RoundedRectangleBorder(
//             //             borderRadius: BorderRadius.circular(5))),
//             //         side: WidgetStatePropertyAll(
//             //             BorderSide(color: FbColors.black, width: 0.5)),
//             //         trailing: const [
//             //           Icon(
//             //             Icons.search,
//             //             size: 35,
//             //           )
//             //         ],
//             //         hintText: "search here",
//             //       ),
//             //     ),
//             //     const Icon(Icons.more_vert)
//             //   ],
//             // ),
//             SizedBox(
//               height: screenHeight * .02,
//             ),
//             Text(
//               subCategories.isNotEmpty
//                   ? "Select Sub Categories"
//                   : "No Sub Categories added",
//               style: mainFont(
//                   fontsize: 18,
//                   fontweight: FontWeight.w600,
//                   color: FbColors.greendark),
//             ),
//             SizedBox(
//               height: screenHeight * .02,
//             ),
//             subCategories.isNotEmpty
//                 ? Expanded(
//                     child: GridView.builder(
//                     padding: const EdgeInsets.all(5),
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             childAspectRatio: 0.57,
//                             crossAxisSpacing: 14),
//                     itemCount: subCategories.length,
//                     itemBuilder: (context, index) {
//                       return subCategoryCard(
//                         height: screenWidth * 0.33,
//                         text: subCategories[index].name,
//                         image: subCategories[index].sub_category_image,
//                         onTap: () {
//                           navigate(
//                             context: context,
//                             screen: ListProductsScreen(
//                               subCategory: subCategories[index],
//                               subCategories: subCategories,
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ))
//                 : const Center(
//                     child: Text("Start adding your sub category now"),
//                   ),
//             if (isOperable)
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: screenWidth / 15, vertical: 5),
//                 child: FbButton(
//                     onClick: () {
//                       navigate(
//                           context: context,
//                           screen: AddSubCategoryScreen(
//                             categories: categories,
//                           ));
//                     },
//                     label: "+ Add Category"),
//               ),
//             if (isOperable && subCategories.isNotEmpty)
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: screenWidth / 15, vertical: 5),
//                 child: FbButton(
//                   onClick: () {
//                     // navigate(
//                     //     context: context,
//                     //     screen: SubCategoryEditList(
//                     //       subCategories: subCategories,
//                     //       categories: categories,
//                     //     ));
//                   },
//                   icon: const FaIcon(
//                     FontAwesomeIcons.penToSquare,
//                     size: 20,
//                   ),
//                   label: "Edit",
//                   color: Colors.white,
//                   textColor: Colors.blue,
//                   borderColor: Colors.blue,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// =======
// // import 'package:fastbag_vendor_flutter/Commons/circle_icon.dart';
// // import 'package:fastbag_vendor_flutter/Commons/colors.dart';
// // import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
// // import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
// // import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
// // import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
// // import 'package:fastbag_vendor_flutter/Features/Products/Model/category_model.dart';
// // import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
// // import 'package:fastbag_vendor_flutter/Features/Products/View/add_sub_category_screen.dart';
// // import 'package:fastbag_vendor_flutter/Features/Products/View/list_products_screen.dart';
// // import 'package:fastbag_vendor_flutter/Features/Products/View/sub_category_edit_list.dart';
// // import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_catgeory_model.dart';
// // import 'package:flutter/material.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// //
// // class AllSubCategoryScreen extends StatelessWidget {
// //   final List<CategoryModel> categories;
// //   final List<SubCategoryModel> subCategories;
// //   final bool isOperable;
// //   const AllSubCategoryScreen(
// //       {super.key,
// //       required this.subCategories,
// //       required this.categories,
// //       required this.isOperable});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     print("subcategories :- $subCategories");
// //     double screenHeight = MediaQuery.of(context).size.height;
// //     double screenWidth = MediaQuery.of(context).size.width;
// //     return Scaffold(
// //       appBar: AppBar(
// //         centerTitle: true,
// //         leading: IconButton(
// //           icon: const Icon(
// //               Icons.arrow_back_ios_new), // Replace with your desired icon
// //           onPressed: () {
// //             Navigator.of(context).pop();
// //           },
// //         ),
// //         title: Text(
// //           "All Sub Categories",
// //           style: mainFont(
// //               fontsize: screenWidth * 0.05,
// //               fontweight: FontWeight.w500,
// //               color: Colors.black),
// //         ),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 20),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Row(
// //             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             //   children: [
// //             //     SizedBox(
// //             //       width: screenWidth * 0.8,
// //             //       child: SearchBar(
// //             //         backgroundColor: const WidgetStatePropertyAll(Colors.white),
// //             //         elevation: const WidgetStatePropertyAll(0),
// //             //         shape: WidgetStatePropertyAll(RoundedRectangleBorder(
// //             //             borderRadius: BorderRadius.circular(5))),
// //             //         side: WidgetStatePropertyAll(
// //             //             BorderSide(color: FbColors.black, width: 0.5)),
// //             //         trailing: const [
// //             //           Icon(
// //             //             Icons.search,
// //             //             size: 35,
// //             //           )
// //             //         ],
// //             //         hintText: "search here",
// //             //       ),
// //             //     ),
// //             //     const Icon(Icons.more_vert)
// //             //   ],
// //             // ),
// //             SizedBox(
// //               height: screenHeight * .02,
// //             ),
// //             Text(
// //               subCategories.isNotEmpty
// //                   ? "Select Sub Categories"
// //                   : "No Sub Categories added",
// //               style: mainFont(
// //                   fontsize: 18,
// //                   fontweight: FontWeight.w600,
// //                   color: FbColors.greendark),
// //             ),
// //             SizedBox(
// //               height: screenHeight * .02,
// //             ),
// //             subCategories.isNotEmpty
// //                 ? Expanded(
// //                     child: GridView.builder(
// //                     padding: const EdgeInsets.all(5),
// //                     gridDelegate:
// //                         const SliverGridDelegateWithFixedCrossAxisCount(
// //                             crossAxisCount: 3,
// //                             childAspectRatio: 0.57,
// //                             crossAxisSpacing: 14),
// //                     itemCount: subCategories.length,
// //                     itemBuilder: (context, index) {
// //                       return subCategoryCard(
// //                         height: screenWidth * 0.33,
// //                         text: subCategories[index].name,
// //                         image: subCategories[index].sub_category_image,
// //                         onTap: () {
// //                           navigate(
// //                             context: context,
// //                             screen: ListProductsScreen(
// //                               subCategory: subCategories[index],
// //                               subCategories: subCategories,
// //                             ),
// //                           );
// //                         },
// //                       );
// //                     },
// //                   ))
// //                 : const Center(
// //                     child: Text("Start adding your sub category now"),
// //                   ),
// //             if (isOperable)
// //               Padding(
// //                 padding: EdgeInsets.symmetric(
// //                     horizontal: screenWidth / 15, vertical: 5),
// //                 child: FbButton(
// //                     onClick: () {
// //                       navigate(
// //                           context: context,
// //                           screen: AddSubCategoryScreen(
// //                             categories: categories,
// //                           ));
// //                     },
// //                     label: "+ Add Category"),
// //               ),
// //             if (isOperable && subCategories.isNotEmpty)
// //               Padding(
// //                 padding: EdgeInsets.symmetric(
// //                     horizontal: screenWidth / 15, vertical: 5),
// //                 child: FbButton(
// //                   onClick: () {
// //                     // navigate(
// //                     //     context: context,
// //                     //     screen: SubCategoryEditList(
// //                     //       subCategories: subCategories,
// //                     //       categories: categories,
// //                     //     ));
// //                   },
// //                   icon: const FaIcon(
// //                     FontAwesomeIcons.penToSquare,
// //                     size: 20,
// //                   ),
// //                   label: "Edit",
// //                   color: Colors.white,
// //                   textColor: Colors.blue,
// //                   borderColor: Colors.blue,
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// >>>>>>> 7317fe5cc4d2705ece17318cddd70f852b5e77be
