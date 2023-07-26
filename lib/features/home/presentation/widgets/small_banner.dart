import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SmallBannerWidget extends StatelessWidget {
  const SmallBannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 145.h,
        width: 170.w,
        padding: const EdgeInsets.only(top: 40,left: 20,right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: const DecorationImage(
                image: AssetImage(AppImages.bannerS,),
                fit: BoxFit.fill
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(
            text: "Title",
            color: Colors.white,
            fontSize: AppStyle.large.sp,
          ),
          CustomText(
            text: "From Price",
            color: Colors.white,
            fontSize: AppStyle.large.sp,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: translate("store.shop_now"),
                color: Colors.white,
                fontSize: AppStyle.large.sp,
                alignCenter: true,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 7,left: 5,right: 5),
                child: Icon(Icons.arrow_forward,color: Colors.white,size: 20,),
              ),
            ],
          ),
        ],
      )
    );
  }
}
