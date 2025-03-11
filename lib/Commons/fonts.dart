import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle nunito({
  fontSize,
  fontBold = FontWeight.w500,
}) {
  return GoogleFonts.nunito(
      fontSize: fontSize, fontWeight: fontBold, color: Colors.black);
}

TextStyle mainFont(
    {required double fontsize,
    required FontWeight fontweight,
    required Color color}) {
  return GoogleFonts.poppins(
      fontSize: fontsize,
      fontWeight: fontweight,
      color: color,
     );
}

TextStyle normalFont(
    {required double fontsize,
    required FontWeight fontweight,
    required Color color}) {
  return GoogleFonts.tinos(
    fontSize: fontsize,
    fontWeight: FontWeight.bold,
    color: color,
  );
}

TextStyle normalFont1(
    {required double fontsize,
    required FontWeight fontweight,
    required Color color}) {
  return GoogleFonts.figtree(
    fontSize: fontsize,
    fontWeight: FontWeight.bold,
    color: color,
  );
}

TextStyle normalFont2(
    {required double fontsize,
    required FontWeight fontweight,
    required Color color}) {
  return GoogleFonts.figtree(
      fontSize: fontsize,
      fontWeight: FontWeight.bold,
      color: color,
      fontStyle: FontStyle.italic);
}

TextStyle normalFont3(
    {required double fontsize,
    required FontWeight fontweight,
    required Color color}) {
  return GoogleFonts.barlow(
      fontSize: fontsize,
      fontWeight: FontWeight.bold,
      color: color,
      // fontStyle: FontStyle.italic
      );
}

TextStyle normalFont4(
    {required double fontsize,
    required FontWeight fontweight,
    required Color color}) {
  return GoogleFonts.nunito(
      fontSize: fontsize,
      color: color,
      );
}
TextStyle normalFont5(
    {required double fontsize,
      required FontWeight fontweight,
      required Color color}) {
  return GoogleFonts.inder(
      fontSize: fontsize,
      fontWeight: FontWeight.bold,
      color: color,
      // fontStyle: FontStyle.italic
      );
}
TextStyle homeFont(
    {required double fontsize,
    required FontWeight fontweight,
    required Color color}) {
  return GoogleFonts.openSans(
    fontSize: fontsize,
    fontWeight: FontWeight.bold,
    color: color,
  );
}
