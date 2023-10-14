import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyle {
  //Font Text Style

  static const double z30 = 10.7;
  static const double z28 = 10.4;
  static const double z25 = 8.9;
  static const double z24 = 8.6;
  static const double z22 = 7.9;
  static const double verySmall = 9;
  static const double small = 12.5;
  static const double average = 14.5;
  static const double large = 17.9;
  static const double veryLarge = 22;

  static double appBarHeight = Platform.isIOS?60:53;

  static double paddingFromTop = Platform.isIOS?47:41;
  static const double paddingFromH = 11;
  static double paddingFromV = Platform.isIOS?42:24;


  static double iconsSize = 10.h + 10.w;


}
