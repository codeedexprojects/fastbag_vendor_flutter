import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Commons/localvariables.dart';

class OrderDetails extends StatefulWidget {
  final List<Map<String, dynamic>>orderItems;
  final String selectedCategory;
  const OrderDetails({super.key, required this.orderItems, required this.selectedCategory,  });

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: OrderColor.backGroundColor,
      appBar: AppBar(
        backgroundColor: OrderColor.backGroundColor,
        centerTitle: true,
        title: Text("Customer's Order" ,style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 17,
          color: OrderColor.textColor
        ),),leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
          child: Icon(CupertinoIcons.back,size: width*0.07,)),
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.all(width*0.03),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: height*0.13,
                  width: width*1,
                  decoration: BoxDecoration(
                    color: OrderColor.white,
                    borderRadius: BorderRadius.circular(width*0.015)
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(width*0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('jjjjjhhhhhhhhh'),
                            Text('jjjjj'),
                            Text('jjjjjjjjjjjjjjj'),
                          ],
                        ),
                        Text('hhhhh')
                      ],
                    ),
                  )
                ),
                SizedBox(height: height*0.015,),
                Container(
                  width: width*1,
                  decoration: BoxDecoration(
                    color: OrderColor.white,
                    borderRadius: BorderRadius.circular(width*0.015)
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(width*0.02),
                        child: SizedBox(
                          child: ListView.separated(
                            shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Container(
                                    height: height*0.23,
                                    width: width*0.2,
                                    decoration: BoxDecoration(
                                      color: OrderColor.white,
                                        borderRadius: BorderRadius.circular(width*0.015)
                                    ),
                                    child: Image.asset('assets/Images/orderImage.png',fit: BoxFit.fill,),
                                  ),
                                  title: Text('hhhhh'),
                                  subtitle: Text('hhhhh'),
                                  trailing: Text('hjjjj'),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: OrderColor.textColor.withOpacity(0.05),
                                );
                              },
                              itemCount: widget.orderItems.length),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(
                          left: width*0.03,
                          right: width*0.03,
                        ),
                        child: Divider(
                          color: OrderColor.textColor.withOpacity(0.05),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(
                          left: width*0.03,
                          right: width*0.09,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Total',style: GoogleFonts.nunito(
                                fontSize: 16,
                                color: OrderColor.textColor,
                                fontWeight: FontWeight.w500
                            )),
                            SizedBox(width: width*0.4,),
                            Text('8768',style: GoogleFonts.nunito(
                                fontSize: 14,
                                color: OrderColor.textColor,
                                fontWeight: FontWeight.w500
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(
                          left: width*0.03,
                          right: width*0.03,
                        ),
                        child: Divider(
                          color: OrderColor.textColor.withOpacity(0.05),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(
                          top: height*0.01,
                          left: width*0.03,
                          right: width*0.03,
                          bottom: height*0.02
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: height*0.07,
                              width: width*0.4,
                              decoration: BoxDecoration(
                                color: OrderColor.red,
                                borderRadius: BorderRadius.circular(width*0.015)
                              ),
                              child: Center(
                                child: Text('RejectOrder',style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: OrderColor.white,
                                    fontWeight: FontWeight.w500
                                )),
                              ),
                            ),
                            Container(
                              height: height*0.07,
                              width: width*0.4,
                              decoration: BoxDecoration(
                                  color: OrderColor.green,
                                  borderRadius: BorderRadius.circular(width*0.015)
                              ),
                              child: Center(
                                child: Text('ProcessOrder',style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: OrderColor.white,
                                  fontWeight: FontWeight.w500
                                ),),
                              ),
                            )
                          ],
                        )
                      )
                    ]
                  ),
                ),
               SizedBox(height: height*0.03,),
            if(widget.selectedCategory!='New Order')...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Agent's Information",style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                )),
              ),
              SizedBox(height: height*0.02,),
              Container(
                height: height * 0.13,
                width: width * 1,
                decoration: BoxDecoration(
                  color: OrderColor.white,
                  borderRadius: BorderRadius.circular(width * 0.015),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(width*0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/Images/agentImage.png'),
                          )
                        ],
                      ),
                      Text('Order awaiting pickup9:00 am \nAdekunle is on his way to pickup',style: GoogleFonts.nunito(
                            fontSize: 13,
                            fontWeight: FontWeight.w400
                          ),
                          textAlign: TextAlign.start,),
                      Icon(Icons.call),
                    ],
                  ),
                )
              ),
            ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
