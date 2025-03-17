import 'dart:io';
import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/Model/category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/Repository/auth_repository.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_category_dropdown.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_file_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/widgets/fb_category_form_field.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/Model/update_shop_model.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_shop_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/vendor_model.dart';

class UpdateShopDetails extends StatefulWidget {
  const UpdateShopDetails({super.key});

  @override
  State<UpdateShopDetails> createState() => _UpdateShopDetailsState();
}

class _UpdateShopDetailsState extends State<UpdateShopDetails> {
  List<CategoryModel> categories = [];
  final formKey = GlobalKey<FormState>();
  CategoryModel? selectedCategory;
  File? _selectedCertificate;
  File? _selectedLicense;
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController fssaeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController sinceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var vendorProvider = Provider.of<ProfileViewModel>(context, listen: false);
    AuthRepository().getStoreCategories(context).then((data) {
      setState(() {
        print(data[0].name);
        print(data[1].name);
        print(data[2].name);
        categories = data;
      });
    });
  }

  void _onCertificatePicked(File? file) {
    setState(() {
      _selectedCertificate = file;
    });
  }

  void _onLicensePicked(File? file) {
    setState(() {
      _selectedCertificate = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    var vendorProvider = Provider.of<ProfileViewModel>(context, listen: false);
    final detailsProvider=Provider.of<ProfileShopViewModel>(context,listen: false);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    void onFormSubmit() {
      UpdateShopModel model = UpdateShopModel(
          license: _selectedLicense,
          store_id: vendorProvider.vendor?.store_id ?? '',
          business_name: nameController.text == ""
              ? vendorProvider.vendor?.business_name ?? ''
              : nameController.text,
          contact_number: numberController.text.isEmpty
              ? vendorProvider.vendor?.contact_number ?? 0
              : int.parse(nameController.text),
          address: addressController.text == ""
              ? vendorProvider.vendor?.address ?? ''
              : addressController.text,
          city: cityController.text == ""
              ? vendorProvider.vendor?.city ?? ''
              : cityController.text,
          state: stateController.text == ""
              ? vendorProvider.vendor?.state ?? ''
              : stateController.text,
          pincode: pincodeController.text.isEmpty
              ? vendorProvider.vendor?.pincode ?? 0
              : int.parse(pincodeController.text),
          store_type: selectedCategory != null ? selectedCategory?.id ?? 0 : vendorProvider.vendor?.store_type ?? 0,
          fssai_no: fssaeController.text.isEmpty
              ? vendorProvider.vendor?.fssai_no ?? 0
              : int.parse(fssaeController.text),
          fssai_certicate: _selectedCertificate,
          bussiness_location: locationController.text == ""
              ? vendorProvider.vendor?.bussiness_location ?? ''
              : locationController.text,
          business_landmark: landmarkController.text == ""
              ? vendorProvider.vendor?.business_landmark ?? ''
              : landmarkController.text);

      vendorProvider.updateShopDetails(
          vendorId: vendorProvider.vendor?.id ?? 0, context: context, model: model);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: FbColors.backgroundcolor,
        centerTitle: true,
        title: Text(
          "Update Shop Details",
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
        child: Form(
          key: formKey,
          child: Consumer<ProfileViewModel>(builder: (context, data, _) {
            return Padding(
              padding:  EdgeInsets.all(screenWidth*0.03),
              child: Column(
                children: [
                  FbCategoryFormField(
                      hint: data.vendor?.business_name,
                      label: "SHOP NAME",
                      controller: nameController,
                      validator: customValidatornoSpaceError),
                  SizedBox(height: screenHeight*0.015,),
                  FbCategoryFormField(
                      hint: data.vendor?.bussiness_location,
                      label: "LOCATION",
                      controller: locationController,
                      validator: customValidatornoSpaceError),
                  SizedBox(height: screenHeight*0.015,),
                  FbCategoryFormField(
                      hint: data.vendor?.business_landmark,
                      label: "LANDMARK",
                      controller: landmarkController,
                      validator: customValidatornoSpaceError),
                  SizedBox(height: screenHeight*0.015,),
                  FbCategoryFormField(
                      hint: data.vendor?.address,
                      label: "ADDRESS",
                      controller: addressController,
                      validator: customValidatornoSpaceError),
                  SizedBox(height: screenHeight*0.015,),
                  FbCategoryFormField(
                      hint: data.vendor?.city,
                      label: "CITY",
                      controller: cityController,
                      validator: customValidatornoSpaceError),
                  SizedBox(height: screenHeight*0.015,),
                  FbCategoryFormField(
                      hint: data.vendor?.state,
                      label: "STATE",
                      controller: stateController,
                      validator: customValidatornoSpaceError),
                  SizedBox(height: screenHeight*0.015,),
                  FbCategoryFormField(
                      hint: data.vendor?.pincode.toString(),
                      label: "PINCODE",
                      controller: pincodeController,
                      validator: customValidatornoSpaceError),
                  SizedBox(height: screenHeight*0.015,),
                  FbCategoryFormField(
                      hint: data.vendor?.fssai_no.toString(),
                      label: "FSSAI NO",
                      controller: fssaeController,
                      validator: customValidatornoSpaceError),
                  SizedBox(height: screenHeight*0.015,),
                  FbCategoryFormField(
                      hint: data.vendor?.contact_number.toString(),
                      label: "CONTACT NUMBER",
                      controller: numberController,
                      validator: customValidatornoSpaceError),
                  SizedBox(height: screenHeight*0.015,),
                  SizedBox(
                    height: screenHeight*0.27,
                    child: FbFilePicker(
                      onFilePicked: (file) => _onCertificatePicked(file),
                      fileCategory: "FSSAI CIRTIFICATE",
                      borderColor: Colors.grey,
                    ),
                  ),
                  SizedBox(height: screenHeight*0.02,),
                  SizedBox(
                    height: screenHeight*0.27,
                    child: FbFilePicker(
                      onFilePicked: (file) => _onLicensePicked(file),
                      fileCategory: "LICENSE",
                      borderColor: Colors.grey,
                    ),
                  ),
                  SizedBox(height: screenHeight*0.015,),
                  FbCategoryDropdown(
                    hint: vendorProvider.vendor?.store_type_name ?? '',
                    categories: categories,
                    selectedCategory: selectedCategory,
                    onChanged: (CategoryModel? category) {
                      setState(() {
                        selectedCategory =
                            category; // Update the selected category
                      });
                      print('Selected Category: ${category?.name}');
                    },
                  ),
                  SizedBox(height: screenHeight*0.015,),
                  FbCategoryFormField(
                      //hint: data.vendor!.,
                      label: "SINCE",
                      controller: sinceController,
                      validator: customValidatornoSpaceError),
                  SizedBox(height: screenHeight*0.015,),
                  FbButton(
                    height: screenHeight*0.07,
                      onClick: onFormSubmit, label: "UPDATE"),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
