import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/localvariables.dart';
import 'package:flutter/material.dart';

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
     body: Column(
       children: [
         Stack(
           children: [
             Container(
               height:height*0.2 ,
               width: width*0.9,
               decoration: BoxDecoration(
                 color: OrderColor.mediumGreen,
                 borderRadius: BorderRadius.only(
                   bottomLeft: Radius.circular(width*0)
                 )
               ),
             )
           ],
         )
       ],
     ),
    );
  }
}
