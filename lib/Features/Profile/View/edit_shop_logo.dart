import 'dart:io';

import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Products/food/View/widgets/fb_category_file_picker.dart';

class EditShopLogo extends StatefulWidget {
  const EditShopLogo({super.key});

  @override
  State<EditShopLogo> createState() => _EditShopLogoState();
}

class _EditShopLogoState extends State<EditShopLogo> {
  File? _selectedImage;

  void _onFilePicked(File? file) {
    setState(() {
      _selectedImage = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    var vendorProvider = Provider.of<ProfileViewModel>(context, listen: false);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    void onFormSubmit() {
      if (_selectedImage != null) {
        vendorProvider.updateShopLogo(
            vendorId: vendorProvider.vendor!.id,
            context: context,
            logoFile: _selectedImage!);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Shop Logo",
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
                "Update your shop logo",
                style: mainFont(
                    fontsize: screenWidth * 0.032,
                    fontweight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
            FbCategoryFilePicker(
              onFilePicked: (file) => _onFilePicked(file),
              fileCategory: "Shop Logo",
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * .07,
                vertical: screenHeight * .01,
              ),
              child: FbButton(onClick: onFormSubmit, label: "Update Shop Logo"),
            )
          ],
        ),
      ),
    );
  }
}
