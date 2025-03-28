import 'dart:io';

import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/time_conversion.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_time_picker.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_file_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_shop_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditShopTimings extends StatefulWidget {
  const EditShopTimings({super.key});

  @override
  State<EditShopTimings> createState() => _EditShopTimingsState();
}

class _EditShopTimingsState extends State<EditShopTimings> {
  String _selectedTimeRange = "";

  

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    var vendorProvider = Provider.of<ProfileViewModel>(context, listen: false);
    final timeProvider=Provider.of<ProfileShopViewModel>(context,listen: false);

    void onFormSubmit(){
      if(_selectedTimeRange.isNotEmpty){
        List<String> times = _selectedTimeRange.split(' - ');
        print(times[1]);

      String opening_time=convertTo24Hour(times[0]);
      String closing_time=convertTo24Hour(times[1]);
        // vendorProvider.updateShopTiming(vendorId: vendorProvider.vendor!.id, context: context, openTime: opening_time,closeTime: closing_time);
        timeProvider.updateShopTime(context: context, openTime: opening_time, closingTime: closing_time);

      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FbColors.backgroundcolor,
        centerTitle: true,
        title: Text(
          "Edit Shop Timings",
          style: mainFont(
              fontsize: screenWidth * 0.05,
              fontweight: FontWeight.w500,
              color: Colors.black),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Padding(
        padding:  EdgeInsets.all(screenWidth*0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shop Information",
              style: mainFont(
                  fontsize: screenWidth * 0.05,
                  fontweight: FontWeight.w400,
                  color: Colors.black),
            ),
            SizedBox(height: screenHeight*.01,),
            Text(
              "Update your shop timing",
              style: mainFont(
                  fontsize: screenWidth * 0.033,
                  fontweight: FontWeight.normal,
                  color: OrderColor.textColor),
            ),
            SizedBox(
              height: screenHeight*0.2,
              child: FbTimePicker(
                  onTimeRangeChanged: (selectedTimeRange) {
                    setState(() {
                      print(selectedTimeRange);
                      _selectedTimeRange =
                          selectedTimeRange; // Update the selected time range
                    });
                  }
              ),
            ),
            SizedBox(height: screenHeight*.03,),
            FbButton(onClick: onFormSubmit, label: "Update Shop timing")
          ],
        ),
      ),
    
    );
  }
}
