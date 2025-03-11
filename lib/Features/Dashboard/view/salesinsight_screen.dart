import 'package:flutter/material.dart';
import '../../../Commons/colors.dart';
import '../../../Commons/fonts.dart';

class SalesinsightScreen extends StatelessWidget {
  const SalesinsightScreen({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _salesInsightItem('assets/icons/frame1.png', 24456,
                  'Total Orders', 'assets/icons/Arrow 1.png', '15'),
              SizedBox(
                height: 16,
              ),
              _salesInsightItem('assets/icons/frame2.png', 24456,
                  'Total Orders Completed', 'assets/icons/Arrow 1.png', '15'),
              SizedBox(
                height: 16,
              ),
              _salesInsightItemtwo('assets/icons/frame3.png', 05,
                  'Orders Cancelled', 'assets/icons/Arrow 2.png', '15'),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Most Popular Items',
                    style: mainFont(
                        fontsize: 16,
                        fontweight: FontWeight.w600,
                        color: Color.fromRGBO(51, 51, 51, 1)),
                  )
                ],
              ),
              SizedBox(height: 24.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    width: 386,
                    height: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: FbColors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Product',
                                  style: mainFont(
                                      fontsize: 14,
                                      fontweight: FontWeight.w700,
                                      color: FbColors.lightBlue)),
                              Text(
                                'Number Sold',
                                style: mainFont(
                                    fontsize: 12,
                                    fontweight: FontWeight.w400,
                                    color: FbColors.lightBlue),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        _buildOrderHistory(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
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
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  ////////////
  Widget _salesInsightItem(String path, int count, String name,
      String arrowpath, dynamic persatage) {
    return Card(
      child: Container(
        height: 198,
        width: 396,
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
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                count.toString(),
                style: mainFont(
                    fontsize: 28,
                    fontweight: FontWeight.w700,
                    color: FbColors.lightBlack),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    arrowpath,
                    height: 13,
                    width: 35,
                  ),
                  Text(
                    '$persatage%',
                    style: normalFont4(
                        fontsize: 13,
                        fontweight: FontWeight.w500,
                        color: FbColors.greendark),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Vs Last Month',
                    style: mainFont(
                        fontsize: 14,
                        fontweight: FontWeight.w400,
                        color: Color.fromRGBO(77, 77, 77, 1)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _salesInsightItemtwo(String path, int count, String name,
      String arrowpath, dynamic persatage) {
    return Card(
      child: Container(
        height: 184,
        width: 396,
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
              child: Text(
                count.toString(),
                style: mainFont(
                    fontsize: 28,
                    fontweight: FontWeight.w700,
                    color: FbColors.lightBlack),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    arrowpath,
                    height: 30,
                    width: 35,
                  ),
                  Text(
                    '$persatage%',
                    style: normalFont4(
                        fontsize: 13,
                        fontweight: FontWeight.w500,
                        color: Color.fromRGBO(163, 36, 36, 1)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Vs Last Month',
                    style: mainFont(
                        fontsize: 14,
                        fontweight: FontWeight.w400,
                        color: Color.fromRGBO(77, 77, 77, 1)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHistory() {
    return Column(
      children: [
        _buildOrderHistoryItem(
          'Handmade Pouch',
          100,
        ),
        _buildOrderHistoryItem(
          'Handmade Pouch',
          100,
        ),
        _buildOrderHistoryItem(
          'Handmade Pouch',
          100,
        ),
        _buildOrderHistoryItem(
          'Handmade Pouch',
          100,
        ),
      ],
    );
  }

  Widget _buildOrderHistoryItem(
    String product,
    int quantity,
  ) {
    return ListTile(
      leading: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Icon(Icons.shopping_bag),
      ),
      title: Text(
        product,
        style: mainFont(
            fontsize: 14, fontweight: FontWeight.w500, color: FbColors.black),
      ),
      subtitle: Text(
        'Category',
        style: mainFont(
            fontsize: 12,
            fontweight: FontWeight.w400,
            color: Color.fromRGBO(102, 112, 133, 1)),
      ),
      trailing: Text(
        '$quantity',
        style: mainFont(
            fontsize: 13,
            fontweight: FontWeight.w700,
            color: Color.fromRGBO(10, 4, 60, 1)),
      ),
    );
  }
}
