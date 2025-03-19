import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;

class FashionFbBottomDialog extends StatefulWidget {
  final String text;
  final String descrription;
  final FbBottomDialogType type;
  final VoidCallback ontap;
  const FashionFbBottomDialog(
      {super.key,
        required this.text,
        required this.descrription,
        required this.type, required this.ontap});

  @override
  State<FashionFbBottomDialog> createState() => _FbBottomDialogState();
}

class _FbBottomDialogState extends State<FashionFbBottomDialog>
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
                      widget.text,
                      style: mainFont(
                          fontsize: screenWidth * .05,
                          fontweight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * .02),
                    child: Text(
                      widget.descrription,
                      style: mainFont(
                          fontsize: screenWidth * .035,
                          fontweight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                  if (widget.type == FbBottomDialogType.addSubCategory ||
                      widget.type == FbBottomDialogType.editSubCategory)
                    GestureDetector(
                      onTap: widget.ontap,
                      child: FbButton(
                          onClick: () {
                            // _controller.reverse().then((_) =>
                            //     Navigator.pop(context)
                            // );
                          },
                          label: "View"),
                    ),
                  if (widget.type ==
                      FbBottomDialogType.editSubCategoryNotPossible)
                    FbButton(
                        color: Colors.white,
                        borderColor: Colors.green,
                        textColor: Colors.green,
                        onClick: () {
                          _controller
                              .reverse()
                              .then((_) => Navigator.pop(context));
                        },
                        label: "Cancel"),
                  if (widget.type == FbBottomDialogType.addSubCategory ||
                      widget.type == FbBottomDialogType.editSubCategory)
                    FbButton(
                        onClick: () {
                          _controller
                              .reverse()
                              .then((_) => Navigator.pop(context));
                        },
                        color: Colors.white,
                        borderColor: Colors.green,
                        textColor: Colors.green,
                        label: widget.type == FbBottomDialogType.editSubCategory
                            ? "Update again"
                            : "Add more sub category")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum FbBottomDialogType {
  addSubCategory,
  editSubCategory,
  editSubCategoryNotPossible,
}
