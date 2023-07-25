import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class ProductDescription extends StatelessWidget {
  final String desc;
  const ProductDescription({Key? key,required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        const ImageWidget(imgUrl: testImg,height: 160,),
        const SizedBox(height: 5,),
        CustomText(
          text: "Charismatic identity",
          color: DMUtil.getDC(),
          fontSize: AppStyle.large.sp,
        ),
        CustomText(
            text: "This colorful range, inspired by the intense tones of the Mediterranean, offers exceptional performance and is characterized by the clean lines typical of professional kitchen design. The Portofino cooker expresses its unique charm in any position of the kitchen, whether built-in or countertop, providing a flash of unique color. The colored sides add the final touch, highlighting the precise attention to detail that transforms these luminaires into real design pieces.",
            color: DMUtil.getDC(),
            fontSize: AppStyle.average.sp,
            maxLine: 20,
        ),
      ],
    );
  }
}
