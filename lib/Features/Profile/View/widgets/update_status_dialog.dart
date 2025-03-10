import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;

import '../../../Dashboard/view/dashboard_screen.dart';

class UpdateStatusDialog extends StatefulWidget {
  final String title;
  final String? description;
  const UpdateStatusDialog({super.key, required this.title, this.description});

  @override
  State<UpdateStatusDialog> createState() => _UpdateStatusDialogState();
}

class _UpdateStatusDialogState extends State<UpdateStatusDialog>
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
          height: _animation.value * screenHeight * 0.45,
          transform: Matrix4.translationValues(
            0,
            screenHeight * 0.55 * (1 - _animation.value),
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
                  Center(
                    child: SvgPicture.asset(
                      'assets/icons/account_created.svg',
                      width: screenWidth * .15,
                      height: screenWidth * .15,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * .05),
                    child: Text(
                      widget.title,
                      style: mainFont(
                          fontsize: screenWidth * .05,
                          fontweight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  if (widget.description != null)
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * .05),
                      child: Text(
                        widget.description!,
                        style: mainFont(
                            fontsize: screenWidth * .035,
                            fontweight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  FbButton(
                      onClick: () {
                        _controller.reverse().then((_) => navigate(
                            context: context,
                            screen: DashboardScreen(),
                            type: NavigationType.pushAndRemoveUntil));
                      },
                      label: "Ok"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
