import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class TamaraSmallProductWidget extends StatelessWidget {
  final double price;
  const TamaraSmallProductWidget({Key? key,required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double val = price / 4;
    return Container(
      decoration:  BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1,color: kTamaraColor)
      ),
      padding: const EdgeInsets.symmetric(vertical: 10,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 220.w,
            child: CustomText(
              text: "${translate("payment.tamra_txt")} $val ${translate("store.sar")} ${translate("payment.interest-free")}" ,
              fontSize: AppStyle.average.sp,
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
  const TamaraSmallCheckOutWidget({Key? key,required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double val = price / 4;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(Util.getLang()=="ar"?AppImages.tamaraAr:AppImages.tamaraEn,width: 55.w,fit: BoxFit.fill,),
          const SizedBox(width: 10,),
          SizedBox(
            width: 200.w,
            child: CustomText(
              text: "${translate("payment.tamra_txt")} $val ${translate("store.sar")} ${translate("payment.interest-free")}" ,
              fontSize: AppStyle.small.sp,
              maxLine: 3,
            ),
          ),
        ],
      ),
    );
  }
}
