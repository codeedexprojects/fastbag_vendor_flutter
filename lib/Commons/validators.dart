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

String? discountValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return null;
  }
  final num? parsedValue = num.tryParse(value);
  if (parsedValue == null) {
    return 'Enter a valid number';
  }
  if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
    return 'Enter a valid number (e.g., 5, 5.5, or 5.55)';
  }
  if (parsedValue < 0 || parsedValue > 100) {
    return 'Discount must be between 0 and 100';
  }
  return null;
}

String? priceValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required';
  }
  if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
    return 'Enter a valid number (e.g., 5, 5.5, or 5.55)';
  }
  final num? parsedValue = num.tryParse(value);
  if (parsedValue == null) {
    return 'Enter a valid number';
  }
  if (parsedValue < 0) {
    return 'number must be above 0';
  }
  return null;
}
