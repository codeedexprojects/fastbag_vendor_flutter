import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Features/Dashboard/view_model/dash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Profile/ViewModel/profile_shop_view_model.dart';

class ProductinsightScreen extends StatefulWidget {
  const ProductinsightScreen({Key? key}) : super(key: key);

  @override
  State<ProductinsightScreen> createState() => _ProductinsightScreenState();
}

class _ProductinsightScreenState extends State<ProductinsightScreen> {
  @override
  void initState() {
    final _viewModel = Provider.of<DashViewModel>(context, listen: false);
    _viewModel.getdata();
    final profileShopProvider =
        Provider.of<ProfileShopViewModel>(context, listen: false);
    profileShopProvider.getShopProfile(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<DashViewModel>(context);
    final profileShopProvider = Provider.of<ProfileShopViewModel>(context);
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
          'Product Insight',
          style: mainFont(
              fontsize: 16, fontweight: FontWeight.w600, color: FbColors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _productInsightItem('assets/icons/frame1.png',
                _viewModel.dishClass?.availableProductCount ?? 0, 'Total Products'),
            SizedBox(
              height: 14,
            ),
            _productInsightItem(
                'assets/icons/frame2.png', _viewModel.dishClass?.availableProductCount??0, 'Available Products'),
            SizedBox(
              height: 14,
            ),
            _productInsightItem(
                'assets/icons/frame3.png', _viewModel.dishClass?.outOfStockCounts?.total??0, 'Out of stock Products')
          ],
        ),
      ),
    );
  }

  Widget _productInsightItem(String path, int count, String name) {
    return Container(
      height: 144,
      width: double.infinity,
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
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                      onTap: () {},
                      child: Text('View All',
                          style: normalFont4(
                            fontsize: 16,
                            fontweight: FontWeight.w400,
                            color: FbColors.greendark,
                          ))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
