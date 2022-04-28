import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

abstract class ThemeStyles {
  static TextStyle title = GoogleFonts.nunitoSans(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
    fontSize: 38,
  );

  static TextStyle headline1 = GoogleFonts.nunitoSans(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    fontSize: 16.0,
  );

  static TextStyle showMore = GoogleFonts.nunitoSans(
    color: Colors.blueGrey,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    fontSize: 14.0,
  );

  static TextStyle jobTitle = GoogleFonts.nunitoSans(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    fontSize: 14.0,
  );

  static TextStyle company = GoogleFonts.nunitoSans(
    color: Colors.grey,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    fontSize: 12.0,
  );

  static TextStyle localisation = company;

  static TextStyle jobDescription = GoogleFonts.nunitoSans(
    color: Colors.lightBlue,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    fontSize: 12.0,
  );

  static TextStyle bodyHeadline = GoogleFonts.nunitoSans(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    fontSize: 12.0,
  );

  static TextStyle bodyGrey = GoogleFonts.nunitoSans(
    color: Colors.grey,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    fontSize: 12.0,
  );

  static TextStyle buttonTextLight = GoogleFonts.nunitoSans(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    fontSize: 12.0,
  );
}
