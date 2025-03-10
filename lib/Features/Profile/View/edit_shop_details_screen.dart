import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/edit_shop_description.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/edit_shop_image.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/edit_shop_logo.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/edit_shop_timings.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/update_shop_details.dart';
import 'package:flutter/material.dart';

class EditShopDetailsScreen extends StatelessWidget {
  const EditShopDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    Widget editItem({required String name, required dynamic tap}) {
      return Padding(
        padding: EdgeInsets.all(screenWidth * .03),
        child: GestureDetector(
            onTap: tap,
            child: Text(
              name,
              style: mainFont(
                  fontsize: screenWidth * 0.037,
                  fontweight: FontWeight.normal,
                  color: Colors.black),
            )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Shop Details",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * .01, horizontal: screenWidth * .05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              editItem(name: "Edit Shop Logo", tap: () {
                navigate(context: context, screen: const EditShopLogo());
              }),
              editItem(name: "Edit Shop Images", tap: () {
                navigate(context: context, screen: const EditShopImage());
              }),
              editItem(name: "Edit Shop Description", tap: () {
                navigate(context: context, screen: const EditShopDescription());
              }),
              editItem(name: "Edit Shop Timings", tap: () {
                navigate(context: context, screen: const EditShopTimings());
              }),
              editItem(name: "Update Shop Details & Documents", tap: () {
                navigate(context: context, screen: const UpdateShopDetails());
              }),
              Padding(
                padding:  EdgeInsets.only(left: screenWidth * 0.05),
                child: const Text(". Please note that any updates made in the field require admin verification",textAlign:TextAlign.justify,),
              ),
              Padding(
                padding:  EdgeInsets.only(left: screenWidth * 0.05),
                child: const Text(". Once the verification is complete, you will be able to proceed with placing orders",textAlign:TextAlign.justify,),
              )
            ],
          ),
        ),
      ),
    
    );
  }
}
