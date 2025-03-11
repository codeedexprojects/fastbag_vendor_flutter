import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Commons/colors.dart';
import '../../../Commons/localvariables.dart';
import 'order_details.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String selectedCategory = "All";
  final List<Map<String, dynamic>> orders = [
    {
      "name": "Raiden Lord",
      "id": "#212323",
      "date": "Today | 9:00 am",
      "status": "New Order",
      'color': OrderColor.green
    },
    {
      "name": "Raiden Lord",
      "id": "#212323",
      "date": "Today | 9:00 am",
      "status": "Awaiting Pickup",
      'color': OrderColor.orange
    },
    {
      "name": "Jay Baba",
      "id": "#212323",
      "date": "Today | 9:00 am",
      "status": "In Transit",
      'color': OrderColor.blue
    },
    {
      "name": "Raiden Lord",
      "id": "#212323",
      "date": "25th November, 2023 | 9:00 am",
      "status": "Completed",
      'color': OrderColor.darkGreen
    },
    {
      "name": "Raiden Lord",
      "id": "#212323",
      "date": "25th November, 2023 | 9:00 am",
      "status": "Cancelled",
      'color': OrderColor.red
    },
    {
      "id": "#212325",
      "date": "Today | 9:30 am",
      "status": "Awaiting Pickup",
      "items": "2 items",
      "color": Colors.orange
    },
    {
      "id": "#212326",
      "date": "Today | 11:00 am",
      "status": "In Transit",
      "items": "4 items",
      "color": Colors.blue
    },
    {
      "id": "#212327",
      "date": "25 Nov 2023 | 9:00 am",
      "status": "Completed",
      "items": "6 items",
      "color": Colors.green[800]
    },
    {
      "id": "#212328",
      "date": "26 Nov 2023 | 9:00 am",
      "status": "Cancelled",
      "items": "1 item",
      "color": Colors.red
    },
  ];
  final List<String> categories = [
    "All",
    "New Order",
    "Awaiting Pickup",
    "In Transit"
  ];

  final Map<String, List<Map<String, dynamic>>> orderCategories = {
    "All": [
      {
        "name": "Raiden Lord",
        "id": "#212323",
        "date": "Today | 9:00 am",
        "status": "New Order",
        'color': OrderColor.green
      },
      {
        "name": "Raiden Lord",
        "id": "#212323",
        "date": "Today | 9:00 am",
        "status": "Awaiting Pickup",
        'color': OrderColor.orange
      },
      {
        "name": "Jay Baba",
        "id": "#212323",
        "date": "Today | 9:00 am",
        "status": "In Transit",
        'color': OrderColor.blue
      },
      {
        "name": "Raiden Lord",
        "id": "#212323",
        "date": "25th November, 2023 | 9:00 am",
        "status": "Completed",
        'color': OrderColor.darkGreen
      },
      {
        "name": "Raiden Lord",
        "id": "#212323",
        "date": "25th November, 2023 | 9:00 am",
        "status": "Cancelled",
        'color': OrderColor.red
      },
    ],
    "New Order": [
      {"id": "#212323", "date": "Today | 9:00 am", "items": "3 items"},
      {"id": "#212324", "date": "Today | 10:00 am", "items": "5 items"},
      {"id": "#212324", "date": "Today | 10:00 am", "items": "5 items"},
      {"id": "#212324", "date": "Today | 10:00 am", "items": "5 items"},
      {"id": "#212324", "date": "Today | 10:00 am", "items": "5 items"},
    ],
    "Awaiting Pickup": [
      {"id": "#212325", "date": "Today | 9:30 am", "items": "2 items"},
      {"id": "#212325", "date": "Today | 9:30 am", "items": "2 items"},
      {"id": "#212325", "date": "Today | 9:30 am", "items": "2 items"},
      {"id": "#212325", "date": "Today | 9:30 am", "items": "2 items"},
      {"id": "#212325", "date": "Today | 9:30 am", "items": "2 items"},
      {"id": "#212325", "date": "Today | 9:30 am", "items": "2 items"},
    ],
    "In Transit": [
      {"id": "#212326", "date": "Today | 11:00 am", "items": "4 items"},
      {"id": "#212326", "date": "Today | 11:00 am", "items": "4 items"},
      {"id": "#212326", "date": "Today | 11:00 am", "items": "4 items"},
      {"id": "#212326", "date": "Today | 11:00 am", "items": "4 items"},
      {"id": "#212326", "date": "Today | 11:00 am", "items": "4 items"},
    ],
  };

  List<Map<String, dynamic>> get filteredOrders {
    return orderCategories[selectedCategory] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.08, left: width * 0.05),
              child: Row(
                children: [
                  SizedBox(
                    height: height * 0.07,
                    width: width * 0.8,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Search here',
                          suffixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/search.svg',
                                height: height * 0.03,
                              ),
                            ],
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.03),
                            borderSide:
                                BorderSide(color: OrderColor.borderColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.03),
                            borderSide:
                                BorderSide(color: OrderColor.borderColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.03),
                            borderSide:
                                BorderSide(color: OrderColor.borderColor),
                          )),
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          onTap: () {},
                          child: Text("hhhhh"),
                        ),
                        PopupMenuItem(onTap: () {}, child: Text("hhhhh")),
                      ];
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    bool isSelected = selectedCategory == category;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: width * 0.03),
                        padding: EdgeInsets.all(width * 0.02),
                        decoration: BoxDecoration(
                            color: isSelected
                                ? OrderColor.green
                                : OrderColor.backGroundColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(width * 0.02),
                            border: Border.all(color: OrderColor.green)),
                        child: Text(
                          category,
                          style: GoogleFonts.nunito(
                            color: isSelected
                                ? OrderColor.backGroundColor
                                : OrderColor.textColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: height * 1,
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    return GestureDetector(
                      onTap: () {
                        if (selectedCategory != 'All')
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetails(
                                  orderItems: filteredOrders,
                                  selectedCategory: selectedCategory,
                                ),
                              ));
                      },
                      child: Container(
                        width: width * 1,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.all(width * 0.03),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (selectedCategory == 'All')
                                      Text(
                                        order['name'],
                                        style: GoogleFonts.nunito(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    Text("Order ID ${order['id']}",
                                        style: GoogleFonts.nunito(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    Text(order['date'],
                                        style: GoogleFonts.nunito(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                                selectedCategory == 'All'
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: width * 0.015,
                                            color: order['color'],
                                          ),
                                          SizedBox(
                                            width: width * 0.01,
                                          ),
                                          Text(
                                            order['status'],
                                            style: GoogleFonts.nunito(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: order['color']),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Text(
                                            order['items'],
                                            style: GoogleFonts.nunito(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: OrderColor.textColor),
                                          ),
                                          SizedBox(width: width * 0.03),
                                          Icon(Icons.arrow_forward_ios,
                                              size: 14),
                                        ],
                                      )
                              ]),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: filteredOrders.length),
            )
          ],
        ),
      ),
    );
  }
}
