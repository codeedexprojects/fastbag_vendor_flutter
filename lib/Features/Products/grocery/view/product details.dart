import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/images.dart';
import 'package:fastbag_vendor_flutter/Commons/localvariables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
     body: Center(
       child: Padding(
         padding:  EdgeInsets.all(width*0.03),
         child: SingleChildScrollView(
           child: Column(
             children: [
               Image.asset(ImagesConstants.food),
               SizedBox(height: height*0.04,),
               SizedBox(
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
                    Container(
                      height: height*0.06,
                      width: width*0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width*0.03),
                          border: Border.all(
                              color: OrderColor.red
                          )
                      ),
                      child: Center(
                        child: Text('1Kg',style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        )),
                      ),
                    ),
                    SizedBox(height: height*0.015,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price :',style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),),
                        Text(' ₹ 120',style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        )),
                      ],
                    ),
                    SizedBox(height: height*0.015,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Food',style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),),
                        Text(' ₹115',style: GoogleFonts.nunito(
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
                    Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry\nRead more',style: GoogleFonts.nunito(
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
