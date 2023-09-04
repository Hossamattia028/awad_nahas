import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
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
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(AppImages.tamara,width: 65.w,fit: BoxFit.fill,),
            SizedBox(
              width: 220.w,
              child: CustomText(
                  text: "${translate("payment.tamra_txt")} $val ${translate("store.sar")} ${translate("payment.interest-free")}" ,
                  fontSize: AppStyle.average.sp,
                  maxLine: 3,
              ),
            ),
          ],
        ),
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
          Image.asset(AppImages.tamara,width: 55.w,fit: BoxFit.fill,),
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
