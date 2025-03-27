import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/fooddetail_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view_model/fashion_product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../Commons/colors.dart';
import '../../../../Commons/fonts.dart';
import '../../../../Commons/placeholder.dart';

class FashionProductDetailScreen extends StatefulWidget {
  final int productId;

  const FashionProductDetailScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<FashionProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<FashionProductDetailScreen> {
  String? imageIndex;
  int _isSelected = 0;
  int colorIndex = 0;
  int sizeIndex = 0;
  String? size;
  dynamic prize;
  int? Stock;
  bool _prizeInitialized = false;

  @override
  void initState() {
    final _viewModel =
        Provider.of<FashionProductViewModel>(context, listen: false);
    _viewModel.fetchFashionProductDetail(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final _viewModel = Provider.of<FashionProductViewModel>(context);
    var product = _viewModel.fashionProductDetail;

    if (product != null &&
        product.colors != null &&
        product.colors!.isNotEmpty) {
      if (_viewModel.fashionProductDetail != null && !_prizeInitialized) {
        final initialColor =
            _viewModel.fashionProductDetail?.colors?[colorIndex ?? 0];
        final initialSize = initialColor?.sizes?[sizeIndex ?? 0];
        if (product?.colors?.isNotEmpty == true &&
            product?.colors?[colorIndex].sizes?.isNotEmpty == true) {
          prize = initialSize?.price ?? _viewModel.fashionProductDetail?.price;
          Stock = initialSize?.stock ??
              _viewModel.fashionProductDetail?.colors?.first.sizes?.first.stock;
        }

        _prizeInitialized = true;
      }
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: FbColors.backgroundcolor,
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
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * .07, vertical: screenHeight * .01),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 11),
                child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: 336.22,
                      width: 336,
                      child: (_viewModel.fashionProductDetail?.images != null &&
                              _viewModel
                                  .fashionProductDetail!.images!.isNotEmpty)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: imageIndex ??
                                    _viewModel.fashionProductDetail?.images
                                        ?.first.image ??
                                    "",
                                fit: BoxFit.fill,
                                placeholder: (context, url) => Image.asset(
                                    PlaceholderImage.placeholderimage),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.downloading),
                              ),
                            )
                          : Image.asset(PlaceholderImage.placeholderimage)),
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
                  itemCount:
                      _viewModel.fashionProductDetail?.images?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final imageUrl =
                        _viewModel.fashionProductDetail?.images?[index].image ??
                            '';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth * 0.5,
                    child: Text(
                      _viewModel.fashionProductDetail?.name ?? '',
                      style: normalFont5(
                          fontsize: screenWidth * 0.05,
                          fontweight: FontWeight.w400,
                          color: FbColors.black),
                    ),
                  ),
                  Text(
                    '₹${prize ?? _viewModel.fashionProductDetail?.price ?? '00'}',
                    style: normalFont5(
                        fontsize: screenWidth * 0.05,
                        fontweight: FontWeight.w400,
                        color: FbColors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_viewModel.fashionProductDetail?.material ?? 0}',
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
              Row(
                children: [
                  Text(
                    'Available Stock : ${Stock ?? _viewModel.fashionProductDetail?.totalStock ?? 0} units',
                    style: normalFont5(
                        fontsize: 15,
                        fontweight: FontWeight.w500,
                        color: Colors.red),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Color',
                    style: normalFont1(
                        fontsize: 20,
                        fontweight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              if (product?.colors?.isNotEmpty == true)
                Container(
                  height: 80,
                  child: ListView.builder(
                      itemCount:
                          _viewModel.fashionProductDetail?.colors?.length ?? 0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final ImageUrl =
                            "${_viewModel.fashionProductDetail?.colors?[index].colorCode ?? ''}";
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    colorIndex = index;
                                    sizeIndex = 0; // Reset size selection
                                    // Update price to new color's first size

                                    final newColor = _viewModel
                                        .fashionProductDetail?.colors?[index];
                                    final newSize = newColor?.sizes?.first;
                                    prize = newSize?.price ??
                                        _viewModel.fashionProductDetail?.price;
                                    Stock = newSize?.stock ?? 0;
                                  });
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: ImageUrl.toColor(),
                                      borderRadius: BorderRadius.circular(55),
                                      border: Border.all(
                                          width: colorIndex == index ? 2 : 0,
                                          color: FbColors.black)),
                                  // child: CachedNetworkImage(
                                  //   height: 70,
                                  //   width: 70,
                                  //   fit: BoxFit.fill,
                                  //   errorWidget: (context, url, error) =>
                                  //       Image.asset(
                                  //     height: 50,
                                  //     width: 50,
                                  //     fit: BoxFit.cover,
                                  //     PlaceholderImage.placeholderimage,
                                  //   ),
                                  //   placeholder: (context, url) => Image.asset(
                                  //       fit: BoxFit.fill,
                                  //       height: 50,
                                  //       width: 50,
                                  //       PlaceholderImage.placeholderimage),
                                  //   imageUrl: ImageUrl,
                                  // ),
                                ),
                              ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // Text(
                              //     '${_viewModel.fashionProductDetail?.colors?[index].colorName ?? 0}')
                            ],
                          ),
                        );
                      }),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Size',
                    style: normalFont1(
                        fontsize: 20,
                        fontweight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              if (product?.colors?.isNotEmpty == true &&
                  product?.colors?[colorIndex].sizes?.isNotEmpty == true)
                Container(
                  height: 50,
                  child: ListView.builder(
                      itemCount: _viewModel.fashionProductDetail
                              ?.colors?[colorIndex ?? 0].sizes?.length ??
                          0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final sizeItem = _viewModel.fashionProductDetail
                            ?.colors?[colorIndex ?? 0].sizes?[index];
                        final sizeUrl = sizeItem?.size ?? "";
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                sizeIndex = index;
                                final selectedSize = sizeItem;
                                prize = selectedSize?.price ??
                                    _viewModel.fashionProductDetail?.price;
                                Stock = sizeItem?.stock ?? 0;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey,
                                      width: sizeIndex == index ? 2 : 0)),
                              child: Center(
                                child: Text(sizeUrl),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              SizedBox(
                height: 17,
              ),
              Divider(
                  color: Colors.grey, thickness: 1, indent: 34, endIndent: 34),
              SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: 335,
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        _viewModel.fashionProductDetail?.description ??
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text',
                        style: normalFont4(
                            fontsize: 16,
                            fontweight: FontWeight.w400,
                            color: FbColors.black),
                      ),
                    ],
                  ),
                ),
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

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
// import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/fooddetail_view_model.dart';
// import 'package:fastbag_vendor_flutter/Features/Products/fashion/view_model/fashion_product_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../Commons/colors.dart';
// import '../../../../Commons/fonts.dart';
// import '../../../../Commons/placeholder.dart';
//
// class FashionProductDetailScreen extends StatefulWidget {
//   final int productId;
//
//   const FashionProductDetailScreen({Key? key, required this.productId})
//       : super(key: key);
//
//   @override
//   State<FashionProductDetailScreen> createState() =>
//       _ProductDetailScreenState();
// }
//
// class _ProductDetailScreenState extends State<FashionProductDetailScreen> {
//   @override
//   void initState() {
//     final _viewModel =
//     Provider.of<FashionProductViewModel>(context, listen: false);
//     _viewModel.fetchFashionProductDetail(widget.productId);
//     super.initState();
//   }
//
//   int sizeIndex = 0;
//   int colorIndex = 0;
//   String? price;
//   int? selectedSizeStock;
//   String? selectedSizeValue;
//   String? selectedColor;
//   String? selectedColorName;
//   String? imageIndex;
//   int _isSelected = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final _viewModel = Provider.of<FashionProductViewModel>(context);
//     var product = _viewModel.fashionProductDetail;
//
//     if (product != null &&
//         product.colors != null &&
//         product.colors!.isNotEmpty) {
//       final initialColor =
//       product.colors!.isNotEmpty ? product.colors!.first : null;
//       final initialSize = initialColor?.sizes?.isNotEmpty == true
//           ? initialColor!.sizes!.first
//           : null;
//
//       price = initialSize?.price ?? product.price;
//       selectedSizeStock = initialSize?.stock ?? product.totalStock;
//       selectedSizeValue = initialSize?.size;
//       selectedColor = initialColor?.colorCode;
//       selectedColorName = initialColor?.colorName;
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: FbColors.backgroundcolor,
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back_ios)),
//         title: Text(
//           'Product Details',
//           style: mainFont(
//               fontsize: 16, fontweight: FontWeight.w600, color: FbColors.black),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: screenWidth * .07, vertical: screenHeight * .01),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 11),
//                 child: Center(
//                   child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10)),
//                       height: 336.22,
//                       width: 336,
//                       child: (_viewModel.fashionProductDetail?.images != null &&
//                           _viewModel
//                               .fashionProductDetail!.images!.isNotEmpty)
//                           ? ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: CachedNetworkImage(
//                           imageUrl: imageIndex ??
//                               _viewModel.fashionProductDetail?.images
//                                   ?.first.image ??
//                               "",
//                           fit: BoxFit.fill,
//                           placeholder: (context, url) => Image.asset(
//                               PlaceholderImage.placeholderimage),
//                           errorWidget: (context, url, error) =>
//                               Icon(Icons.downloading),
//                         ),
//                       )
//                           : Image.asset(PlaceholderImage.placeholderimage)),
//                 ),
//               ),
//               SizedBox(
//                 height: 24.78,
//               ),
//               Container(
//                 height: 60,
//                 width: 340,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount:
//                   _viewModel.fashionProductDetail?.images?.length ?? 0,
//                   itemBuilder: (BuildContext context, int index) {
//                     final imageUrl =
//                         _viewModel.fashionProductDetail?.images?[index].image ??
//                             '';
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                       child: productDifferntimage(imageUrl, () {
//                         setState(() {
//                           imageIndex = imageUrl;
//                           _isSelected = index;
//                         });
//                       }, index),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 36,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: screenWidth * 0.5,
//                     child: Text(
//                       _viewModel.fashionProductDetail?.name ?? '',
//                       style: normalFont5(
//                           fontsize: screenWidth * 0.05,
//                           fontweight: FontWeight.w400,
//                           color: FbColors.black),
//                     ),
//                   ),
//                   Text(
//                     '₹${price ?? product?.price ?? '00'}',
//                     style: normalFont5(
//                         fontsize: screenWidth * 0.05,
//                         fontweight: FontWeight.w400,
//                         color: FbColors.black),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '${_viewModel.fashionProductDetail?.material ?? 0}',
//                     style: normalFont4(
//                         fontsize: 16,
//                         fontweight: FontWeight.w400,
//                         color: FbColors.black),
//                   ),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.star,
//                         size: 16,
//                         color: Color.fromRGBO(231, 176, 8, 1),
//                       ),
//                       Text(
//                         '4.8(100+ reviews)',
//                         style: GoogleFonts.montserrat(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w300,
//                             color: Color.fromRGBO(17, 24, 39, 1)),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text(
//                     'Available Stock : ${selectedSizeStock ?? product?.totalStock ?? 0} units',
//                     style: normalFont5(
//                         fontsize: 15,
//                         fontweight: FontWeight.w500,
//                         color: Colors.red),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Color',
//                     style: normalFont1(
//                         fontsize: 20,
//                         fontweight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                 ],
//               ),
//               if (product?.colors?.isNotEmpty == true)
//                 Container(
//                   height: 80,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: product!.colors!.length,
//                     itemBuilder: (context, index) {
//                       final color = product.colors![index];
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             colorIndex = index;
//                             sizeIndex = 0; // Reset size when changing color
//
//                             final selectedColorItem =
//                             product.colors![colorIndex];
//                             final selectedSizeItem =
//                             selectedColorItem.sizes?.isNotEmpty == true
//                                 ? selectedColorItem.sizes!.first
//                                 : null;
//
//                             selectedColor = selectedColorItem.colorCode;
//                             selectedColorName = selectedColorItem.colorName;
//
//                             // ✅ Ensure price updates correctly
//                             price = selectedSizeItem?.price ??
//                                 selectedColorItem.sizes?[0].price ??
//                                 product.price;
//                             selectedSizeStock =
//                                 selectedSizeItem?.stock ?? product.totalStock;
//                             selectedSizeValue = selectedSizeItem?.size ?? "";
//
//                             print(
//                                 "Color Changed: ${selectedColorItem.colorName}, Price: $price");
//                           });
//                         },
//                         child: Container(
//                           height: 60,
//                           width: 60,
//                           decoration: BoxDecoration(
//                             color: color.colorCode?.toColor(),
//                             borderRadius: BorderRadius.circular(50),
//                             border: Border.all(
//                               width: colorIndex == index ? 2 : 0,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Size',
//                     style: normalFont1(
//                         fontsize: 20,
//                         fontweight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                 ],
//               ),
//               if (product?.colors?.isNotEmpty == true &&
//                   product?.colors?[colorIndex].sizes?.isNotEmpty == true)
//                 Container(
//                   height: 50,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: product!.colors![colorIndex].sizes!.length,
//                     itemBuilder: (context, index) {
//                       final sizeItem =
//                       product.colors![colorIndex].sizes![index];
//
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             sizeIndex = index;
//                             price = sizeItem.price ?? product.price;
//                             selectedSizeStock =
//                                 sizeItem.stock ?? product.totalStock;
//                             selectedSizeValue = sizeItem.size ?? "";
//
//                             print(
//                                 "Size Changed: ${sizeItem.size}, Price: $price");
//                           });
//                         },
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(
//                               color: sizeIndex == index
//                                   ? Colors.black
//                                   : Colors.grey,
//                               width: sizeIndex == index ? 2 : 0,
//                             ),
//                           ),
//                           child: Center(child: Text(sizeItem.size ?? "")),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               SizedBox(
//                 height: 17,
//               ),
//               Divider(
//                   color: Colors.grey, thickness: 1, indent: 34, endIndent: 34),
//               SizedBox(
//                 height: 14,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10),
//                 child: Container(
//                   width: 335,
//                   child: Column(
//                     children: [
//                       Text(
//                         textAlign: TextAlign.start,
//                         _viewModel.fashionProductDetail?.description ??
//                             'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text',
//                         style: normalFont4(
//                             fontsize: 16,
//                             fontweight: FontWeight.w400,
//                             color: FbColors.black),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget productDifferntimage(String path, VoidCallback onTap, index) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//           height: 60,
//           width: 60,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Color.fromRGBO(0, 0, 0, 0.25),
//                 blurRadius: _isSelected == index ? 20.0 : 0,
//               ),
//             ],
//             border: Border.all(
//               color: Color.fromRGBO(94, 177, 78, 1),
//               width: _isSelected == index ? 1 : 0,
//             ),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.network(
//               path,
//               fit: BoxFit.cover,
//             ),
//           )),
//     );
//   }
// }
