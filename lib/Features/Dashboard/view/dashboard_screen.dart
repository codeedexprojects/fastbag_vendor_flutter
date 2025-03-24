import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Features/Dashboard/view/productinsight_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Dashboard/view/salesinsight_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Dashboard/view_model/dash_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Profile/ViewModel/profile_shop_view_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    final _viewModel = Provider.of<DashViewModel>(context,listen: false);
    _viewModel.getdata();
    final profileShopProvider =
    Provider.of<ProfileShopViewModel>(context,listen: false);
    profileShopProvider.getShopProfile(context: context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<DashViewModel>(context);
    final profileShopProvider =
    Provider.of<ProfileShopViewModel>(context);
    return Scaffold(
      backgroundColor: FbColors.backgroundcolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 68, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dashboard',
                            style: mainFont(
                                fontsize: 16,
                                fontweight: FontWeight.w600,
                                color: FbColors.black)),
                        Text(profileShopProvider.shop?.ownerName ?? "name",
                            style: mainFont(
                                fontsize: 11,
                                fontweight: FontWeight.w500,
                                color: FbColors.greyColor)),
                        Text(
                          'Welcome back to fastbag Admin!',
                          style: mainFont(
                              fontsize: 11,
                              fontweight: FontWeight.w500,
                              color: FbColors.greyColor),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Insight',
                    style: normalFont4(
                        fontsize: 18,
                        fontweight: FontWeight.w400,
                        color: FbColors.black2),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductinsightScreen()));
                      },
                      child: Text('View All',
                          style: normalFont4(
                            fontsize: 16,
                            fontweight: FontWeight.w400,
                            color: FbColors.greendark,
                          )))
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: _buildproductInsightCard(
                        'Total\nPoducts', _viewModel.dishClass?.productCount ?? 0, 'assets/icons/Icon_Order.png'),
                  ),
                  SizedBox(width: 16,),
                  Expanded(  child:_buildproductInsightCard('Available\nProducts', 357,
                      'assets/icons/icon Delivered.png')),
                  SizedBox(width: 16,),
                  Expanded(
                    child: _buildproductInsightCard('Out of stock\nProducts', 65,
                        'assets/icons/Icon_Order (1).png'),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sales Insight',
                      style: normalFont4(
                          fontsize: 18,
                          fontweight: FontWeight.w400,
                          color: FbColors.black2)),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SalesinsightScreen()));
                      },
                      child: Text('View All',
                          style: normalFont4(
                            fontsize: 16,
                            fontweight: FontWeight.w400,
                            color: FbColors.greendark,
                          )))
                ],
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: _buildSalesInsightItem(
                        'Total Orders',
                        75,
                        'assets/icons/Icon_Order.png',
                        'assets/icons/Icon.png',
                        '4%(30 days)')
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: _buildSalesInsightItem(
                        'Total Delivered',
                        357,
                        'assets/icons/icon Delivered.png',
                        'assets/icons/Icon.png',
                        '4%(30 days)')
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: _buildSalesInsightItem(
                        'Total Canceled',
                        65,
                        'assets/icons/Icon_Order (1).png',
                        'assets/icons/Icon (1).png',
                        '4%(30 days)'),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                // padding: EdgeInsets.only(left: 10,right: 10),
                width: double.infinity,
                height: 82,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: FbColors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 2,),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green[200],
                      child: Image.asset(
                        'assets/icons/Group 119.png',
                        height: 37,
                        width: 41,
                      ),
                    ),
                    SizedBox(width: 12,),
                    Text('₹4,560',
                        style: normalFont3(
                            fontsize: 30,
                            fontweight: FontWeight.w700,
                            color: FbColors.lightBlack)),
                    SizedBox(width: 12,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: Text(
                              textAlign: TextAlign.center,
                              'Total Revenue',
                              style: mainFont(
                                  fontsize: 16,
                                  fontweight: FontWeight.w400,
                                  color: FbColors.lightBlack)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/Icon (1).png',
                              height: 16,
                              width: 16.13,
                            ),
                            Text(' 12%(30 days)',
                                style: mainFont(
                                  fontsize: 12,
                                  fontweight: FontWeight.w400,
                                  color: FbColors.greyColor,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: FbColors.white),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 4,
                                    backgroundColor: FbColors.greendark,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Order History',
                                      style: mainFont(
                                          fontsize: 14,
                                          fontweight: FontWeight.w700,
                                          color: FbColors.lightBlue)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Latest',
                                    style: mainFont(
                                        fontsize: 12,
                                        fontweight: FontWeight.w400,
                                        color: FbColors.lightBlue),
                                  ),
                                  DropdownButton(
                                    items: [],
                                    iconDisabledColor: Colors.red,
                                    onChanged: (String) {},
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 15),
                          child: _buildOrderHistory(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'See Full History',
                                    style: TextStyle(
                                      color: Color(0xFF007AFF),
                                    ),
                                  ),
                                  DropdownButton(
                                    items: [],
                                    iconDisabledColor: Colors.red,
                                    onChanged: (String) {},
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildproductInsightCard(String title, int total, String assetpath) {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: FbColors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                assetpath,
                height: 32.26,
                width: 32,
              ),
              Text('$total',
                  style: normalFont3(
                    fontsize: 28,
                    fontweight: FontWeight.w700,
                    color: FbColors.black,
                  ))
            ],
          ),
          Text(
              textAlign: TextAlign.center,
              title,
              style: mainFont(
                  fontsize: 12,
                  fontweight: FontWeight.w400,
                  color: FbColors.black)),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget _buildSalesInsightItem(String title, int total, String assetpath,
      String path, String percentage) {
    return Container(
          height: 90,
          width: double.infinity,
          decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10), color: FbColors.white),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          assetpath,
          height: 32.26,
          width: 32,
        ),
        Text(total.toString(),
            style: normalFont3(
              fontsize: 28,
              fontweight: FontWeight.w700,
              color: FbColors.black,
            ))
      ],
    ),
    Text(
        textAlign: TextAlign.center,
        title,
        style: mainFont(
            fontsize: 12,
            fontweight: FontWeight.w400,
            color: FbColors.black)),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          path,
          height: 16,
          width: 16.13,
        ),
        Text(percentage,
            style: mainFont(
              fontsize: 8,
              fontweight: FontWeight.w400,
              color: FbColors.greyColor,
            ))
      ],
    ),
          ]),
        );
  }

  Widget _buildOrderHistory() {
    return Column(
      children: [
        _buildOrderHistoryItem('Handmade Pouch', 3, 8.99),
        _buildOrderHistoryItem('Handmade Pouch', 2, 8.99),
        _buildOrderHistoryItem('Handmade Pouch', 3, 5.99),
        _buildOrderHistoryItem('Handmade Pouch', 4, 6.99),
      ],
    );
  }

  Widget _buildOrderHistoryItem(String product, int quantity, double price) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: Icon(Icons.shopping_bag),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  '$quantity other products',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  '₹$price',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // TextButton(onPressed: (){}, child: Text('View Order',style: mainFont(fontsize: 6, fontweight: FontWeight.w500, color: FbColors.darkBlue),))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
