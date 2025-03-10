import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_auth_title.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_text_form_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  var emailController = TextEditingController();

  Widget _gap(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.02);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
        backgroundColor: FbColors.mainbackgroundColor,
        appBar: AppBar(
          backgroundColor: FbColors.mainbackgroundColor,
          centerTitle: true,
          title: const Text("Forgot Password"),
          titleTextStyle:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * .07, vertical: screenHeight * .02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _gap(context),
              const FbAuthTitle(title: "Forgot Password", fontWidth: .07),
              _gap(context),
              Text(
                'Enter your email address and we',
                style: mainFont(
                    fontsize: screenHeight * .02,
                    fontweight: FontWeight.normal,
                    color: Colors.grey),
              ),
              Text(
                'we will send you reser instructions.',
                style: mainFont(
                    fontsize: screenHeight * .02,
                    fontweight: FontWeight.normal,
                    color: Colors.grey),
              ),
              _gap(context),
              FbTextFormField(label: "email Address", controller: emailController,noPadding: true,),
              _gap(context),
              FbButton(onClick: (){}, label: "RESET PASSWORD")
            ],
          ),
        ));
  }
}
