import 'package:flutter/material.dart';

InputDecoration searchBarDecoration({required String hint, required icon}) {
  return InputDecoration(
    hintText: hint,
    prefixIcon: Icon(icon),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey, width: 0.5),
    ),
  );
}
