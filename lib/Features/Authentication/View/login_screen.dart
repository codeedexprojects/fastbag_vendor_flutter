import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/Repository/auth_repository.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_logo_container.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_text_create_account.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_text_form_field.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/forgot_password_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/register_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/ViewModel/auth_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordContoller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Widget _gap(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.02);
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      navigate(context: context, screen: FbBottomNav());
      Provider.of<AuthViewModel>(context, listen: false).vendorLogin(
          email: emailController.text,
          password: passwordContoller.text,
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: FbColors.mainbackgroundColor,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * .05),
                child: const FbLogoContainer(customHeight: .3, customWidth: .7),
              ),
              FbTextFormField(
                  label: "emailaddress/phone no",
                  controller: emailController,
                  validator: emailValidator),
              // FbTextFormField(
              //     label: "Password",
              //     controller: passwordContoller,
              //     validator: passwordValidator),
              GestureDetector(
                onTap: () {
                  // navigate(
                  //     context: context, screen: const ForgotPasswordScreen());
                },
                child: const Text("Forget Email?"),
              ),
              _gap(context),
              FbButton(onClick: _onSubmit, label: "SIGN IN"),
              GestureDetector(
                  onTap: () {
                    navigate(context: context, screen: const RegisterScreen());
                  },
                  child: const FbTextCreateAccount())
            ],
          ),
        ),
      ),
    );
  }
}
