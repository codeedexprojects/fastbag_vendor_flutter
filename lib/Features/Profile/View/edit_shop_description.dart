import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/Fb_Text_Form_Field.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_form_field.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_shop_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final descriptionProvider=Provider.of<ProfileShopViewModel>(context,listen: false);

    void onFormSubmit() {
      if(descriptionController.text.isNotEmpty){
        // vendorProvider.updateShopDescription(vendorId: vendorProvider.vendor!.id, context: context, description: descriptionController.text);
        descriptionProvider.updateShopDescription(context: context, Description: descriptionController.text);
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FbColors.backgroundcolor,
        centerTitle: true,
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
      body: Form(
        key: formKey,
        child: Padding(
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
              SizedBox(height: screenHeight*.01),
              Text(
                "Update your shop description",
                style: mainFont(
                    fontsize: screenWidth * 0.033,
                    fontweight: FontWeight.w400,
                    color: OrderColor.textColor),
              ),
              SizedBox(height: screenHeight*.02),
              FbCategoryFormField(
                  label: "Store description",
                  controller: descriptionController,
                  validator: customValidatornoSpaceError,
                  ),
              SizedBox(height: screenHeight*.03),
              FbButton(
                  height: screenHeight*0.07,
                  onClick: onFormSubmit, label: "Update Shop Description")
            ],
          ),
        ),
      ),
     
    );
  }
}
