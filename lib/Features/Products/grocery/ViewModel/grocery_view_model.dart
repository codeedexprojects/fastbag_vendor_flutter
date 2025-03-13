import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/flush_bar.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/Repository/grocery_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class GroceryViewModel extends ChangeNotifier {
  final groceryRepo = GroceryRepository();

  addProduct(BuildContext context, data) async {
    SVProgressHUD.show();
    try {
      await groceryRepo.addProduct(data);
      showFlushbar(
          context: context,
          color: FbColors.buttonColor,
          icon: Icons.check,
          message: 'Product Added Successfully');
    } catch (e) {
      print(e);
      showFlushbar(
          context: context,
          color: Colors.red,
          icon: Icons.error_outline,
          message: 'Product Adding Failed');
    } finally {
      SVProgressHUD.dismiss();
    }
  }
}
