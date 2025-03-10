import '../../Dashboard/view/dashboard_screen.dart';
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
            navItem("dashboard", "Dashboard", 0),
            navItem("product", "Products", 1),
            navItem("order", "Orders", 2),
            navItem("person", "Profile", 3)
          ]),
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
