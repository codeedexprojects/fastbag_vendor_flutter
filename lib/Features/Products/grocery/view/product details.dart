import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/images.dart';
import 'package:fastbag_vendor_flutter/Commons/localvariables.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_products_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/product_view_model.dart';
import '../ViewModel/grocery_view_model.dart';

class ProductDetails extends StatefulWidget {
  final GroceryProductsModel product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Weight? selectedWeight;
  String? selectedImage;
  double? selectedPrice;

  @override
  void initState() {
    super.initState();
    if (widget.product.weights.isNotEmpty) {
      selectedWeight = widget.product.weights.first; // Ensures a default weight
      selectedPrice = selectedWeight?.price;
    } else {
      selectedPrice = widget.product.price; // Fallback to base price
    }
    if (widget.product.images.isNotEmpty) {
      selectedImage = widget.product.images.first.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    final productListProvider = Provider.of<GroceryViewModel>(context);
    final productProvider =
        Provider.of<ProductViewModel>(context, listen: false);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(width * 0.03),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  height: height * 0.4,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    image: DecorationImage(
                      image: selectedImage != null
                          ? NetworkImage(selectedImage!)
                          : AssetImage(ImagesConstants.food) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04),

                // Image Selector
                widget.product.images.isNotEmpty
                    ? SizedBox(
                        height: height * 0.1,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final image = widget.product.images[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedImage = image.image;
                                });
                              },
                              child: Container(
                                height: height * 0.09,
                                width: width * 0.19,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(image.image),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(width * 0.03),
                                  border: Border.all(
                                    color: selectedImage == image.image
                                        ? Colors.green
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: width * 0.03),
                          itemCount: widget.product.images.length,
                        ),
                      )
                    : SizedBox(),

                Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.015),

                      // Product Name & Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.name,
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                          Text(
                            selectedPrice != null
                                ? "₹$selectedPrice"
                                : "₹${widget.product.offerPrice}",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ],
                      ),

                      // Category & Ratings
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.categoryName,
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: OrderColor.black),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star_rate_rounded,
                                  color: Colors.orangeAccent),
                              Text('4.8 (100+ reviews)',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14)),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.001),

                      // Weight Selection
                      if (widget.product.weights.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Available Weights',
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                            SizedBox(height: height * 0.001),

                            // Stock Availability
                            Text(
                              (selectedWeight?.isInStock ??
                                      widget.product.available)
                                  ? 'Stock Available'
                                  : 'Out Of Stock',
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w400,
                                color: (selectedWeight?.isInStock ??
                                        widget.product.available)
                                    ? OrderColor.green
                                    : OrderColor.red,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: height * 0.015),

                            // Weight Options
                            SizedBox(
                              height: height * 0.05,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.product.weights.length,
                                itemBuilder: (context, index) {
                                  final weight = widget.product.weights[index];
                                  bool isSelected = weight == selectedWeight;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedWeight = weight;
                                        selectedPrice = weight.price;
                                      });
                                    },
                                    child: Container(
                                      height: height * 0.06,
                                      width: width * 0.25,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * 0.03),
                                        border: Border.all(
                                          color: isSelected
                                              ? (weight.isInStock
                                                  ? Colors.green
                                                  : Colors
                                                      .red) // Selected: Green if in stock, Red if out of stock
                                              : Colors.grey, // Unselected: Grey
                                          width: isSelected ? 2 : 1,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          weight.weight,
                                          style: GoogleFonts.nunito(
                                            color: isSelected
                                                ? (weight.isInStock
                                                    ? Colors.green
                                                    : Colors.red)
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: width * 0.03),
                              ),
                            ),
                            SizedBox(height: height * 0.015),

                            // Quantity
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Quantity',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18)),
                                Text(selectedWeight?.quantity.toString() ?? '0',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18)),
                              ],
                            ),
                          ],
                        ),

                      Divider(color: OrderColor.borderColor.withOpacity(0.3)),

                      // Description
                      Text('Description',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400, fontSize: 15)),
                      SizedBox(height: height * 0.01),
                      Text(
                        widget.product.description,
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: OrderColor.textColor),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
