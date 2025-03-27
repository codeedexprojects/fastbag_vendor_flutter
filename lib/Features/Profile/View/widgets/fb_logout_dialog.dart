import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/login_screen.dart';
import 'package:flutter/material.dart';
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
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _closeDialog() {
    _controller.reverse().then((_) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: _closeDialog,
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: FadeTransition(
          opacity: _animation,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: screenHeight * 0.3,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "Are you sure you want to logout?",
                      textAlign: TextAlign.center,
                      style: mainFont(
                        fontsize: screenWidth * 0.04,
                        fontweight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FbButton(
                      onClick: () {
                        _controller.reverse().then((_) {
                          Navigator.pop(context);
                          StoreManager().clearTokens().then((_) {
                            navigate(
                                context: context, screen: const LoginScreen());
                          });
                        });
                      },
                      label: "Continue",
                    ),
                    const SizedBox(height: 10),
                    FbButton(
                      onClick: _closeDialog,
                      color: Colors.white,
                      borderColor: Colors.green,
                      textColor: Colors.green,
                      label: "Cancel",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
