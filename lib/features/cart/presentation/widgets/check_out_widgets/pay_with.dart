import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/circle_dots.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';


class PayWithWidget extends StatelessWidget {
  const PayWithWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: translate("cart.pay_with"),
              color: DMUtil.getDC(),
              fontSize: AppStyle.average.sp,
            ),
            const SizedBox(height: 10,),
            Image.asset(AppImages.paymentRow,width: 80.w,),
            const SizedBox(height: 10,),
            Row(
              children: [
                const CircleDotsWidget(isEnabled: true,),
                const SizedBox(width: 10,),
                CustomText(
                  text: translate("cart.debit_credit"),
                  color: DMUtil.getDC(),
                  fontSize: AppStyle.average.sp,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
