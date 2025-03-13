import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/flush_bar.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/Repository/grocery_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class GroceryViewModel extends ChangeNotifier {
  final groceryRepo = GroceryRepository();

  addProduct(BuildContext context, data) async {
    data = {
      "vendor": 18,
      "category": 14,
      "sub_category": 2,
      "name": "Pothiyena",
      "wholesale_price": 10.00,
      "price": 15.00,
      "discount": 4,
      "description": "Fresh and organic Pothiyena from local farms.",
      "weight_measurement": "g",
      "Available": true,
      "is_offer_product": true,
      "is_popular_product": true,
      "weights": {
        "250g": {"price": 150.00, "quantity": 10, "in_stock": true},
        "500g": {"price": 300.00, "quantity": 8, "in_stock": true},
        "1kg": {"price": 500.00, "quantity": 5, "in_stock": true}
      }
    };
    SVProgressHUD.show();
    try {
      await groceryRepo.addProduct(data);
      showFlushbar(
          context: context,
          color: FbColors.buttonColor,
          icon: Icons.check_circle,
          message: 'Product Added Successfully');
    } catch (e) {
      print(e);
      showFlushbar(
          context: context,
          color: Colors.red,
          icon: Icons.check_circle,
          message: 'Product Adding Failed');
    } finally {
      SVProgressHUD.dismiss();
    }
  }
}
