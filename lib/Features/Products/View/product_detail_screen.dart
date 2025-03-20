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

  const ProductDetailScreen({Key? key, required this.productId,})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? imageIndex;
  String? varientIndex;
  String selectedVariant = "";
  Map<String, dynamic>? selectedVariantDetails;
  List varients=[];
  int _isSelected = 0;

  @override
  void initState() {
    final _viewModel = Provider.of<FoodViewModel>(context, listen: false);
    _viewModel.getfooddata(widget.productId);
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    final _viewModel = Provider.of<FoodViewModel>(context);
    return Scaffold(
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
              fontsize: 16, fontweight: FontWeight.w600, color: FbColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.all(width*0.03),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(360)),
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    height: 336.22,
                    width: 336,
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
            SizedBox(
              height: 24.78,
            ),
            Container(
              height: 60,
              width: 340,
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
            SizedBox(
              height: 36,
            ),
            Padding(
              padding:  EdgeInsets.all(width*0.03),
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
                        '₹${_viewModel.foodDetail?.price ?? '₹00'}',
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
                  Text('Available Weights',style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: OrderColor.textColor)),
              // Column(
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: _viewModel.foodDetail!.variants!.map((variantMap) {
              //         String variantName = variantMap.keys.first; // Get variant name
              //
              //         return GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               selectedVariant = variantName;
              //               selectedVariantDetails = variantMap[variantName];
              //             });
              //           },
              //           child: Container(
              //             padding: EdgeInsets.all(8),
              //             margin: EdgeInsets.all(4),
              //             decoration: BoxDecoration(
              //               color: selectedVariant == variantName ? Colors.green : Colors.grey[300],
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //             child: Text(variantName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              //           ),
              //         );
              //       }).toList(),
              //     ),
              //
              //     // Show selected variant details
              //     if (selectedVariantDetails != null)
              //       Padding(
              //         padding: const EdgeInsets.all(16.0),
              //         child: Column(
              //           children: [
              //             Text("Variant: $selectedVariant", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              //             Text("Price: ₹${selectedVariantDetails!['price']}", style: TextStyle(fontSize: 16)),
              //             Text("Quantity: ${selectedVariantDetails!['quantity']}", style: TextStyle(fontSize: 16)),
              //             Text("Stock Status: ${selectedVariantDetails!['stock_status']}", style: TextStyle(fontSize: 16, color: Colors.green)),
              //           ],
              //         ),
              //       ),
              //   ],
              // );




              //
              // _viewModel.foodDetail?.variants != null
              //     ? SizedBox(
              //   height: height,
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: _viewModel.foodDetail?.variants?.length ?? 0,
              //     itemBuilder: (context, index) {
              //       var variant = _viewModel.foodDetail!.variants[index]; // Get variant map
              //       String variantName = variant.keys;
              //       var details = variant[variantName];
              //
              //       return ListTile(
              //         title: Text(variantName),
              //         // title: Text(variant.half.toString()),
              //         subtitle: Text("Price: ₹${variant.half?.price} | Quantity: ${variant.half?.quantity}" ),
              //         trailing: Text( "stock Status: ${variant.half?.stockStatus}"),
              //       );
              //     },
              //   ),
              // )
              //     : Text('no varients'),// Show nothing if variants are null,
              ],
              ),
            ),



        // _viewModel.foodDetail?.variants!= null?
            // SizedBox(
            //   height: height*0.05,
            //   child: ListView.separated(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: widget.product.weights.length,
            //     itemBuilder: (context, index) {
            //       final weight=widget.product.weights[index];
            //       bool isSelected = weight == selectedWeight;
            //       int SelctedWeightIndex=0;
            //       return GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             selectedWeight = weight;
            //             selectedPrice=weight.price;
            //             selectedWeight = weight; // Update the selected weight
            //             // Ensure weight is converted to a number correctly
            //             int weightValue = int.tryParse(weight.weight.replaceAll(RegExp(r'[^0-9]'), '')) ?? 1;
            //             // Calculate the price
            //             selectedPrice = widget.product.price * weightValue;// Calculate price
            //             totalPrice = selectedPrice * weight.quantity;
            //           });
            //         },
            //         child: Container(
            //           height: height*0.06,
            //           width: width*0.25,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(width*0.03),
            //               border: Border.all(
            //                 color: isSelected ? Colors.green : Colors.red,
            //                 width: isSelected ? 2 : 1,
            //               )
            //           ),
            //           child: Center(
            //             child: Text(weight.weight,style: GoogleFonts.nunito(
            //               color: isSelected ? Colors.green : Colors.black,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 13,
            //             )),
            //           ),
            //         ),
            //       );
            //     },
            //     separatorBuilder: (context, index) {
            //       return SizedBox(width: width*0.03,);
            //     },
            //   ),
            // ):Text('no weights'),
            Divider(
                color: Colors.grey, thickness: 1, indent: 34, endIndent: 34),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                width: 335,
                // color: Colors.black,
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      _viewModel.foodDetail?.description ??
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text',
                      style: normalFont4(
                          fontsize: 16,
                          fontweight: FontWeight.w400,
                          color: FbColors.black),
                    ),
                    // Align(alignment:Alignment.centerLeft,
                    //   child: GestureDetector(
                    //       child: Text('Read More',style: normalFont4(fontsize: 14, fontweight: FontWeight.w700, color: FbColors.black),)),
                    // )
                  ],
                ),
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
