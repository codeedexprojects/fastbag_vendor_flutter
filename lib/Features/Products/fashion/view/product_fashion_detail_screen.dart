import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/fooddetail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../Commons/colors.dart';
import '../../../../Commons/fonts.dart';
import '../../../../Commons/placeholder.dart';
import '../view_model/fashiondetail_view_model.dart';

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
  String? selectedColor;
  String? selectedSize;

  @override
  void initState() {
    final _viewModel =
        Provider.of<FashiondetailViewModel>(context, listen: false);
    _viewModel.getfashiondata(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final _viewModel = Provider.of<FashiondetailViewModel>(context);
    return Scaffold(
      appBar: AppBar(
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(360)),
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      height: 336.22,
                      width: 336,
                      child: CachedNetworkImage(
                        imageUrl: imageIndex ??
                            _viewModel.fashionDetail?.images?.first.image ??
                            "",
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            Image.asset(PlaceholderImage.placeholderimage),
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
                  itemCount: _viewModel.fashionDetail?.images?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final imageUrl =
                        _viewModel.fashionDetail?.images?[index].image ?? '';
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
                  Text(
                    _viewModel.fashionDetail?.name ?? '',
                    style: normalFont5(
                        fontsize: 20,
                        fontweight: FontWeight.w400,
                        color: FbColors.black),
                  ),
                  Text(
                    '₹${_viewModel.fashionDetail?.price ?? '₹00'}',
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
                    '${_viewModel.fashionDetail?.category ?? 0}',
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Color',style: normalFont1(fontsize: 20, fontweight: FontWeight.bold, color: Colors.black),),
                ],
              ),
              Container(
                height: 70,
                child: ListView.builder(
                    itemCount: _viewModel.fashionDetail?.colors?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                        
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(55),
                            border: Border.all(
                              width: 4
                                  ,color: FbColors.black
                            )
                          ),
                          child: CachedNetworkImage(
                              height: 70,
                              width: 70,
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) => Image.asset(
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    PlaceholderImage.placeholderimage,
                                  ),
                              placeholder: (context, url) => Image.asset(
                                  fit: BoxFit.fill,
                                  height: 50,
                                  width: 50,
                                  PlaceholderImage.placeholderimage),
                              imageUrl:
                                  "$imageUrl${_viewModel.fashionDetail?.colors?[index].colorImage ?? ''}"),
                        ),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Size',style: normalFont1(fontsize: 20, fontweight: FontWeight.bold, color: Colors.black),),
                ],
              ),
              Container(
                height: 50,
                child: ListView.builder(
                    itemCount:
                        _viewModel.fashionDetail?.colors?.first.sizes?.length ??
                            0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black)
                          ),
                          child: Center(
                            child: Text(_viewModel.fashionDetail?.colors?.first.sizes?[index].size ??
                                ""),
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
                  // color: Colors.black,
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        _viewModel.fashionDetail?.description ??
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
