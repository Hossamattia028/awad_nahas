import 'dart:io';

class AppStyle {
  //Font Text Style

  static const double z30 = 10.7;
  static const double z28 = 10.4;
  static const double z25 = 8.9;
  static const double z24 = 8.6;
  static const double z22 = 7.9;
  static const double verySmall = 9;
  static const double small = 11;
  static const double average = 13;
  static const double large = 17.9;
  static const double veryLarge = 22;

  static double appBarHeight = Platform.isIOS?55:50;

  static double paddingFromTop = Platform.isIOS?31:26;
  static const double paddingFromH = 15;
  static double paddingFromV = Platform.isIOS?42:24;
}
