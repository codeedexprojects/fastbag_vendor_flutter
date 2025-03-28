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
  int? _colorisSelected;
  int? _sizeisSelected;
  String? size;
  dynamic prize;
  int? Stock;
  bool _prizeInitialized = false;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final _viewModel =
        Provider.of<FashionProductViewModel>(context, listen: false);
    try {
      await _viewModel.fetchFashionProductDetail(widget.productId);
      if (_viewModel.fashionProductDetail != null) {
        _initializeSelections(_viewModel);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load product details';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _initializeSelections(FashionProductViewModel viewModel) {
    final product = viewModel.fashionProductDetail!;
    if (product.colors?.isNotEmpty ?? false) {
      _colorisSelected = 0;
      final firstColor = product.colors!.first;
      if (firstColor.sizes?.isNotEmpty ?? false) {
        _sizeisSelected = 0;
        prize = firstColor.sizes!.first.offerPrice ?? product.price;
        Stock = firstColor.sizes!.first.stock;
      }
    }
    _prizeInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final _viewModel = Provider.of<FashionProductViewModel>(context);

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: FbColors.backgroundcolor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Product Details',
          style: mainFont(
            fontsize: 16,
            fontweight: FontWeight.w600,
            color: FbColors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * .07,
            vertical: screenHeight * .01,
          ),
          child: Column(
            children: [
              _buildMainImage(_viewModel, screenWidth),
              const SizedBox(height: 24.78),
              _buildThumbnailList(_viewModel, screenWidth),
              const SizedBox(height: 36),
              _buildProductHeader(_viewModel, screenWidth),
              _buildMaterialAndRating(_viewModel),
              _buildStockInfo(),
              if (_viewModel.fashionProductDetail?.colors?.isNotEmpty == true)
                _buildColorSection(_viewModel),
              if (_hasValidSizes(_viewModel)) _buildSizeSelection(_viewModel),
              const SizedBox(height: 17),
              const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 34,
                endIndent: 34,
              ),
              const SizedBox(height: 14),
              _buildDescription(_viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainImage(
      FashionProductViewModel viewModel, double screenWidth) {
    final imageUrl = imageIndex ??
        viewModel.fashionProductDetail?.images?.firstOrNull?.image ??
        PlaceholderImage.placeholderimage;

    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        height: 336.22,
        width: 336,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.fill,
            placeholder: (context, url) =>
                Image.asset(PlaceholderImage.placeholderimage),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error_outline),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnailList(
      FashionProductViewModel viewModel, double screenWidth) {
    final images = viewModel.fashionProductDetail?.images ?? [];
    return SizedBox(
      height: 60,
      width: 340,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) =>
            _buildThumbnailItem(images[index].image ?? '', index),
      ),
    );
  }

  Widget _buildThumbnailItem(String imageUrl, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: () => setState(() {
          imageIndex = imageUrl;
          _isSelected = index;
        }),
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: _isSelected == index ? 20.0 : 0,
              ),
            ],
            border: Border.all(
              color: const Color.fromRGBO(94, 177, 78, 1),
              width: _isSelected == index ? 1 : 0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Image.asset(PlaceholderImage.placeholderimage),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error_outline),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductHeader(
      FashionProductViewModel viewModel, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: screenWidth * 0.5,
          child: Text(
            viewModel.fashionProductDetail?.name ?? 'No product name',
            style: normalFont5(
              fontsize: screenWidth * 0.05,
              fontweight: FontWeight.w400,
              color: FbColors.black,
            ),
          ),
        ),
        Text(
          '₹${prize ?? viewModel.fashionProductDetail?.price ?? 'N/A'}',
          style: normalFont5(
            fontsize: screenWidth * 0.05,
            fontweight: FontWeight.w400,
            color: FbColors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildMaterialAndRating(FashionProductViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          viewModel.fashionProductDetail?.material ?? 'Material not specified',
          style: normalFont4(
            fontsize: 16,
            fontweight: FontWeight.w400,
            color: FbColors.black,
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.star,
              size: 16,
              color: Color.fromRGBO(231, 176, 8, 1),
            ),
            Text(
              '4.8(100+ reviews)',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: const Color.fromRGBO(17, 24, 39, 1),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildStockInfo() {
    return Row(
      children: [
        Text(
          'Available Stock : ${Stock ?? 'N/A'} units',
          style: normalFont5(
            fontsize: 15,
            fontweight: FontWeight.w500,
            color: Colors.red,
          ),
        )
      ],
    );
  }

  Widget _buildColorSection(
    _viewModel,
  ) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: _viewModel.fashionProductDetail?.colors?.length ?? 0,
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
                        _colorisSelected = index;
                        _sizeisSelected = 0; // Reset size selection
                        // Update price to new color's first size
                        if (_viewModel.fashionProductDetail?.colors![index]
                                    .sizes !=
                                null &&
                            _viewModel.fashionProductDetail?.colors![index]
                                    .sizes !=
                                null &&
                            _viewModel.fashionProductDetail!.colors![index]
                                .sizes!.isNotEmpty) {
                          final newColor =
                              _viewModel.fashionProductDetail?.colors?[index];

                          final newSize = newColor?.sizes?.first;
                          prize = newSize?.offerPrice ??
                              _viewModel.fashionProductDetail?.price;
                          Stock = newSize?.stock ?? 0;
                        }
                      });
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: ImageUrl.toColor(),
                        borderRadius: BorderRadius.circular(55),
                        border: Border.all(
                            width: _colorisSelected == index ? 2 : 0,
                            color: Colors.blue),
                      ),
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }

  bool _hasValidSizes(FashionProductViewModel viewModel) {
    if (_colorisSelected == null) return false;
    final color = viewModel.fashionProductDetail?.colors?[_colorisSelected!];
    return color?.sizes?.isNotEmpty ?? false;
  }

  Widget _buildSizeSelection(FashionProductViewModel viewModel) {
    final sizes =
        viewModel.fashionProductDetail!.colors![_colorisSelected!].sizes!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          'Size',
          style: normalFont1(
            fontsize: 20,
            fontweight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sizes.length,
            itemBuilder: (context, index) =>
                _buildSizeItem(sizes[index], index, viewModel),
          ),
        ),
      ],
    );
  }

  Widget _buildSizeItem(size, int index, viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => _handleSizeSelection(size, index, viewModel),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: _sizeisSelected == index ? 2 : 0,
            ),
          ),
          child: Center(
            child: Text(size.size ?? ''),
          ),
        ),
      ),
    );
  }

  void _handleSizeSelection(size, int index, viewModel) {
    setState(() {
      _sizeisSelected = index;
      prize = size.offerPrice ?? viewModel.fashionProductDetail?.price;
      Stock = size.stock;
    });
  }

  Widget _buildDescription(FashionProductViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 335,
        child: Text(
          viewModel.fashionProductDetail?.description ??
              'No description available',
          style: normalFont4(
            fontsize: 16,
            fontweight: FontWeight.w400,
            color: FbColors.black,
          ),
        ),
      ),
    );
  }
} // Update your color extension to handle more cases

extension ColorConversion on String? {
  Color toColor({Color fallback = Colors.grey}) {
    if (this == null || this!.isEmpty) return fallback;
    final hexCode = this!.replaceFirst('#', '');
    try {
      return Color(int.parse('FF$hexCode', radix: 16));
    } catch (e) {
      return fallback;
    }
  }
}

extension FirstOrNull<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

// class FashionProductDetailScreen extends StatefulWidget {
//   final int productId;

//   const FashionProductDetailScreen({Key? key, required this.productId})
//       : super(key: key);

//   @override
//   State<FashionProductDetailScreen> createState() =>
//       _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<FashionProductDetailScreen> {
//   String? imageIndex;
//   int? _isSelected;
//   int? _colorisSelected;
//   int? _sizeisSelected;
//   String? size;
//   dynamic prize;
//   int? Stock;
//   bool _prizeInitialized = false;

//   @override
//   void initState() {
//     print(widget.productId);
//     final _viewModel =
//         Provider.of<FashionProductViewModel>(context, listen: false);
//     _viewModel.fetchFashionProductDetail(widget.productId);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final _viewModel = Provider.of<FashionProductViewModel>(context);

//     if (_viewModel.fashionProductDetail != null && !_prizeInitialized) {
//       final initialColor =
//           _viewModel.fashionProductDetail?.colors?[_colorisSelected ?? 0];
//       final initialSize = initialColor?.sizes?[_sizeisSelected ?? 0];
//       prize = initialSize?.price ?? _viewModel.fashionProductDetail?.price;
//       Stock = initialSize?.stock ??
//           _viewModel.fashionProductDetail?.colors?.first.sizes?.first.stock;
//       _prizeInitialized = true;
//     }

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
//                               _viewModel
//                                   .fashionProductDetail!.images!.isNotEmpty)
//                           ? ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: CachedNetworkImage(
//                                 imageUrl: imageIndex ??
//                                     _viewModel.fashionProductDetail?.images
//                                         ?.first.image ??
//                                     "",
//                                 fit: BoxFit.fill,
//                                 placeholder: (context, url) => Image.asset(
//                                     PlaceholderImage.placeholderimage),
//                                 errorWidget: (context, url, error) =>
//                                     Icon(Icons.downloading),
//                               ),
//                             )
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
//                       _viewModel.fashionProductDetail?.images?.length ?? 0,
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
//                     '₹${prize ?? _viewModel.fashionProductDetail?.price ?? '00'}',
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
//                     'Available Stock : ${Stock ?? _viewModel.fashionProductDetail?.totalStock ?? 0} units',
//                     style: normalFont5(
//                         fontsize: 15,
//                         fontweight: FontWeight.w500,
//                         color: Colors.red),
//                   )
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
//               if (_viewModel.fashionProductDetail?.colors?.isNotEmpty == true)
//                 Container(
//                   height: 80,
//                   child: ListView.builder(
//                       itemCount:
//                           _viewModel.fashionProductDetail?.colors?.length ?? 0,
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (context, index) {
//                         final ImageUrl =
//                             "${_viewModel.fashionProductDetail?.colors?[index].colorCode ?? ''}";
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 4),
//                           child: Column(
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     _colorisSelected = index;
//                                     _sizeisSelected = 0; // Reset size selection
//                                     // Update price to new color's first size
//                                     if (_viewModel.fashionProductDetail
//                                                 ?.colors![index].sizes !=
//                                             null &&
//                                         _viewModel.fashionProductDetail
//                                                 ?.colors![index].sizes !=
//                                             null &&
//                                         _viewModel.fashionProductDetail!
//                                             .colors![index].sizes!.isNotEmpty) {
//                                       final newColor = _viewModel
//                                           .fashionProductDetail?.colors?[index];

//                                       final newSize = newColor?.sizes?.first;
//                                       prize = newSize?.price ??
//                                           _viewModel
//                                               .fashionProductDetail?.price;
//                                       Stock = newSize?.stock ?? 0;
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   height: 60,
//                                   width: 60,
//                                   decoration: BoxDecoration(
//                                       color: ImageUrl.toColor(),
//                                       borderRadius: BorderRadius.circular(55),
//                                       border: Border.all(
//                                           width:
//                                               _colorisSelected == index ? 2 : 0,
//                                           color: Colors.blue)),
//                                   // child: CachedNetworkImage(
//                                   //   height: 70,
//                                   //   width: 70,
//                                   //   fit: BoxFit.fill,
//                                   //   errorWidget: (context, url, error) =>
//                                   //       Image.asset(
//                                   //     height: 50,
//                                   //     width: 50,
//                                   //     fit: BoxFit.cover,
//                                   //     PlaceholderImage.placeholderimage,
//                                   //   ),
//                                   //   placeholder: (context, url) => Image.asset(
//                                   //       fit: BoxFit.fill,
//                                   //       height: 50,
//                                   //       width: 50,
//                                   //       PlaceholderImage.placeholderimage),
//                                   //   imageUrl: ImageUrl,
//                                   // ),
//                                 ),
//                               ),
//                               // SizedBox(
//                               //   height: 5,
//                               // ),
//                               // Text(
//                               //     '${_viewModel.fashionProductDetail?.colors?[index].colorName ?? 0}')
//                             ],
//                           ),
//                         );
//                       }),
//                 ),
//               if (_viewModel.fashionProductDetail?.colors != null &&
//                   _viewModel.fashionProductDetail!.colors!.isNotEmpty &&
//                   _viewModel.fashionProductDetail != null &&
//                   _viewModel.fashionProductDetail!.colors != null &&
//                   _viewModel.fashionProductDetail!
//                           .colors![_colorisSelected ?? 0].sizes !=
//                       null &&
//                   _viewModel.fashionProductDetail!
//                       .colors![_colorisSelected ?? 0].sizes!.isNotEmpty) ...[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Size',
//                       style: normalFont1(
//                           fontsize: 20,
//                           fontweight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   height: 50,
//                   child: ListView.builder(
//                       itemCount: _viewModel.fashionProductDetail
//                               ?.colors?[_colorisSelected ?? 0].sizes?.length ??
//                           0,
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (context, index) {
//                         final sizeItem = _viewModel.fashionProductDetail
//                             ?.colors?[_colorisSelected ?? 0].sizes?[index];
//                         final sizeUrl = sizeItem?.size ?? "";
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 _sizeisSelected = index;
//                                 final selectedSize = sizeItem;
//                                 prize = selectedSize?.price ??
//                                     _viewModel.fashionProductDetail?.price;
//                                 Stock = sizeItem?.stock ?? 0;
//                               });
//                             },
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                       color: Colors.grey,
//                                       width: _sizeisSelected == index ? 2 : 0)),
//                               child: Center(
//                                 child: Text(sizeUrl),
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                 ),
//               ],
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
