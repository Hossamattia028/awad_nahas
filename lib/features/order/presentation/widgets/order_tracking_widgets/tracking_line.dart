import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/circle_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';


class TrackingLineWidget extends StatelessWidget {
  const TrackingLineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const CircleDotsWidget(isEnabled: true,),
            Container(
              width: 6.w,
              height: 85.h,
              color: DMUtil.getRED().withOpacity(0.6),
            ),
            const CircleDotsWidget(isOpacity: true,),
            ///////////////////////////////
            Container(
              width: 6.w,
              height: 85.h,
              color: DMUtil.getRED().withOpacity(0.6),
            ),
            const CircleDotsWidget(isOpacity: true,),

          ],
        ),
        const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: translate("button.confirmed"),
              color: DMUtil.getD2C(),
              fontSize: AppStyle.average.sp,
            ),
            CustomText(
              text: translate("order.order_process"),
              color: DMUtil.getD2C(),
              fontSize: AppStyle.small.sp,
            ),
            SizedBox(height: 65.h,),
            CustomText(
              text: translate("order.ongoing"),
              color: DMUtil.getD2C(),
              fontSize: AppStyle.average.sp,
            ),
            SizedBox(height: 85.h,),
            CustomText(
              text: translate("order.delivered"),
              color: DMUtil.getD2C(),
              fontSize: AppStyle.average.sp,
            ),
          ],
        )

      ],
    );
  }
}
