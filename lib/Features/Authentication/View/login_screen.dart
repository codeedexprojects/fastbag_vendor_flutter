import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/validators.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_logo_container.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_text_form_field.dart';
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final gap = SizedBox(height: MediaQuery.of(context).size.width * .04);
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
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    FbTextFormField(
                        label: "emailaddress/phone no",
                        controller: emailController,
                        validator: emailValidator),
                    TextButton(
                        onPressed: () {
                          // navigate(
                          //     context: context, screen: const ForgotPasswordScreen());
                        },
                        child: Text(
                          "Forget Email?",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400),
                        )),
                    gap,
                    FbButton(
                      onClick: _onSubmit,
                      label: "SIGN IN",
                    ),
                    gap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont have an account?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        TextButton(
                            onPressed: () => navigate(
                                context: context,
                                screen: const RegisterScreen()),
                            child: const Text(
                              'Create new account.',
                              style: TextStyle(color: Colors.green),
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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
}
