import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';


class OutOfStock extends StatelessWidget {
  final double width;
  const OutOfStock({Key? key,this.width=90}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      child: CustomText(
          text: translate("home.out_of_stock"),
          color: Colors.red,
          fontSize: AppStyle.verySmall.sp - 2,
      ),
    );
  }
}
