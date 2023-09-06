import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class VatIncludedWidget extends StatelessWidget {
  const VatIncludedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33.h,
      width: 131.w,
      child: CustomText(
        text: translate("products.vat_included"),
        color: DMUtil.getOpacity(),
        fontSize: AppStyle.verySmall.sp-1,
        maxLine: 2,
      ),
    );
  }
}
