import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/fashion_category.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view/grocery_category_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Dashboard/view/dashboard_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Orders/View/order_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../Products/food/View/category_screen.dart';

class FbBottomNav extends StatefulWidget {
  const FbBottomNav({super.key});

  @override
  State<FbBottomNav> createState() => _FbBottomNavState();
}

class _FbBottomNavState extends State<FbBottomNav> {
  int _selectedIndex = 0;
  String? vendorType;

  @override
  void initState() {
    super.initState();
    getVendor();
  }

  Future<void> getVendor() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      vendorType = prefs.getString("vendorType");
    });
    print("Vendor Type = $vendorType");
  }

  final List<Widget> _screens = [
    DashboardScreen(),
    FoodCategoryScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  final List<Widget> _fashion = [
    DashboardScreen(),
    FashionCategoryScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  final List<Widget> _grocery = [
    DashboardScreen(),
    GroceryCategoryScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> currentScreens = vendorType == "Restaurent"
        ? _screens
        : vendorType == "Fashion"
        ? _fashion
        : vendorType == "Grocery"
        ? _grocery
        : _screens;

    return Scaffold(
      body: currentScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(color: Colors.green),
        showUnselectedLabels: true,
        items: [
          navItem("dashboard", "Dashboard", 0),
          navItem("product", "Category", 1),
          navItem("order", "Orders", 2),
          navItem("person", "Profile", 3)
        ],
      ),
    );
  }

  BottomNavigationBarItem navItem(String pngName, String label, int count) {
    return BottomNavigationBarItem(
      icon: ColorFiltered(
        colorFilter: count == _selectedIndex
            ? const ColorFilter.mode(Colors.green, BlendMode.srcIn)
            : const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        child: Image.asset(
          'assets/icons/$pngName.png',
          width: 20,
          height: 20,
        ),
      ),
      label: label,
    );
  }
}
