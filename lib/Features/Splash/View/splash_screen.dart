import 'dart:async';
import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Extentions/string_extention.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/approval_waiting_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/login_screen.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _splashDelay =
      Duration(seconds: 5); // Centralized timer duration

  @override
  void initState() {
    super.initState();
    _initializeNavigation();
  }

  Future<void> _initializeNavigation() async {
    try {
      final accessToken = await StoreManager().getAccessToken();
      if (accessToken != null) {
        _navigateToScreen(const FbBottomNav());
        return;
      }
      final isApproved = await StoreManager().getIsApproved();
      final vendorId = await StoreManager().getVendorId();
      print(isApproved);
      if (vendorId != null && (isApproved == null || isApproved == false)) {
        _navigateToScreen(ApprovalWaitingScreen(id: vendorId));
      } else {
        _navigateToScreen(const LoginScreen());
        return;
      }
    } catch (e) {
      // Handle exceptions if necessary (e.g., logging)
      debugPrint('Error during splash screen navigation: $e');
    }
  }

  void _navigateToScreen(Widget screen) {
    Timer(_splashDelay, () {
      navigate(
        context: context,
        screen: screen,
        type: NavigationType.pushAndRemoveUntil,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: FbColors.mainbackgroundColor,
      body: Center(
        child: Image.asset(
          "logo.png".imagePath,
          height: screenHeight * 0.35,
          width: screenWidth * 0.8,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
