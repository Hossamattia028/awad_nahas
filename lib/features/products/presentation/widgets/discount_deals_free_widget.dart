import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class FreeWidget extends StatelessWidget {
  const FreeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 1.w),
      decoration: const BoxDecoration(
        color: kFreeColor,
        borderRadius: BorderRadius.all(Radius.circular(3))
      ),
      child: CustomText(
        text: translate("cart.free"),
        color: DMUtil.getWC(),
        fontSize: AppStyle.small.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}