
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/time_conversion.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_time_picker.dart';
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

    void onFormSubmit(){
      

      if(_selectedTimeRange.isNotEmpty){
        List<String> times = _selectedTimeRange.split(' - ');
        print(times[1]);

      String opening_time=convertTo24Hour(times[0]);
      String closing_time=convertTo24Hour(times[1]);
        vendorProvider.updateShopTiming(vendorId: vendorProvider.vendor!.id, context: context, openTime: opening_time,closeTime: closing_time);
      }
    }
    return Scaffold(
      appBar: AppBar(
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
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * .01, horizontal: screenWidth * .05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * .07,
              ),
              child: Text(
                "Shop Information",
                style: mainFont(
                    fontsize: screenWidth * 0.038,
                    fontweight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: screenHeight*.01,),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * .07,
              ),
              child: Text(
                "Update your shop timing",
                style: mainFont(
                    fontsize: screenWidth * 0.032,
                    fontweight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
            FbTimePicker(
                onTimeRangeChanged: (selectedTimeRange) {
                  setState(() {
                    print(selectedTimeRange);
                    _selectedTimeRange =
                        selectedTimeRange; // Update the selected time range
                  });
                }
            ),
            Padding(
               padding: EdgeInsets.symmetric(
                horizontal: screenWidth * .07,
                vertical: screenHeight * .01,
              ),
              child: FbButton(onClick: onFormSubmit, label: "Update Shop timing"),
            )
          ],
        ),
      ),
    
    );
  }
}
