import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Commons/colors.dart';
import '../../../Commons/images.dart';
import '../../../Commons/localvariables.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: OrderColor.backGroundColor,
      appBar: AppBar(
        backgroundColor: OrderColor.backGroundColor,
        centerTitle: true,
        title: Text('Transaction History',style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: OrderColor.black
        ),),
        leading: Icon(CupertinoIcons.back),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(width*0.03),
          child: Column(
            children: [
              Text('Today,Nov 25th,2023',style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: OrderColor.black
              ),),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: OrderColor.borderColor
                  ),
                  borderRadius: BorderRadius.circular(width*0.03)
                ),
                height: height*1,
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return  Padding(
                        padding:  EdgeInsets.only(
                          top: height*0.01,
                          left: width*0.03,
                          right: width*0.03,
                          bottom: height*0.01,
                        ),
                        child: SizedBox(
                          width: width*1,
                          child: Column(
                            children: [
                              Row(
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
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: OrderColor.borderColor.withOpacity(0.17),
                      );
                    },
                    itemCount: 3),
              )
            ],
          ),
        ),
      ),
    );
  }
}
