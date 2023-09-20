import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class BackToTopWidget extends StatelessWidget {
  const BackToTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.h,
      width: 105.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: DMUtil.getD2C(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.arrow_upward,color: DMUtil.getWC(),size: AppStyle.small.w,),
          const SizedBox(width: 5,),
          CustomText(
            text: translate("products.back_to_top"),
            fontSize: AppStyle.small.sp - 2,
            fontWeight: FontWeight.w600,
            color: DMUtil.getWC(),
          ),
        ],
      )
    );
  }
}
