import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 200,),

          Image.asset(AppImages.logo,height: 130.h,fit: BoxFit.cover,),
          const SizedBox(height: 10,),
          CustomText(
            text: translate("cart.empty"),
            color: DMUtil.getPC(),
            fontWeight: FontWeight.w700,
            fontSize: AppStyle.small.sp,
          ),
          CustomText(
            text: translate("cart.sure_to_add"),
            color: DMUtil.getPC(),
            fontWeight: FontWeight.w400,
            fontSize: AppStyle.small.sp,
          ),
        ],
      ),
    );
  }
}
