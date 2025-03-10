import 'package:fastbag_vendor_flutter/Features/Authentication/Model/register_model.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/Repository/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  AuthRepository authRepository = AuthRepository();

  userRegister(
      {required RegisterModel registerVendor,
      required BuildContext context}) async {
    await authRepository.registerVendor(registerVendor, context);
    notifyListeners();
  }

  vendorLogin({
    required String email,required String password,required BuildContext context
  }) async{
    await authRepository.loginVendor(email, password, context);
  }
}
