import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/add_sub_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../BottomNavigation/Dashboard/view/dashboard_screen.dart';

class AccountCreatedScreen extends StatelessWidget {
  const AccountCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget gap() {
      return SizedBox(height: MediaQuery.of(context).size.height * 0.15);
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 250, 250, 1),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * .05),
        child: Column(
          children: [
            gap(),
            Center(
              child: SvgPicture.asset(
                'assets/icons/account_created.svg',
                width: screenWidth * .2,
                height: screenWidth * .2,
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * .05),
                  child: Text(
                    "Account Created!",
                    style: mainFont(
                        fontsize: screenWidth * .05,
                        fontweight: FontWeight.w500,
                        color: Colors.black),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * .02),
              child: Text(
                "Set up your store and get your business ready for activation",
                style: mainFont(
                    fontsize: screenWidth * .035,
                    fontweight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: screenHeight * .02),
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/add_info.svg',
                    width: screenWidth * .1,
                    height: screenWidth * .1,
                  ),
                  title: const Text("Add business information"),
                  subtitle:
                      const Text("Add more information about your business"),
                )),
            Padding(
                padding: EdgeInsets.only(top: screenHeight * .02),
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/add_category.svg',
                    width: screenWidth * .1,
                    height: screenWidth * .1,
                  ),
                  title: const Text("Create your category/product list"),
                  subtitle: const Text(
                      "Add items to your product list with images  "),
                )),
            FbButton(
                onClick: () {
                  //navigate(context: context, screen: const AddSubCategoryScreen());
                },
                label: "Continue to Setup"),
            FbButton(
              onClick: () {
                navigate(context: context, screen: DashboardScreen());
              },
              label: "Skip for later",
              color: Colors.white,
              textColor: Colors.green,
              borderColor: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
