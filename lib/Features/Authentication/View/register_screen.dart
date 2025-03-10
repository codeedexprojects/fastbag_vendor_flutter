import 'dart:io';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/Model/category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/Model/register_model.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/Repository/auth_repository.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_category_dropdown.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_time_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/ViewModel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_auth_title.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_file_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_text_agreement.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_logo_container.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_text_form_field.dart';
import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:provider/provider.dart';

// import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
    AuthRepository().getStoreCategories(context).then((data) {
      setState(() {
        print(data[0].name);
        categories = data;
      });
    });
  }

  List<CategoryModel> categories = [];
  CategoryModel? selectedCategory;

  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    "name": TextEditingController(),
    "email": TextEditingController(),
    "phone": TextEditingController(),
    "shop": TextEditingController(),
    "location": TextEditingController(),
    "landmark": TextEditingController(),
    "address": TextEditingController(),
    "city": TextEditingController(),
    "state": TextEditingController(),
    "pincode": TextEditingController(),
    "description": TextEditingController(),
    "fssai": TextEditingController(),
    "since": TextEditingController(),
    "time": TextEditingController(),
    "password": TextEditingController(),
    "confirmPassword": TextEditingController(),
    "alternativeEmail":TextEditingController()
  };

  String _selectedTimeRange = "";

  final Map<String, File?> _selectedFiles = {
    "logo": null,
    "view": null,
    "certificate": null,
    "license": null,
  };

  bool _isAgreed = false;

  void _onFilePicked(String category, File? file) {
    setState(() {
      _selectedFiles[category] = file;
    });
  }

  void _onAgreeChanged(bool? value) {
    setState(() {
      _isAgreed = value ?? false;
    });
  }

  void _submitForm() {
    final registerViewModel =
        Provider.of<AuthViewModel>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      if (!_isAgreed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You must agree to the terms.")),
        );
        return;
      }

      if (_selectedTimeRange.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You must select open and close time")),
        );
        return;
      }

      // Check for missing file selections
      if (_selectedFiles['logo'] == null ||
          _selectedFiles['certificate'] == null ||
          _selectedFiles['view'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Please upload all the required files.")),
        );
        return;
      }

      List<String> times = _selectedTimeRange.split(' - ');

      RegisterModel model = RegisterModel(
        owner_name: _controllers['name']!.text,
        since: int.tryParse(_controllers["since"]!.text) ?? 0,
        email: _controllers['email']!.text,
        business_name: _controllers['shop']!.text,
        contact_number: int.tryParse(_controllers['phone']!.text) ?? 0,
        address: _controllers['address']!.text,
        city: _controllers['city']!.text,
        state: _controllers['state']!.text,
        pincode: int.tryParse(_controllers['pincode']!.text) ?? 0,
        store_logo: _selectedFiles['logo']!,
        store_description: _controllers['description']!.text,
        store_type: selectedCategory?.name ?? "Default",
        closing_time: times[1],
        opening_time: times[0],
        fssai_no: int.parse(_controllers['fssai']!.text),
        fssai_certicate: _selectedFiles['certificate']!,
        bussiness_location: _controllers['location']!.text,
        business_landmark: _controllers['landmark']!.text,
        display_image: _selectedFiles["view"]!,
        alternate_email: _controllers['alternativeEmail']!.text
      );

      registerViewModel.userRegister(registerVendor: model, context: context);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _gap(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.02);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: FbColors.mainbackgroundColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const FbLogoContainer(customHeight: .2, customWidth: .6),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * .07),
                  child: const FbAuthTitle(
                      title: "Create Account", fontWidth: .05),
                ),
              ),
              _gap(context),
              // Text Form Fields
              FbTextFormField(
                  label: "Full Name",
                  controller: _controllers["name"]!,
                  validator: customValidatornoSpaceError),
              FbTextFormField(
                  label: "Email Address",
                  controller: _controllers["email"]!,
                  validator: emailValidator),
              FbTextFormField(
                  label: "Phone No",
                  controller: _controllers["phone"]!,
                  keyboard: TextInputType.phone,
                  validator: phoneValidator),
              FbTextFormField(
                  label: "Shop Name",
                  controller: _controllers["shop"]!,
                  validator: customValidatornoSpaceError),
              FbTextFormField(
                  label: "Location",
                  controller: _controllers["location"]!,
                  validator: customValidatornoSpaceError),
              FbTextFormField(
                  label: "Landmark",
                  controller: _controllers["landmark"]!,
                  validator: customValidatornoSpaceError),
              FbTextFormField(
                  label: "Address",
                  controller: _controllers["address"]!,
                  validator: customValidatornoSpaceError),
              FbTextFormField(
                  label: "City",
                  controller: _controllers["city"]!,
                  validator: customValidator),
              FbTextFormField(
                  label: "State",
                  controller: _controllers["state"]!,
                  validator: customValidator),
              FbTextFormField(
                  label: "Pincode",
                  controller: _controllers["pincode"]!,
                  keyboard: TextInputType.number,
                  validator: customValidatornoSpaceError),
              FbFilePicker(
                onFilePicked: (file) => _onFilePicked("logo", file),
                fileCategory: "Store Logo",
              ),
              FbFilePicker(
                onFilePicked: (file) => _onFilePicked("view", file),
                fileCategory: "Store View",
              ),
              FbTextFormField(
                  label: "Store Description",
                  controller: _controllers["description"]!,
                  validator: customValidatornoSpaceError),
              FbTextFormField(
                label: "FSSAI No",
                controller: _controllers["fssai"]!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a valid FSSAI number.";
                  }
                  if (int.tryParse(value) == null) {
                    return "FSSAI number must be a valid number.";
                  }
                  return null;
                },
              ),
              FbFilePicker(
                onFilePicked: (file) => _onFilePicked("certificate", file),
                fileCategory: "FSSAI Certificate",
              ),
              FbFilePicker(
                onFilePicked: (file) => _onFilePicked("license", file),
                fileCategory: "License",
              ),
              FbCategoryDropdown(
                hint: "Food",
                categories: categories,
                selectedCategory: selectedCategory,
                onChanged: (CategoryModel? category) {
                  setState(() {
                    selectedCategory = category; // Update the selected category
                  });
                  print('Selected Category: ${category?.name}');
                },
              ),

              FbTextFormField(
                  label: "Since",
                  controller: _controllers["since"]!,
                  validator: customValidator),
              FbTimePicker(
                onTimeRangeChanged: (selectedTimeRange) {
                  setState(() {
                    print(selectedTimeRange);
                    _selectedTimeRange =
                        selectedTimeRange; // Update the selected time range
                  });
                },
              ),
              FbTextFormField(
                  label: "Alternative Email",
                  controller: _controllers["alternativeEmail"]!,
                  validator: emailValidator),
              FbTextAgreement(onAgreeChanged: _onAgreeChanged),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * .07,
                    vertical: screenHeight * .02,
                  ),
                  child: FbButton(
                    onClick: _submitForm,
                    label: "SIGN UP",
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
