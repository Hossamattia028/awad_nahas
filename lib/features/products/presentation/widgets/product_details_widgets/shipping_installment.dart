import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ShippingAndInstallmentWidget extends StatelessWidget {
  const ShippingAndInstallmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       Row(
         children: [
           Image.asset(AppImages.shipping,width: 60.w,height: 80.h,fit: BoxFit.fill,),
           const SizedBox(width: 10,),
           Image.asset(AppImages.shippingT,width: 60.w,height: 80.h,fit: BoxFit.fill),
         ],
       ),


        Column(
          children: [
            CustomText(
              text: translate("products.delivery_service"),
              fontSize: AppStyle.average.sp+2,
            ),
            const SizedBox(width: 5,),
            CustomText(
              text: translate("products.shipping"),
              fontSize: AppStyle.small.sp+2,
              maxLine: 22,
            ),
            const SizedBox(height: 5,),
            CustomText(
              text: translate("products.install_service"),
              fontSize: AppStyle.average.sp+2,
            ),
            const SizedBox(width: 5,),
            CustomText(
              text: translate("products.install"),
              fontSize: AppStyle.small.sp+2,
              maxLine: 24,
            ),
          ],
        ),
      ],
    );
  }
}
