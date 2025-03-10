import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Commons/colors.dart';
import '../../../Commons/fonts.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          'Product Insight',
          style: mainFont(
              fontsize: 16, fontweight: FontWeight.w600, color: FbColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:11),
              child: Center(child: Image.asset('assets/Images/image_5-removebg-preview.png',height:305.22,width: 336,)),
            ),
            SizedBox(height: 24.78,),
            Container(
                height: 60,
                width: 340,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  productDifferntimage('assets/Images/Rectangle 2193.png'),
                  productDifferntimage('assets/Images/Rectangle 2193.png'),
                  productDifferntimage('assets/Images/Rectangle 2193.png'),
                  productDifferntimage('assets/Images/Rectangle 2193.png'),
                  productDifferntimage('assets/Images/Rectangle 2193.png'),
                ],
              ),
            ),
            SizedBox(height: 36,),
            Container(
              height: 52,
              width: 335,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Food',style: normalFont5(fontsize: 20, fontweight: FontWeight.w400, color: FbColors.black),),
                      Text('\$115',style: normalFont5(fontsize: 20, fontweight: FontWeight.w400, color: FbColors.black),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Category',style: normalFont4(fontsize: 16, fontweight: FontWeight.w400, color: FbColors.black),),
                      Row(
                        children: [
                          Icon(Icons.star,size: 16,color: Color.fromRGBO(231, 176, 8, 1),),
                          Text('4.8(100+ reviews)',style: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.w300,color: Color.fromRGBO(17, 24, 39, 1)),),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 17,),
            Divider(
              color: Colors.grey,
              thickness: 1,
              indent : 34,
              endIndent : 34
            ),
            SizedBox(height: 14,),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Container(

                width: 335,
                // color: Colors.black,
                child: Column(

                  children: [
                    Text(textAlign: TextAlign.start,
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text',
                    style: normalFont4(fontsize: 16, fontweight: FontWeight.w400, color: FbColors.black),),
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
    );
  }
  Widget productDifferntimage(String path){
    return ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Image.asset(path,height: 60,width: 60,));
  }
}
