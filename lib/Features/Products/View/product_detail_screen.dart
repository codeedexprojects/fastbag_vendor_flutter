import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/fooddetail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../Commons/colors.dart';
import '../../../Commons/fonts.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  const ProductDetailScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? imageIndex;
  @override
  void initState() {
    final _viewModel=Provider.of<FoodViewModel>(context,listen: false);
    _viewModel.getfooddata(widget.productId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  final _viewModel=Provider.of<FoodViewModel>(context);
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
              child: Center(child: ClipRRect(borderRadius: BorderRadius.all( Radius.circular(360)),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle
                  ),
                  height:336.22,width: 336,
                  child: Image.network(
                     imageIndex??_viewModel.foodDetail?.imageUrls?.first.image ?? "",fit: BoxFit.cover,),
                ),
              ),),
            ),
            SizedBox(height: 24.78,),
            Container(
              height: 60,
              width: 340,
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Allows horizontal scrolling
                itemCount:_viewModel.foodDetail?.imageUrls?.length??0  , // Number of images
                itemBuilder: (BuildContext context, int index) {
                  final imageUrl = _viewModel.foodDetail?.imageUrls?[index].image ??'';
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0), // Adds spacing
                    child: productDifferntimage('${imageUrl}',() {
                     setState(() {
                       imageIndex=imageUrl;
                       print(imageUrl);
                     });
                    }),
                  );
                },
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
                      Text(_viewModel.foodDetail?.name??'',style: normalFont5(fontsize: 20, fontweight: FontWeight.w400, color: FbColors.black),),
                      Text(_viewModel.foodDetail?.price??'\$115',style: normalFont5(fontsize: 20, fontweight: FontWeight.w400, color: FbColors.black),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${_viewModel.foodDetail?.categoryName?? 0}',style: normalFont4(fontsize: 16, fontweight: FontWeight.w400, color: FbColors.black),),
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
                       _viewModel.foodDetail?.description?? 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text',
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

  Widget productDifferntimage(String path, VoidCallback onTap){
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
              height: 60,width: 60,
            decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.network(path,fit: BoxFit.cover,))),
    );
  }
}
