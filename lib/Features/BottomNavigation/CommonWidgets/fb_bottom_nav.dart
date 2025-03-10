import '../Dashboard/view/dashboard_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Orders/View/order_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Products/View/category_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FbBottomNav extends StatefulWidget {
  const FbBottomNav({super.key});

  @override
  State<FbBottomNav> createState() => _FbBottomNavState();
}

class _FbBottomNavState extends State<FbBottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    CategoryScreen(),
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
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: const IconThemeData(color: Colors.green),
          showUnselectedLabels: true,
          items: [
            navItem("nav1", "Dashboard", 0),
            navItem("nav2", "Products", 1),
            navItem("nav3", "Orders", 2),
            navItem("nav4", "Profile", 3)
          ]),
    );
  }

  BottomNavigationBarItem navItem(String svgName, String label, int count) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/$svgName.svg',
          width: 25,
          height: 25,
          colorFilter: count == _selectedIndex
              ? const ColorFilter.mode(Colors.green, BlendMode.srcIn)
              : null,
        ),
        label: label);
  }
}
