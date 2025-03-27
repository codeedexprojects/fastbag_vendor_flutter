import 'package:flutter/material.dart';

import 'fonts.dart';

class CustumInputDecoration{
  static InputDecoration getDecoration({required String labelText}){
    return InputDecoration(
      label: Text(labelText),
      labelStyle: nunito(color: Colors.grey.shade600, fontWeight: FontWeight.w300),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.red.shade300),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }
}