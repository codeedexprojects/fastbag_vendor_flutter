import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Products/food/View/widgets/fb_category_form_field.dart';

class EditShopDescription extends StatefulWidget {
  const EditShopDescription({super.key});

  @override
  State<EditShopDescription> createState() => _EditShopDescriptionState();
}

class _EditShopDescriptionState extends State<EditShopDescription> {
  var descriptionController = TextEditingController();
  final formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    var vendorProvider = Provider.of<ProfileViewModel>(context, listen: false);

    void onFormSubmit() {
      if(descriptionController.text.isNotEmpty){
        vendorProvider.updateShopDescription(vendorId: vendorProvider.vendor!.id, context: context, description: descriptionController.text);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Shop Description",
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
        child: Form(
          key: formKey,
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
              FbCategoryFormField(
                  label: "Store description",
                  controller: descriptionController,
                  validator: customValidatornoSpaceError,
                  ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .07,
                  vertical: screenHeight * .01,
                ),
                child: FbButton(onClick: onFormSubmit, label: "Update Shop Description"),
              )
            ],
          ),
        ),
      ),
     
    );
  }
}
