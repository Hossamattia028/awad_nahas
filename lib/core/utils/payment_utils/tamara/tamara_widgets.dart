import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class TamaraSmallProductWidget extends StatelessWidget {
  final double price;
  final bool isSmall;
  const TamaraSmallProductWidget({super.key,required this.price,this.isSmall=false});

  @override
  Widget build(BuildContext context) {
    double val = price / 4;
    return Container(
      decoration:  BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1,color: kTamaraColor),
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
              text: "${translate("payment.tamra_txt")} $val ${translate("store.sar")} ${translate("payment.interest-free")}" ,
              fontSize: isSmall ? AppStyle.small.sp - 2 : AppStyle.average.sp ,
              color: DMUtil.getD2C(),
              fontWeight: isSmall?FontWeight.w600:FontWeight.w500,
              maxLine: 3,
            ),
          ),
          Image.asset(Util.getLang()=="ar"?AppImages.tamaraAr:AppImages.tamaraEn,width: 80.w,fit: BoxFit.fill,),
        ],
      ),
    );
  }
}


class TamaraSmallCheckOutWidget extends StatelessWidget {
  final double price;
  const TamaraSmallCheckOutWidget({super.key,required this.price});

  @override
  Widget build(BuildContext context) {
    double val = price / 4;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: translate("payment.tamara") ,
            fontSize: AppStyle.average.sp,
            maxLine: 3,
          ),
          const SizedBox(height: 2,),
          SizedBox(
            width: 170.w,
            child: CustomText(
              text: "${translate("payment.tamra_txt")} $val ${translate("store.sar")} ${translate("payment.interest-free")}" ,
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
