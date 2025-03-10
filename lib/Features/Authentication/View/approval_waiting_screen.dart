import 'dart:async';

import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/Repository/auth_repository.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_auth_title.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class ApprovalWaitingScreen extends StatefulWidget {
  final int id;

  const ApprovalWaitingScreen({super.key, required this.id});

  @override
  _ApprovalWaitingScreenState createState() => _ApprovalWaitingScreenState();
}

class _ApprovalWaitingScreenState extends State<ApprovalWaitingScreen> {
  late final AuthRepository _authRepository;
  Timer? _approvalCheckTimer;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository();
    _startApiCall();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _approvalCheckTimer?.cancel();
    super.dispose();
  }

  void _startApiCall() {
    _approvalCheckTimer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      final success = await _authRepository.checkAdminApproval(widget.id, context);
      if (success) {
        timer.cancel();
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: FbColors.mainbackgroundColor,
      body: Center(
        child: SizedBox(
          height: screenHeight * 0.6,
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/waiting_icon.svg',
                width: screenWidth * .4,
                height: screenWidth * .4,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
                child: const FbAuthTitle(
                  title: "Waiting For Approval",
                  fontWidth: .06,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * .15),
                child: const Text("Try to wait a bit and try again!"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .07,
                  vertical: screenHeight * .02,
                ),
                child: FbButton(
                  onClick: () {
                    SystemNavigator.pop();
                  },
                  label: "CLOSE",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
