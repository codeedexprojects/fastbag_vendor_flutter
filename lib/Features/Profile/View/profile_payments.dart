import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Commons/localvariables.dart';

class ProfilePayments extends StatefulWidget {
  const ProfilePayments({super.key});

  @override
  State<ProfilePayments> createState() => _ProfilePaymentsState();
}

class _ProfilePaymentsState extends State<ProfilePayments> {
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: OrderColor.backGroundColor,
      appBar: AppBar(
        backgroundColor: OrderColor.backGroundColor,
        centerTitle: true,
        title: Text('Payments',style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: OrderColor.black
        ),),
        leading: Icon(CupertinoIcons.back),
      ),
      body: Padding(
        padding:  EdgeInsets.all(width*0.03),
        child: Column(
          children: [
           Container(
             height: height*0.25,
             width: width*1,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(width*0.03),
               gradient: LinearGradient(
                 begin: Alignment.bottomLeft,
                   end: Alignment.topRight,
                   colors: [
                     OrderColor.mediumGreen.withOpacity(0.92),
                     OrderColor.mediumGreen
                   ]),
              boxShadow: [
                BoxShadow(
                  color: OrderColor.gradientRed.withOpacity(0.17),
                  blurRadius: 63,
                  spreadRadius: 0,
                  offset: Offset(0,30),
                )
              ]
             ),
             child: Padding(
               padding: EdgeInsets.all(width*0.05),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text('₹000000',style: GoogleFonts.roboto(
                         fontWeight: FontWeight.w700,
                         fontSize: 30,
                         color: OrderColor.white
                       ),),
                       Text('My Bank',style: GoogleFonts.roboto(
                           fontWeight: FontWeight.w700,
                           fontSize: 16,
                           color: OrderColor.white
                       ))
                     ],
                   ),
                   Text('.... .... .... 4456',style: GoogleFonts.roboto(
                       fontWeight: FontWeight.w700,
                       fontSize: 16,
                       color: OrderColor.white
                   ),),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text('Praveen Tp',style: GoogleFonts.roboto(
                           fontWeight: FontWeight.w700,
                           fontSize: 16,
                           color: OrderColor.white
                       ),),
                      SvgPicture.asset(SvgConstants.MasterCard,height: height*0.05,),
                     ],
                   )
                 ],
               ),
             ),
           ),
            SizedBox(height: height*0.1,),
            Image.asset(ImagesConstants.money)
          ],
        ),
      ),
    );
  }
}
