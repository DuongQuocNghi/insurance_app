import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontConfig {
  static TextTheme get textTheme => GoogleFonts.robotoTextTheme();

  static TextStyle get h1 =>
      GoogleFonts.roboto(fontSize: 96, fontWeight: FontWeight.w900);

  static TextStyle get h2 =>
      GoogleFonts.roboto(fontSize: 54, fontWeight: FontWeight.w100);

  static TextStyle get h3 =>
      GoogleFonts.roboto(fontSize: 36, fontWeight: FontWeight.w100);

  static TextStyle get body =>
      GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.normal);

  static TextStyle get bodyBold =>
      GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold);

  static TextStyle get caption => GoogleFonts.roboto(fontSize: 14);

  static TextStyle get button =>
      GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold);
}
