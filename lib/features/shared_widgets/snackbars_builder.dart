import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnackBarBuilder {
  static showFeedBackMessage(BuildContext context, String message, Color color,
      {bool addBehaviour = true,bool isMarginBottom = false}) {

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,style: TextStyle(fontSize: AppStyle.small.sp-1,fontFamily: primaryFontReg),),
        backgroundColor: color,
        margin: isMarginBottom?EdgeInsets.only(bottom: 132.h):EdgeInsets.zero,
        padding: EdgeInsets.all(4.w),
        behavior: addBehaviour ? SnackBarBehavior.floating : null,
        duration: const Duration(milliseconds: 1000),
        action: SnackBarAction(
            label: "",
            textColor: DMUtil.getWC(),
            onPressed: () => ScaffoldMessenger.of(context).clearSnackBars),
      ),
    );
  }
}