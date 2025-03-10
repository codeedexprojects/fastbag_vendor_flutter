import 'dart:io';

import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_file_picker.dart';
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
            SizedBox(
              height: screenHeight * .01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * .07,
              ),
              child: Text(
                "Update your shop Image",
                style: mainFont(
                    fontsize: screenWidth * 0.032,
                    fontweight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
            FbCategoryFilePicker(
              onFilePicked: (file) => _onFilePicked(file),
              fileCategory: "Shop Image",
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * .07,
                vertical: screenHeight * .01,
              ),
              child:
                  FbButton(onClick: onFormSubmit, label: "Update Shop Image"),
            )
          ],
        ),
      ),
    );
  }
}
