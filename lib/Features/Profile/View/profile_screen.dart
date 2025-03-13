import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/add_fashion_product.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/widgets/fb_logout_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/edit_shop_details_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/settings.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_view_model.dart';
import 'package:fastbag_vendor_flutter/storage/fb_local_storage.dart';
import 'package:fastbag_vendor_flutter/storage/fb_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    FbStore.retrieveData(FbLocalStorage.vendorId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileViewModel>(context, listen: false);
    // profileProvider.getVendorProfile(vendorId: vendorId!, context: context);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final abc = true;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.05, horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile",
                style: GoogleFonts.nunito(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    height: 3),
              ),
              Container(
                height: screenHeight * 0.12,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 32,
                      backgroundColor:
                          Colors.grey[200], // Optional: Background color
                      child: ClipOval(
                        child: abc
                            ? const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.grey,
                              )
                            : Image.network(
                                'https://gratisography.com/wp-content/uploads/2024/11/gratisography-augmented-reality-800x525.jpg',
                                fit: BoxFit
                                    .cover, // Ensures the image fills the circle
                                width:
                                    64, // Diameter of the CircleAvatar (radius * 2)
                                height:
                                    64, // Diameter of the CircleAvatar (radius * 2)
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 35,
                                  ); // Optional: Handle loading errors
                                },
                              ),
                      ),
                    ),
                    title: Text("Yoonus",
                        style: nunito(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w700)),
                    subtitle: Text(
                      "Oorakam",
                      style: nunito(fontSize: screenWidth * 0.04),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'Let\'s see your business',
                style: nunito(fontSize: screenWidth * 0.04),
              ),
              SizedBox(height: screenHeight * 0.03),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Image.asset(
                        'assets/profileicon/shop.png',
                        width: 25,
                        height: 25,
                      ),
                      title: Text(
                        'Edit Shop Details',
                        style: nunito(
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      onTap: () {
                        // Handle edit shop details
                        navigate(
                            context: context,
                            screen: const EditShopDetailsScreen());
                      },
                    ),
                    ListTile(
                      leading: Image.asset(
                        'assets/profileicon/notification.png',
                        width: 25,
                        height: 25,
                      ),
                      title: Text(
                        'Notifications',
                        style: nunito(
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      onTap: () {
                        // Handle notifications
                      },
                    ),
                    ListTile(
                      leading: Image.asset(
                        'assets/profileicon/wallet.png',
                        width: 25,
                        height: 25,
                      ),
                      title: Text(
                        'Payments',
                        style: nunito(
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      onTap: () {
                        // Handle payments
                      },
                    ),
                    ListTile(
                      leading: Image.asset(
                        'assets/profileicon/setting.png',
                        width: 25,
                        height: 25,
                      ),
                      title: Text(
                        'Settings',
                        style: nunito(
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      onTap: () {
                        // Handle settings
                        navigate(context: context, screen: const Settings());
                      },
                    ),
                    ListTile(
                      leading: Image.asset(
                        'assets/profileicon/logout.png',
                        width: 25,
                        height: 25,
                      ),
                      title: Text(
                        'Log Out',
                        style: nunito(
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      onTap: () {
                        // Handle log out
                        showDialog(
                          context: context,
                          barrierDismissible:
                              true, // Allow dismissing by tapping outside
                          builder: (BuildContext context) =>
                              const FbLogoutDialog(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
