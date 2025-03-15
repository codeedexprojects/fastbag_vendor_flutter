import 'dart:io';

import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_file_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_shop_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditShopImage extends StatefulWidget {
  const EditShopImage({super.key});

  @override
  State<EditShopImage> createState() => _EditShopImageState();
}

class _EditShopImageState extends State<EditShopImage> {
  File? _selectedImage;

  void _onFilePicked(File? file) {
    setState(() {
      _selectedImage = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    var vendorProvider = Provider.of<ProfileViewModel>(context, listen: false);
    var editShopProvider=Provider.of<ProfileShopViewModel>(context,listen: false);

    void onFormSubmit() {
      if (_selectedImage != null) {
        vendorProvider.updateShopImage(
            vendorId: vendorProvider.vendor!.id,
            context: context,
            shopImage: _selectedImage!);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: FbColors.backgroundcolor,
        title: Text(
          "Edit Shop Image",
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
            SizedBox(height: screenHeight * .01,),
            Text(
              "Update your shop Image",
              style: mainFont(
                  fontsize: screenWidth * 0.033,
                  fontweight: FontWeight.normal,
                  color: OrderColor.textColor),
            ),
            SizedBox(height: screenHeight * .02,),
            FbCategoryFilePicker(
              onFilePicked: (file) => _onFilePicked(file),
              fileCategory: "Shop Image",
            ),
            SizedBox(height: screenHeight * .03,),
            FbButton(
              height: screenHeight*0.07,
                onClick: onFormSubmit, label: "Update Shop Image")
          ],
        ),
      ),
    );
  }
}
