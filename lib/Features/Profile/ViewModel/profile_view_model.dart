import 'dart:io';
import 'package:fastbag_vendor_flutter/Features/Profile/Model/update_shop_model.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/Model/vendor_model.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/Repository/profile_repository.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/widgets/update_status_dialog.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileRepository profileRepository = ProfileRepository();
  VendorModel? _vendor;
  VendorModel? get vendor => _vendor;

  getVendorProfile(
      {required int vendorId, required BuildContext context}) async {
    await profileRepository.getProfile(vendorId, context).then((data) {
      if (data.runtimeType == VendorModel) {
        _vendor = data;
        notifyListeners();
      }
    });
  }

  updateSettingsDetails(
      {required int vendorId,
      required BuildContext context,
      required Map<String, dynamic> settingsMap}) async {
    await profileRepository
        .postSettings(vendorId, context, settingsMap)
        .then((data) {
      if (data.runtimeType == VendorModel) {
        _vendor = data;
        notifyListeners();
      }
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: true, // Allow dismissing by tapping outside
        builder: (BuildContext context) => const UpdateStatusDialog(
          title: "Details updated",
        ),
      );
    });
  }

  updateShopLogo(
      {required int vendorId,
      required BuildContext context,
      required File logoFile}) async {
    await profileRepository
        .postShopLogo(vendorId, context, logoFile)
        .then((data) {
      if (data.runtimeType == VendorModel) {
        _vendor = data;
        notifyListeners();
      }
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: true, // Allow dismissing by tapping outside
        builder: (BuildContext context) => const UpdateStatusDialog(
          title: "Shop Logo updated",
        ),
      );
    });
  }

  updateShopDescription(
      {required int vendorId,
      required BuildContext context,
      required String description}) async {
    await profileRepository
        .postShopDescriptiom(vendorId, context,description )
        .then((data) {
      if (data.runtimeType == VendorModel) {
        _vendor = data;
        notifyListeners();
      }
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: true, // Allow dismissing by tapping outside
        builder: (BuildContext context) => const UpdateStatusDialog(
          title: "Shop Description updated",
        ),
      );
    });
  }

  updateShopImage(
      {required int vendorId,
      required BuildContext context,
      required File shopImage}) async {
    await profileRepository
        .postShopImage(vendorId, context,shopImage )
        .then((data) {
      if (data.runtimeType == VendorModel) {
        _vendor = data;
        notifyListeners();
      }
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: true, // Allow dismissing by tapping outside
        builder: (BuildContext context) => const UpdateStatusDialog(
          title: "Shop Image updated",
        ),
      );
    });
  }

  updateShopTiming(
      {required int vendorId,
      required BuildContext context,
      required String openTime,
      required String closeTime
      }) async {
    await profileRepository
        .postShopTiming(vendorId, context,openTime,closeTime )
        .then((data) {
      if (data.runtimeType == VendorModel) {
        _vendor = data;
        notifyListeners();
      }
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: true, // Allow dismissing by tapping outside
        builder: (BuildContext context) => const UpdateStatusDialog(
          title: "Shop Timing updated",
        ),
      );
    });
  }

  updateShopDetails(
      {required int vendorId,
      required BuildContext context,
      required UpdateShopModel model
      }) async {
    await profileRepository
        .postShopDetails(model, context, vendorId)
        .then((data) {
      if (data.runtimeType == VendorModel) {
        _vendor = data;
        notifyListeners();
      }
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: true, // Allow dismissing by tapping outside
        builder: (BuildContext context) => const UpdateStatusDialog(
          title: "Shop Details Updated",
          description: "Note : Some details may needs admin approval , will updated once approved !",
        ),
        
      );
    });
  }
}
