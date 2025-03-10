import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle mainFont(
    {required double fontsize,
    required FontWeight fontweight,
    required Color color}) {
  return GoogleFonts.poppins(
      fontSize: fontsize, fontWeight: fontweight, color: color,letterSpacing: 1);
}

TextStyle normalFont(
    {required double fontsize,
    required FontWeight fontweight,
    required Color color}) {
  return GoogleFonts.tinos(
      fontSize: fontsize, fontWeight: FontWeight.bold, color: color,);
}

TextStyle normalFont1(
    {required double fontsize,
    required FontWeight fontweight,
    required Color color}) {
  return GoogleFonts.figtree(
      fontSize: fontsize, fontWeight: FontWeight.bold, color: color,);
}
TextStyle normalFont2(
    {required double fontsize,
    required FontWeight fontweight,
    required Color color}) {
  return GoogleFonts.figtree(
      fontSize: fontsize, fontWeight: FontWeight.bold, color: color,fontStyle: FontStyle.italic);
}
TextStyle normalFont3(
    {required double fontsize,
      required FontWeight fontweight,
      required Color color}) {
  return GoogleFonts.barlow(
      fontSize: fontsize, fontWeight: FontWeight.bold, color: color,fontStyle: FontStyle.italic);
}
TextStyle normalFont4(
    {required double fontsize,
      required FontWeight fontweight,
      required Color color}) {
  return GoogleFonts.nunito(
      fontSize: fontsize, fontWeight: FontWeight.bold, color: color,fontStyle: FontStyle.italic);
}

TextStyle homeFont(
    {required double fontsize,
    required FontWeight fontweight,
    required Color color}) {
  return GoogleFonts.openSans(
      fontSize: fontsize, fontWeight: FontWeight.bold, color: color,);
}

