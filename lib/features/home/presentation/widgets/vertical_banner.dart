import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class VerticalBannerWidget extends StatelessWidget {
  const VerticalBannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(AppImages.bannerV,height: 250.h,width: 150.w,fit: BoxFit.fill,),
        Positioned(
            bottom: 30,
            left: Util.getLang()=="en_US"?20:0,
            right: Util.getLang()!="en_US"?20:0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "sub title",
                  color: DMUtil.getWC(),
                  fontSize: AppStyle.average.sp,
                ),
                CustomText(
                  text: "Title",
                  color: DMUtil.getWC(),
                  fontSize: AppStyle.large.sp,
                ),
                CustomText(
                  text: "From Price",
                  color: DMUtil.getWC(),
                  fontSize: AppStyle.large.sp,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: translate("store.shop_now"),
                      color: DMUtil.getWC(),
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
        ),
      ],
    );
  }
}
