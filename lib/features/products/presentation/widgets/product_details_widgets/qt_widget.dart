import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProductQuantityWidget extends StatelessWidget {
  const ProductQuantityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: translate("products.qty"),
            fontSize: AppStyle.small.sp,
        ),
        Container(
          width: 80.w,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(width: 1,color: DMUtil.getRED())
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: DMUtil.getBCC(),
                    borderRadius: const BorderRadius.all(Radius.circular(12))
                  ),
                  child: const Icon(
                    Icons.add
                  ),
                ),
              ),
              CustomText(
                  text: "1",
                  fontSize: AppStyle.small.sp,
              ),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: DMUtil.getBCC(),
                      borderRadius: const BorderRadius.all(Radius.circular(12))
                  ),
                  child: const Icon(
                      Icons.remove
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
