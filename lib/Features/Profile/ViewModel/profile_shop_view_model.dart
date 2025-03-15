import 'dart:io';

import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/Model/profile_shop_model.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/Repository/profile_repository.dart';
import 'package:flutter/cupertino.dart';

import '../Repository/profile_shop_repository.dart';

class ProfileShopViewModel extends ChangeNotifier{
  final ProfileShopRepository _profileShopRepository=ProfileShopRepository();

  ProfileShopModel? _shop;
  ProfileShopModel? get shop => _shop;


  getShopProfile(
      { required BuildContext context}) async {
    await _profileShopRepository.getShopProfile(context).then((data) {
      if (data.runtimeType == ProfileShopModel) {
        _shop = data;
        notifyListeners();
      }
    });
  }


  updateShopProfile(
      { required BuildContext context, required Map<String, dynamic> updatesMap}) async {
    await _profileShopRepository.updateShopProfile(context,updatesMap).then((data) {
      if (data.runtimeType == ProfileShopModel) {
        _shop = data;
        notifyListeners();
      }
    });
  }

  updateShopLogo(
      { required BuildContext context,required File logoFile}) async {
    await _profileShopRepository.updateShopLogo(context,logoFile).then((data) {
      if (data.runtimeType == ProfileShopModel) {
        _shop = data;
        notifyListeners();
      }
    });
  }

  updateShopImage(
      { required BuildContext context,required File shopImage}) async {
    await _profileShopRepository.updateShopImage(context,shopImage).then((data) {
      if (data.runtimeType == ProfileShopModel) {
        _shop = data;
        notifyListeners();
      }
    });
  }

  updateShopDescription(
      { required BuildContext context,required String Description}) async {
    await _profileShopRepository.updateShopDescription(context,Description).then((data) {
      if (data.runtimeType == ProfileShopModel) {
        _shop = data;
        notifyListeners();
      }
    });
  }

  updateShopTime(
      { required BuildContext context,required String openTime,required String closingTime}) async {
    await _profileShopRepository.updateShopTime(context,openTime,closingTime).then((data) {
      if (data.runtimeType == ProfileShopModel) {
        _shop = data;
        notifyListeners();
      }
    });
  }

}