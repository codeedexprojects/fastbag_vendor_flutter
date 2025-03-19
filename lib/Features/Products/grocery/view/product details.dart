import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/images.dart';
import 'package:fastbag_vendor_flutter/Commons/localvariables.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_item_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../ViewModel/grocery_view_model.dart';
import '../model/grocery_products_model.dart';

class ProductDetails extends StatefulWidget {
  final GroceryProductsModel product;
  const ProductDetails({super.key, required this.product,});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Weight? selectedWeight;
  String? selectedImage;
  double selectedPrice = 0.0;
  double totalPrice=0;
  @override
  void initState() {
    super.initState();
    if (widget.product.weights.isNotEmpty) {
      selectedPrice = widget.product.price; // Set default weight
    }
    if (widget.product.images.isNotEmpty) {
      selectedImage = widget.product.images.first.image; // Set the first image as default
    }
  }

  @override
  Widget build(BuildContext context) {
    final productListProvider = Provider.of<GroceryViewModel>(context);
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
     body: Center(
       child: Padding(
         padding:  EdgeInsets.all(width*0.04),
         child: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                   Container(
             height: height * 0.4, // Adjust height as needed
             width: width,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(width * 0.03),
               image: selectedImage != null
                   ? DecorationImage(
                 image: NetworkImage(selectedImage!),
                 fit: BoxFit.cover,
               )
                   : DecorationImage(
                 image: AssetImage(ImagesConstants.food),
                 fit: BoxFit.cover,
               ),
             ),
                   ),
                 // SizedBox(
                 //   width: width*1,
                 //   child: ListView.builder(
                 //     physics: NeverScrollableScrollPhysics(),
                 //     shrinkWrap: true,
                 //     itemCount: 1,
                 //     itemBuilder: (context, index) {
                 //       final image = widget.product.images[index];
                 //     return Image.network(
                 //         image.image,
                 //         fit: BoxFit.fill,
                 //       height: height*0.4, // Adjust height as needed
                 //       );
                 //   },),
                 // ):Image(image: AssetImage(ImagesConstants.food)),
               SizedBox(height: height*0.04,),
               widget.product.images.isNotEmpty?
               SizedBox(
                 height: height*0.1,
                 child: ListView.separated(
                   shrinkWrap: true,
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (context, index) {
                       final image = widget.product.images[index];
                       return  GestureDetector(
                         onTap: () {
                           setState(() {
                             selectedImage = image.image;
                           });
                         },
                         child: Container(
                           height: height*0.09,
                           width: width*0.19,
                           decoration: BoxDecoration(
                               image: DecorationImage(image: NetworkImage(image.image),fit: BoxFit.fill),
                               borderRadius: BorderRadius.circular(width*0.03),
                             border: Border.all(
                               color: selectedImage == image.image ? Colors.green : Colors.transparent,
                             )
                           ),
                         ),
                       );
                     },
                     separatorBuilder: (context, index) {
                       return SizedBox(width: width*0.03,);
                     },
                     itemCount: widget.product.images.length),
               ):SizedBox(
                 height: height*0.1,
                 child: ListView.separated(
                     shrinkWrap: true,
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (context, index) {
                       return  Container(
                         height: height*0.09,
                         width: width*0.19,
                         decoration: BoxDecoration(
                             image: DecorationImage(image: AssetImage(ImagesConstants.food),fit: BoxFit.fill),
                             borderRadius: BorderRadius.circular(width*0.03)
                         ),
                       );
                     },
                     separatorBuilder: (context, index) {
                       return SizedBox(width: width*0.03,);
                     },
                     itemCount: 4),
               ),
              Padding(
                padding:  EdgeInsets.all(width*0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height*0.015,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.product.name,style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),),
                        Text( totalPrice.toString()  ,style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.product.categoryName,style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w300,
                          color: OrderColor.textColor,
                          fontSize: 16,
                        ),),
                        Row(
                          children: [
                            Icon(Icons.star_rate_rounded,color: Colors.orangeAccent,),
                            Text('4.8(100+ reviews)',style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w300,
                              color: OrderColor.textColor,
                              fontSize: 14,
                            )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height*0.001,),
                    Text('Available Weights',style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600,
                      color: OrderColor.textColor,
                      fontSize: 15,
                    ),),
                    SizedBox(height: height*0.001,),
                    Text('Available Stocks:${widget.product.available}',style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w400,
                      color: OrderColor.red,
                      fontSize: 12,
                    ),),
                    SizedBox(height: height*0.01,),
                    widget.product.weights.isNotEmpty?
                    SizedBox(
                      height: height*0.05,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.product.weights.length,
                        itemBuilder: (context, index) {
                          final weight=widget.product.weights[index];
                          bool isSelected = weight == selectedWeight;
                          int SelctedWeightIndex=0;

                        return GestureDetector(
                          onTap: () {
                           setState(() {
                             final groceryViewModel = Provider.of<GroceryViewModel>(context, listen: false);
                             groceryViewModel.selectWeight(widget.product.weights[index]);
                             // selectedWeight = weight;
                             // selectedPrice=weight.price;
                             selectedWeight = weight; // Update the selected weight

                             // Ensure weight is converted to a number correctly
                             int weightValue = int.tryParse(weight.weight.replaceAll(RegExp(r'[^0-9]'), '')) ?? 1;

                             // Calculate the price
                             selectedPrice = widget.product.price * weightValue;// Calculate price

                             totalPrice = selectedPrice * weight.quantity;

                           });
                          },
                          child: Container(
                            height: height*0.06,
                            width: width*0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(width*0.03),
                                border: Border.all(
                                  color: isSelected ? Colors.green : Colors.red,
                                  width: isSelected ? 2 : 1,
                                )
                            ),
                            child: Center(
                              child: Text(weight.weight,style: GoogleFonts.nunito(
                                color: isSelected ? Colors.green : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              )),
                            ),
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: width*0.02,); },),
                    ):Text('no weights'),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text('Price :',style: GoogleFonts.nunito(
                    //       fontWeight: FontWeight.w600,
                    //       fontSize: 18,
                    //     ),),
                    //     Text('₹${selectedPrice.toString()}',style: GoogleFonts.nunito(
                    //       fontWeight: FontWeight.w600,
                    //       fontSize: 18,
                    //     )),
                    //   ],
                    // ),
                    SizedBox(height: height*0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Quantity',style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),),
                        Text(
                            selectedWeight?.quantity.toString() ?? '0',style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        )),
                      ],
                    ),
                    Divider(color: OrderColor.borderColor.withOpacity(0.3),),
                    Text(widget.product.description,
                      // 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry\nRead more',
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: OrderColor.textColor
                    ),textAlign: TextAlign.start,),
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
