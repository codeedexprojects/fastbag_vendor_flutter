import 'package:fastbag_vendor_flutter/Commons/strings.dart';
import 'package:fastbag_vendor_flutter/Extentions/reg_exp.dart';

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return fieldRequired;
  } else if (!emailRegExp.hasMatch(value)) {
    return errorEmail;
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter your password.";
  }
  if (value.length < 6) {
    return "Password must be at least 6 characters.";
  }
  return null;
}

String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter your phone number.";
  }
  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
    return "Invalid phone number.";
  }
  return null;
}


String? customValidator(String? value) {
  if (value == null || value.isEmpty) {
    return fieldRequired;
  } else if (spaceRegExp.hasMatch(value)) {
    return spaceError;
  }
  return null;
}

String? customValidatornoSpaceError(String? value) {
  if (value == null || value.isEmpty) {
    return fieldRequired;
  }
  return null;
}