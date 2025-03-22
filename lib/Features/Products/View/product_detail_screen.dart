import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastbag_vendor_flutter/Commons/images.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_item_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/fooddetail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../Commons/colors.dart';
import '../../../Commons/fonts.dart';
import '../../../Commons/localvariables.dart';
import '../Model/food_detail_class.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? imageIndex;
  String? varientIndex;
  var selectedVariant = "";
  var selectedVariantDetails;
  List varients = [];
  int _isSelected = 0;

  @override
  void initState() {
    final _viewModel = Provider.of<FoodViewModel>(context, listen: false);
    _viewModel.getfooddata(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    final _viewModel = Provider.of<FoodViewModel>(context);
    return Scaffold(
      backgroundColor: OrderColor.white,
      appBar: AppBar(
        backgroundColor: OrderColor.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Product Details',
          style: mainFont(
              fontsize: 18, fontweight: FontWeight.w600, color: FbColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(width * 0.03)),
                  child: Container(
                    height: height * 0.4, // Adjust height as needed
                    width: width,
                    child: CachedNetworkImage(
                      imageUrl: imageIndex ??
                          _viewModel.foodDetail?.imageUrls?.first.image ??
                          "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(
                          'assets/Images/image_5-removebg-preview.png'),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.downloading),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: Container(
                height: height * 0.09,
                width: width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _viewModel.foodDetail?.imageUrls?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final imageUrl =
                        _viewModel.foodDetail?.imageUrls?[index].image ?? '';
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: productDifferntimage(imageUrl, () {
                        setState(() {
                          imageIndex = imageUrl;
                          _isSelected = index;
                        });
                      }, index),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _viewModel.foodDetail?.name ?? '',
                        style: normalFont5(
                            fontsize: 20,
                            fontweight: FontWeight.w400,
                            color: FbColors.black),
                      ),
                      Text(
                        '₹${_viewModel.foodDetail?.price ?? '00'}',
                        style: normalFont5(
                            fontsize: 20,
                            fontweight: FontWeight.w400,
                            color: FbColors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_viewModel.foodDetail?.categoryName ?? 0}',
                        style: normalFont4(
                            fontsize: 16,
                            fontweight: FontWeight.w400,
                            color: FbColors.black),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Color.fromRGBO(231, 176, 8, 1),
                          ),
                          Text(
                            '4.8(100+ reviews)',
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(17, 24, 39, 1)),
                          ),
                        ],
                      )
                    ],
                  ),
                  Text('Available variants',
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: OrderColor.textColor)),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text('Available stocks:${_viewModel.foodDetail?.isAvailable}',
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: OrderColor.red)),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    height: height * 0.08,
                    child: ListView.separated(
                      itemCount: _viewModel.foodDetail?.variants?.length ?? 0,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        var variant = _viewModel.foodDetail?.variants?[index];

                        return GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          child: Container(
                            height: height * 0.07,
                            width: width * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width * 0.03),
                              border: Border.all(color: OrderColor.green),
                            ),
                            child: Center(
                              child: Text("${variant?.price}"),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: width * 0.03);
                      },
                    ),
                  ),
                  // SizedBox(
                  //   height: height * 0.08,
                  //   child: ListView.separated(
                  //     itemCount: _viewModel.foodDetail?.variants?.length ?? 0,
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       var variant = _viewModel.foodDetail?.variants?[index];
                  //
                  //       if (variant != null ) {
                  //         String variantName = variant[index]; // Extract "Half", "Full", "Quater"
                  //         var details = variant[variantName]; // Extract price, quantity, stock_status
                  //
                  //         return GestureDetector(
                  //           onTap: () {
                  //             setState(() {
                  //               selectedVariant = variantName; // Store variant name
                  //               selectedVariantDetails = details; // Store details map
                  //             });
                  //           },
                  //           child: Container(
                  //             height: height * 0.07,
                  //             width: width * 0.3,
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(width * 0.03),
                  //               border: Border.all(
                  //                 color: selectedVariant == variantName ? Colors.green : Colors.grey,
                  //               ),
                  //               color: selectedVariant == variantName ? Colors.green[100] : Colors.white,
                  //             ),
                  //             child: Center(
                  //               child: Text(
                  //                 variantName, // Show "Half", "Full", "Quater"
                  //                 style: TextStyle(
                  //                   fontWeight: FontWeight.bold,
                  //                   color: selectedVariant == variantName ? Colors.green : Colors.black,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       } else {
                  //         return SizedBox.shrink(); // Hide if variant is null
                  //       }
                  //     },
                  //     separatorBuilder: (BuildContext context, int index) {
                  //       return SizedBox(width: width * 0.03);
                  //     },
                  //   ),
                  // ),

                  Padding(
                    padding: EdgeInsets.all(width * 0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
// <<<<<<< HEAD
//                   children: [
//                    Text("price: ${selectedVariantDetails?['price']?? 'hh'}",style: GoogleFonts.nunito(
// =======

                      children: [
                        Text(
                          "price: ${selectedVariantDetails?['price'] ?? 'hh'}",
                          style: GoogleFonts.nunito(
//>>>>>>> 23e9d131b1e9a068e932975d5dea75215c00ad44
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                            "quantity: ${selectedVariantDetails?['quantity'] ?? 'hh'}",
                            style: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            )),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                            "stockStatus: ${selectedVariantDetails?['stock_status'] ?? 'hh'}",
                            style: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
                color: Colors.grey, thickness: 1, indent: 34, endIndent: 34),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    _viewModel.foodDetail?.description ??
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text',
                    style: normalFont4(
                        fontsize: 16,
                        fontweight: FontWeight.w400,
                        color: OrderColor.textColor),
                  ),
                  // Align(alignment:Alignment.centerLeft,
                  //   child: GestureDetector(
                  //       child: Text('Read More',style: normalFont4(fontsize: 14, fontweight: FontWeight.w700, color: FbColors.black),)),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productDifferntimage(String path, VoidCallback onTap, index) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: _isSelected == index ? 20.0 : 0,
              ),
            ],
            border: Border.all(
              color: Color.fromRGBO(94, 177, 78, 1),
              width: _isSelected == index ? 1 : 0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              path,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
