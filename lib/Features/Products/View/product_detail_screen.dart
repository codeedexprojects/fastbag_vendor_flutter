import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastbag_vendor_flutter/Commons/images.dart';
import 'package:fastbag_vendor_flutter/Commons/placeholder.dart';
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
  var selectedVariantDetails;
  List varients = [];
  int _isSelected = 0;
  String selectedVariant = ''; // To store the selected variant name
  dynamic selectedPrice = 0.0;
  dynamic totalPrice = 0.0;
  String? selectedAvailability;
  late VoidCallback _listener;

  @override
  void initState() {
    // final _viewModel = Provider.of<FoodViewModel>(context, listen: false);
    // _viewModel.getfooddata(widget.productId);
    // super.initState();
    // if (_viewModel.foodDetail?.variants?.isNotEmpty == true) {
    //   selectedPrice = _viewModel.foodDetail?.variants?.first.price;
    // }
    final _viewModel = Provider.of<FoodViewModel>(context, listen: false);
    _viewModel.getfooddata(widget.productId);
    _viewModel.addListener(() {
      if (_viewModel.foodDetail?.variants?.isNotEmpty == true) {
        if (mounted)
          setState(() {
            selectedPrice = _viewModel.foodDetail?.price ?? 0;
          });
        else {
          return;
        }
      }
    });
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
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * .07, vertical: height * .01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(width * 0.03),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      height: 336.22,
                      width: 336,
                      child: CachedNetworkImage(
                        imageUrl: imageIndex ??
                            _viewModel.foodDetail?.imageUrls?.first.image ??
                            "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Image.asset(PlaceholderImage.placeholderimage),
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
              Padding(
                padding: EdgeInsets.only(top: width * 0.03),
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
                          '₹${(selectedPrice ?? _viewModel.foodDetail?.price)}',
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
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Availability : ${(selectedAvailability ?? _viewModel.foodDetail?.isAvailable) == true ? "in stock" : "out of stock"}',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: OrderColor.red,
                      ),
                    ),
                    if (_viewModel.foodDetail?.variants?.isNotEmpty == true)
                      SizedBox(
                        height: height * 0.01,
                      ),
                    if (_viewModel.foodDetail?.variants?.isNotEmpty == true)
                      Text('Available variants',
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: OrderColor.textColor)),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    if (_viewModel.foodDetail?.variants?.isNotEmpty == true)
                      SizedBox(
                        height: height * 0.05,
                        child: ListView.separated(
                          itemCount:
                              _viewModel.foodDetail?.variants?.length ?? 0,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            final variant = _viewModel.foodDetail
                                ?.variants?[index]; // Get variant object
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedVariant = variant?.name ?? 'Unknown';
                                  selectedPrice = variant?.price ?? 0.0;
                                  selectedAvailability =
                                      variant?.stock ?? 'Unknown';
                                });
                              },
                              child: Container(
                                height: height * 0.06,
                                width: width * 0.25,
                                decoration: BoxDecoration(
                                  color: OrderColor.white,
                                  borderRadius:
                                      BorderRadius.circular(width * 0.03),
                                  border: Border.all(
                                    color: selectedVariant == variant?.name
                                        ? Colors
                                            .red // Highlight the selected one
                                        : OrderColor.green,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    variant?.name ?? 'No Name',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: width * 0.03);
                          },
                        ),
                      ),
                    // SizedBox(height: height * 0.02),
                    // Container(
                    //   width: width * 1,
                    //   padding: EdgeInsets.all(width * 0.03),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     color: FbColors.backgroundcolor,
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text("Variant: $selectedVariant",
                    //           style: GoogleFonts.nunito(
                    //               color: OrderColor.textColor,
                    //               fontSize: 15,
                    //               fontWeight: FontWeight.w600)),
                    //       Text("Price: ₹$selectedPrice",
                    //           style: GoogleFonts.nunito(
                    //               color: OrderColor.textColor,
                    //               fontSize: 15,
                    //               fontWeight: FontWeight.w600)),
                    //       Text("Availability: ${selectedAvailability}",
                    //           style: GoogleFonts.nunito(
                    //               color: OrderColor.textColor,
                    //               fontSize: 15,
                    //               fontWeight: FontWeight.w600)),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Divider(
                color: OrderColor.textColor.withOpacity(0.3),
                indent: width * 0.01,
                endIndent: width * 0.03,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Description",
                        style: normalFont1(
                            fontsize: 15,
                            fontweight: FontWeight.w900,
                            color: FbColors.black),
                      ),
                    ],
                  ),
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
            ],
          ),
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
