
import 'package:fastbag_vendor_flutter/Features/Dashboard/view_model/dash_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/fooddetail_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/view_model/grocery_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/ViewModel/auth_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/category_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/ViewModel/product_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/ViewModel/profile_view_model.dart';
import 'package:fastbag_vendor_flutter/Features/Splash/View/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'Features/Products/fashion/view_model/fashion_category_view_model.dart';
import 'Features/Products/fashion/view_model/fashiondetail_view_model.dart';
import 'Features/Products/fashion/view_model/fashionproduct_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Initialize the locale and print success
    await initializeDateFormatting('en_IN', null);
    print('Locale en_IN initialized successfully');
    Intl.defaultLocale = 'en_IN';
  } catch (e) {
    print('Error during locale initialization: $e');
  }


  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>AuthViewModel()),
      ChangeNotifierProvider(create: (_)=>CategoryViewModel()),
      ChangeNotifierProvider(create: (_)=>ProfileViewModel()),
      ChangeNotifierProvider(create: (_)=>ProductViewModel()),
      ChangeNotifierProvider(create: (_)=>DashViewModel()),
      ChangeNotifierProvider(create: (_)=>FoodViewModel()),
      ChangeNotifierProvider(create: (_)=>FashionCategoryViewModel()),
      ChangeNotifierProvider(create: (_)=>FashiondetailViewModel()),
      ChangeNotifierProvider(create: (_)=>FashionProductViewModel()),
      ChangeNotifierProvider(create: (_)=>GroceryViewModel()),

    ],
    child: const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor:
              const Color(0xFFF5F5F5), // Global scaffold color

          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
