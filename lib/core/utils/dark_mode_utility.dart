import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class DMUtil{

  static bool currentThemeIsDark(){
    return SharedPref().getPreferenceString(Constants.userTheme).toString().trim()=="dark";
  }
  /// get primary color
  static Color getPC(){
    return kPrimary;
  }

  /// get background color
  static Color getBC(){
    return currentThemeIsDark()?kDark:kWhite;
  }

  /// get background color
  static Color getWC(){
    return currentThemeIsDark()?kDark:kWhite;
  }

  static Color getWCCat(){
    return currentThemeIsDark()?kRed:kWhite;
  }


  /// get background color
  static Color getRED(){
    return kRed;
  }


  static Color getGreen(){
    return currentThemeIsDark() ? kWhite : const  Color(0xff007F2D);
  }

  static Color getREdOPACITY(){
    return kRed.withOpacity(0.4);
  }

  /// get categories background color
  static Color getBCC(){
    return kBackGround;
  }

  static Color getBCD(){
    return currentThemeIsDark()?kRed:kBackGround;
  }

  static Color getBCIcon(){
    return currentThemeIsDark()?kWhite:kRed;
  }

  /// get Dark Color
  static Color getDC(){
    return currentThemeIsDark()?kWhite:kBlack;
  }

  /// get Dark Color
  static Color getD2C(){
    return currentThemeIsDark()?kBackGround:kBlack2;
  }

  static Color getDLight(){
    return currentThemeIsDark()?kWhite:kDark;
  }


}