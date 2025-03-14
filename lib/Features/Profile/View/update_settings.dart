import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_form_field.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_shop_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Commons/localvariables.dart';

class UpdateSettings extends StatefulWidget {
  const UpdateSettings({super.key});

  @override
  State<UpdateSettings> createState() => _UpdateSettingsState();
}

class _UpdateSettingsState extends State<UpdateSettings> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var vendorProvider = Provider.of<ProfileViewModel>(context, listen: false);
    final updateProvider = Provider.of<ProfileShopViewModel>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    void _onFormSubmit() {
      if (nameController.text.isNotEmpty ||
          phoneController.text.isNotEmpty ||
          addressController.text.isNotEmpty) {
        // Map<String, dynamic> updateMap = {
        //   "owner_name": nameController.text.isNotEmpty
        //       ? nameController.text
        //       : vendorProvider.vendor?.owner_name,
        //   "email": addressController.text.isNotEmpty
        //       ? addressController.text
        //       : vendorProvider.vendor?.email,
        //   "contact_number": phoneController.text.isNotEmpty
        //       ? phoneController.text
        //       : vendorProvider.vendor?.contact_number
        // };

        Map<String, dynamic> updatesMap = {
          "ownerName": nameController.text.isNotEmpty
              ? nameController.text
              : updateProvider.shop?.ownerName,
          "email": addressController.text.isNotEmpty
              ? addressController.text
              : updateProvider.shop?.email,
          "contactNumber": phoneController.text.isNotEmpty
              ? phoneController.text
              : updateProvider.shop?.contactNumber,
        };

        // vendorProvider.updateSettingsDetails(vendorId:vendorProvider.vendor!.id , context: context, settingsMap: updateMap);
        updateProvider.updateShopProfile(
            context: context, updatesMap: updatesMap);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
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
      body: Consumer<ProfileViewModel>(builder: (context, data, _) {
        return Padding(
          padding:  EdgeInsets.all(screenWidth*0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * .07, vertical: screenHeight * .02),
                child: const Text("Personal Information"),
              ),
              FbCategoryFormField(
                label: "full name",
                controller: nameController,
                //validator: customValidatornoSpaceError,
                hint: data.vendor?.owner_name,
              ),
              FbCategoryFormField(
                label: "email address",
                controller: addressController,
                //validator: customValidatornoSpaceError,
                hint: data.vendor?.email,
              ),
              FbCategoryFormField(
                label: "phone number",
                controller: phoneController,
                //validator: customValidatornoSpaceError,
                hint: data.vendor?.contact_number.toString(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * .07, vertical: screenHeight * .02),
                child: FbButton(onClick: _onFormSubmit, label: "UPDATE"),
              )
            ],
          ),
        );
      }),
    );
  }
}
