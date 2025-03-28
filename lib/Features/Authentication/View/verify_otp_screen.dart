import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/Widgets/fb_auth_title.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/account_created_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/ViewModel/auth_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_nav.dart';
import 'package:fastbag_vendor_flutter/storage/fb_local_storage.dart';
import 'package:fastbag_vendor_flutter/storage/fb_store.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;
  final String password;
  const VerifyOtpScreen(
      {super.key, required this.email, required this.password});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  var otpController1 = TextEditingController();
  var otpController2 = TextEditingController();
  var otpController3 = TextEditingController();
  var otpController4 = TextEditingController();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();

  final Dio _dio = Dio();
  bool isResendEnabled = false;
  int resendCountDown = 60;
  bool isSubmitting = false;
  Timer? _timer;
  String? otp;

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  getOtp() async {
    otp = await StoreManager().getOtp();
  }

  void verifyOtp() async {
    final StoreManager tokenManager = StoreManager();
    final otp = otpController1.text +
        otpController2.text +
        otpController3.text +
        otpController4.text;

    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the complete OTP!")),
      );
      return;
    }

    try {
      setState(() {
        isSubmitting = true;
      });

      final response = await _dio.post(
        '${baseUrl}vendors/vendor/verify-otp/', // Replace with your API URL
        data: {
          "email": widget.email,
          "otp": otp,
        },
      );

      if (response.statusCode == 200) {
        print(response.data);

        FbStore.storeData(
            FbLocalStorage.vendorId, response.data['Vendor-Admin']);

        String accessToken = response.data['access'];
        String refreshToken = response.data['refresh'];
        bool isApproved = response.data['is_approved'];
        String storeType = response.data['store'];
        print(" nejebhbubpuefbpewuf ${response.data['store']}");

        // Save tokens
        await tokenManager.saveTokens(accessToken, refreshToken);
        await tokenManager.saveApprovalStatus(isApproved);
        await tokenManager.saveStoreType(storeType);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP verified successfully!")),
        );
        // Navigate to the next screen
        navigate(
            context: context,
            screen: FbBottomNav(),
            type: NavigationType.pushAndRemoveUntil);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid OTP. Please try again!")),
        );
      }
    } on DioException catch (dioError) {
      print("Somthing Happend${dioError.response}");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e}")),
      );
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  void resendOtp() async {
    try {
      setState(() {
        isSubmitting = true;
        isResendEnabled = false;
        resendCountDown = 60;
      });

      final response = await _dio.post(
        '${baseUrl}vendors/vendor/login/', // Replace with your API URL
        data: {
          "email": widget.email,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP resent successfully!")),
        );
        otpController1.clear();
        otpController2.clear();
        otpController3.clear();
        otpController4.clear();

        FocusScope.of(context).unfocus();
        focusNode1.requestFocus();

        startResendTimer();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Failed to resend OTP. Please try again!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  Widget _gap(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.02);
  }

  void startResendTimer() {
    setState(() {
      resendCountDown = 60;
      isResendEnabled = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (resendCountDown > 0) {
          resendCountDown--;
        } else {
          isResendEnabled = true;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final auth = Provider.of<AuthViewModel>(context);
    return Scaffold(
        backgroundColor: FbColors.mainbackgroundColor,
        appBar: AppBar(
          backgroundColor: FbColors.mainbackgroundColor,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * .07, vertical: screenHeight * .02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _gap(context),
              const FbAuthTitle(title: "Verify Account", fontWidth: .07),
              _gap(context),
              Text(
                'Please type the verification code send',
                style: mainFont(
                    fontsize: screenHeight * .017,
                    fontweight: FontWeight.normal,
                    color: Colors.grey),
              ),
              Text(
                'to ${widget.email} otp : ${auth.loginResponse?.otp}',
                style: mainFont(
                    fontsize: screenHeight * .017,
                    fontweight: FontWeight.normal,
                    color: Colors.grey),
              ),
              _gap(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOtpBox(otpController1, focusNode1),
                  _buildOtpBox(otpController2, focusNode2),
                  _buildOtpBox(otpController3, focusNode3),
                  _buildOtpBox(otpController4, focusNode4),
                ],
              ),
              _gap(context),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    minWidth: screenWidth * 0.9,
                    onPressed: isSubmitting ? null : verifyOtp,
                    color: Colors.green,
                    child: isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Verify Account",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
              _gap(context),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: isResendEnabled ? resendOtp : null,
                  child: Text(
                    isResendEnabled
                        ? "Resend Code"
                        : "Resend Code in $resendCountDown seconds",
                    style: TextStyle(
                      fontSize: 16,
                      color: isResendEnabled ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ),
              // FbButton(onClick: () {}, label: "RESET PASSWORD")
            ],
          ),
        ));
  }

  Widget _buildOtpBox(TextEditingController controller, FocusNode focusNode) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus(); // Move to the next box
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController1.dispose();
    otpController2.dispose();
    otpController3.dispose();
    otpController4.dispose();

    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    super.dispose();
  }
}
