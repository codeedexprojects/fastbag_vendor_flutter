import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:flutter/material.dart';

class ProductinsightScreen extends StatelessWidget {
  const ProductinsightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FbColors.backgroundcolor,
      appBar: AppBar(
        backgroundColor: FbColors.backgroundcolor,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Sales Insight',
          style: mainFont(
              fontsize: 16, fontweight: FontWeight.w600, color: FbColors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _productInsightItem(
                'assets/icons/frame1.png', 24456, 'Total Products'),
            SizedBox(
              height: 14,
            ),
            _productInsightItem(
                'assets/icons/frame2.png', 24456, 'Available Products'),
            SizedBox(
              height: 14,
            ),
            _productInsightItem(
                'assets/icons/frame3.png', 05, 'Out of stock Products')
          ],
        ),
      ),
    );
  }

  Widget _productInsightItem(String path, int count, String name) {
    return Card(
      child: Container(
        height: 144,
        width: 386,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: FbColors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Image.asset(path),
              title: Text(
                name,
                style: mainFont(
                    fontsize: 16,
                    fontweight: FontWeight.w600,
                    color: FbColors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    count.toString(),
                    style: mainFont(
                        fontsize: 28,
                        fontweight: FontWeight.w700,
                        color: FbColors.lightBlack),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Text('View All',
                          style: normalFont4(
                            fontsize: 16,
                            fontweight: FontWeight.w400,
                            color: FbColors.greendark,
                          )))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
