import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/widgets/fb_logout_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/edit_shop_details_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/settings.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_view_model.dart';
import 'package:fastbag_vendor_flutter/storage/fb_local_storage.dart';
import 'package:fastbag_vendor_flutter/storage/fb_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int? vendorId;
  @override
  void initState() {
    FbStore.retrieveData(FbLocalStorage.vendorId).then((data) {
      print(data);
      setState(() {
        vendorId = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (vendorId != null) {
      final profileProvider =
          Provider.of<ProfileViewModel>(context, listen: false);
      if (profileProvider.vendor == null) {
        profileProvider.getVendorProfile(vendorId: vendorId!, context: context);
      }
    }
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.05, horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile",
                  style: mainFont(
                      fontsize: screenWidth * 0.05,
                      fontweight: FontWeight.w500,
                      color: Colors.black),
                ),
                Container(
                  height: screenHeight * 0.12,
                  width: screenWidth * 0.9,
                  color: const Color.fromRGBO(247, 253, 247, 1),
                  child: Center(
                    child:
                        Consumer<ProfileViewModel>(builder: (context, data, _) {
                      return data.vendor == null
                          ? const SizedBox()
                          : ListTile(
                              leading: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors
                                    .grey[200], // Optional: Background color
                                child: ClipOval(
                                  child: Image.network(
                                    data.vendor!.store_logo,
                                    fit: BoxFit
                                        .cover, // Ensures the image fills the circle
                                    width:
                                        64, // Diameter of the CircleAvatar (radius * 2)
                                    height:
                                        64, // Diameter of the CircleAvatar (radius * 2)
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error,
                                          color: Colors
                                              .red); // Optional: Handle loading errors
                                    },
                                  ),
                                ),
                              ),
                              title: Text(
                                data.vendor!.business_name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(data.vendor!.bussiness_location),
                            );
                    }),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                const Text('Let\'s see your business'),
                SizedBox(height: screenHeight * 0.03),
                Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.45,
                  color: const Color.fromRGBO(247, 253, 247, 1),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('Edit Shop Details'),
                        onTap: () {
                          // Handle edit shop details
                          navigate(
                              context: context,
                              screen: const EditShopDetailsScreen());
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.notifications),
                        title: const Text('Notifications'),
                        onTap: () {
                          // Handle notifications
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.payment),
                        title: const Text('Payments'),
                        onTap: () {
                          // Handle payments
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Settings'),
                        onTap: () {
                          // Handle settings
                          navigate(context: context, screen: const Settings());
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Log Out'),
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
      ),
    );
  }
}
