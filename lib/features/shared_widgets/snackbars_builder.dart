import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnackBarBuilder {
  static showFeedBackMessage(BuildContext context, String message, Color color,
      {bool addBehaviour = true,bool isMarginBottom = false}) {

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        margin: isMarginBottom?EdgeInsets.only(bottom: 132.h):EdgeInsets.zero,
        behavior: addBehaviour ? SnackBarBehavior.floating : null,
        action: SnackBarAction(
            label: 'Dismiss',
            textColor: Colors.white,
            onPressed: () => ScaffoldMessenger.of(context).clearSnackBars),
      ),
    );
  }
}
