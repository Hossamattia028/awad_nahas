import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayfortCardsWidget extends StatelessWidget {
  const PayfortCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppImages.mada,width: 20.w,),
        const SizedBox(width: 4,),
        Image.asset(AppImages.visa,width: 20.w,),
        const SizedBox(width: 4,),
        Image.asset(AppImages.masterCard,width: 20.w,),
        const SizedBox(width: 4,),
        Image.asset(AppImages.amex,width: 20.w,),
      ],
    );
  }
}
