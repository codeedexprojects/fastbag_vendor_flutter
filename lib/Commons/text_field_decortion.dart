import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

InputDecoration searchBarDecoration({
  required String hint,
}) {
  return InputDecoration(
      hintText: hint,
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 25, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/search.svg',
              height: 26,
            ),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 25),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey, width: 0.5)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey, width: 0.5)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade900, width: 0.5),
      ));
}
