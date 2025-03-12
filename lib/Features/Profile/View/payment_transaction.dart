import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Commons/colors.dart';
import '../../../Commons/images.dart';
import '../../../Commons/localvariables.dart';

class PaymentTransaction extends StatefulWidget {
  const PaymentTransaction({super.key});

  @override
  State<PaymentTransaction> createState() => _PaymentTransactionState();
}

class _PaymentTransactionState extends State<PaymentTransaction> {
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
      body:SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.all(width*0.03),
              child: Container(
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
            ),
            SizedBox(height: height*0.01,),
            Padding(
              padding:  EdgeInsets.all(width*0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Transaction',style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: OrderColor.black
                  ),),
                  Text('view all',style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: OrderColor.green
                  ),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width*0.04),
              child: SizedBox(
                height: height*1,
                child: ListView.separated(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return  SizedBox(
                        width: width*1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                      top: height*0.015,
                                    ),
                                    child: SvgPicture.asset(SvgConstants.import)),
                                SizedBox(width: width*0.02,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Order Payment',style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: OrderColor.black
                                    )),
                                    Text('#212323',style: GoogleFonts.nunito(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: OrderColor.textColor
                                    )),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('50,000',style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: OrderColor.black
                                )),
                                Text('November 25th,2023',style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: OrderColor.textColor
                                )),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: OrderColor.borderColor.withOpacity(0.17),
                      );
                    },
                    itemCount: 20),
              ),
            )
          ],
        ),
      ) ,
    );
  }
}
