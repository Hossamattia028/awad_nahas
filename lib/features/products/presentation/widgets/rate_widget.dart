import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class RateWidget extends StatelessWidget {
  final int countRate;
  const RateWidget({super.key,required this.countRate});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if(countRate!=0)
        CustomText(
          text: "($countRate)",
          color: kText1,
          fontWeight: FontWeight.w400,
          fontSize: AppStyle.verySmall.sp,
          isEllipsis: true,
        ),
        Container(
          height: 19.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: kBackGreenColor
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.star_rate,size: 10,color: Colors.white,),
              CustomText(
                text: "4.5",
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: AppStyle.verySmall.sp,
                isEllipsis: true,
              ),
            ],
          ),
        )
      ],
    );
  }
}
