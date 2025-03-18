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
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final productListProvider = Provider.of<GroceryViewModel>(context);
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
     body: Center(
       child: Padding(
         padding:  EdgeInsets.all(width*0.03),
         child: SingleChildScrollView(
           child: Column(
             children: [
               widget.product.images.isNotEmpty?
                 SizedBox(
                   width: width*1,
                   child: ListView.builder(
                     physics: NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
                     itemCount: 1,
                     itemBuilder: (context, index) {
                       final image = widget.product.images.first;
                     return Image.network(
                         image.image,
                         fit: BoxFit.fill,
                       height: height*0.4, // Adjust height as needed
                       );
                   },),
                 ):Image(image: AssetImage(ImagesConstants.food)),
               SizedBox(height: height*0.04,),
               widget.product.images.isNotEmpty?
               SizedBox(
                 height: height*0.1,
                 child: ListView.separated(
                   shrinkWrap: true,
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (context, index) {
                       final image = widget.product.images.first;
                       return  Container(
                         height: height*0.09,
                         width: width*0.19,
                         decoration: BoxDecoration(
                             image: DecorationImage(image: NetworkImage(image.image),fit: BoxFit.fill),
                             borderRadius: BorderRadius.circular(width*0.03)
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
                padding:  EdgeInsets.all(width*0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Available Weights',style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),),
                    SizedBox(height: height*0.02,),
                    widget.product.weights.isNotEmpty?
                    SizedBox(
                      height: height*0.05,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.product.weights.length,
                        itemBuilder: (context, index) {
                          final weights=widget.product.weights.first;
                        return Container(
                          height: height*0.06,
                          width: width*0.25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width*0.03),
                              border: Border.all(
                                  color: OrderColor.red
                              )
                          ),
                          child: Center(
                            child: Text(weights.weight,style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            )),
                          ),
                        );
                      },),
                    ):Text('no weights'),
                    SizedBox(height: height*0.015,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price :',style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),),
                        Text(widget.product.priceForSelectedWeight.toString(),style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        )),
                      ],
                    ),
                    SizedBox(height: height*0.015,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.product.categoryName,style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),),
                        Text(widget.product.price.toString(),style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        )),
                      ],
                    ),
                    SizedBox(height: height*0.007,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Category',style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),),
                        Row(
                          children: [
                            Icon(Icons.star_rate_rounded,color: Colors.orangeAccent,),
                            Text('4.8(100+ reviews)',style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w600,
                              color: OrderColor.textColor,
                              fontSize: 14,
                            )),
                          ],
                        ),
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
