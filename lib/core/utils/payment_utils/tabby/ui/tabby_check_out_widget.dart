import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class TabbyCheckOutWidget extends StatelessWidget {
  final double price;
  const TabbyCheckOutWidget({super.key,required this.price});

  @override
  Widget build(BuildContext context) {
    double val = price / 4;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: translate("payment.pay_with_tabby") ,
            fontSize: AppStyle.average.sp,
            maxLine: 3,
          ),
          const SizedBox(height: 2,),
          SizedBox(
            width: 200.w,
            child: CustomText(
              text: "${translate("payment.tabby_check_out")} $val ${translate("store.sar")} ${translate("payment.without_any_interset")}" ,
              fontSize: AppStyle.small.sp,
              color: DMUtil.getD2C().withOpacity(0.7),
              maxLine: 3,
            ),
          ),
        ],
      ),
    );
  }
}


class TabbySmallProductWidget extends StatelessWidget {
  final double price;
  final bool isSmall;
  const TabbySmallProductWidget({super.key,required this.price,this.isSmall=false});

  @override
  Widget build(BuildContext context) {
    double val = price / 4;
    return Container(
      decoration:  BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1,color: kTabbyColor),
          color: DMUtil.getWC()
      ),
      margin: EdgeInsets.symmetric(horizontal: 2.w,vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 220.w,
            child: CustomText(
              text: "${translate("payment.tabby_check_out")} $val ${translate("store.sar")} ${translate("payment.without_any_interset")}" ,
              fontSize: isSmall ? AppStyle.small.sp - 2 : AppStyle.average.sp - 1,
              color: DMUtil.getD2C(),
              fontWeight: FontWeight.w600,
              maxLine: 3,
            ),
          ),
          Image.asset(AppImages.tabby,width: 80.w,height: 28.w,fit: BoxFit.fill,),
        ],
      ),
    );
  }
}