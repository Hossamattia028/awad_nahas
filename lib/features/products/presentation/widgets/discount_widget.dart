
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountWidget extends StatelessWidget {
  final String value;
  const DiscountWidget({Key? key,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
      decoration: BoxDecoration(
          color: DMUtil.getRED(),
          borderRadius: const BorderRadius.all(Radius.circular(15))
      ),
      child: CustomText(
        text: '-15%',
        color: Colors.white,
        fontSize: AppStyle.small.sp+2,
      ),
    );
  }
}
