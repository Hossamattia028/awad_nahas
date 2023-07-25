import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
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
      children: [
        CustomText(
            text: translate("products.qty"),
            fontSize: AppStyle.small.sp,
        ),
        Container(
          width: 70.w,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            border: Border.all(width: 1,color: DMUtil.getRED())
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: DMUtil.getBCC(),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child: Icon(
                    Icons.add
                  ),
                ),
              ),
              CustomText(
                  text: "text",
                  fontSize: fontSize,
              ),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: DMUtil.getBCC(),
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child: Icon(
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
