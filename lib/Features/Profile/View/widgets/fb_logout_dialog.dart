import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;


class FbLogoutDialog extends StatefulWidget {
  const FbLogoutDialog({super.key});

  @override
  State<FbLogoutDialog> createState() => _FbLogoutDialogState();
}

class _FbLogoutDialogState extends State<FbLogoutDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        _controller.reverse().then((_) => Navigator.pop(context));
      },
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: _animation.value * screenHeight * 0.3,
          transform: Matrix4.translationValues(
            0,
            screenHeight * 0.7 * (1 - _animation.value),
            0,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * .02),
                    child: Text(
                      "Are you sure to logout",
                      style: mainFont(
                          fontsize: screenWidth * .035,
                          fontweight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                  FbButton(
                      onClick: () {
                        _controller.reverse().then((_) => {
                          Navigator.pop(context),
                          StoreManager().clearTokens().then((value){
                            navigate(context: context, screen: const LoginScreen());
                          })
                          });

                      },
                      label: "Continue"),
                  FbButton(
                      onClick: () {
                        _controller.reverse().then((_) => Navigator.pop(context));
                      },
                      color: Colors.white,
                      borderColor: Colors.green,
                      textColor: Colors.green,
                      label: "Cancel")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
