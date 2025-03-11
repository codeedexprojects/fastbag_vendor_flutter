import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/update_settings.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/widgets/fb_vendor_info.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override

  @override
  Widget build(BuildContext context) {

    // var vendorProvider=Provider.of<ProfileViewModel>(context,listen: false);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
      body: Consumer<ProfileViewModel>(
        builder: (context,data,_) {
          return Column(
            children: [
              SizedBox(
                height: screenHeight * .05,
                child:  ListTile(
                  leading:  const Text("Personal Information"),
                  trailing:  GestureDetector(
                    onTap: (){
                      navigate(context: context, screen: const UpdateSettings());
                    },
                    child: const Text("Change",style: TextStyle(color: Colors.green),)),
                ),
              ),
              FbVendorInfo(label: "FULL NAME", value: data.vendor?.owner_name ?? 'N/A'),
              FbVendorInfo(label: "EMAIL ADDRESS", value: data.vendor?.email ?? 'N/A'),
              FbVendorInfo(label: "PHONE NUMBER", value: data.vendor?.contact_number.toString() ?? 'N/A'),
            ],
          );
        }
      ),
    );
  }
}