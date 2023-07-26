import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SortBottomSheetWidget extends StatelessWidget {
  const SortBottomSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290.h,
      color: DMUtil.getWC(),
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
      child:  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomText(
                    text: translate("store.sort_by"),
                    fontSize: AppStyle.average.sp,
                    alignCenter: true,
                  ),
                ),
                InkWell(
                  onTap: ()=> Navigator.of(context).pop(),
                  child: Icon(Icons.close,color: DMUtil.getDC(),),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            CheckBoxWidget(title: translate("store.popularity"),enabled: true),
            CheckBoxWidget(title: translate("store.averageـrating"),enabled: false),

            CheckBoxWidget(title: translate("store.newness"),enabled: false),

            CheckBoxWidget(title: translate("store.low_to_high"),enabled: false),

            CheckBoxWidget(title: translate("store.high_to_low"),enabled: false),


            const SizedBox(height: 10,),
          ],
        ),
      )
    );
  }
}


class CheckBoxWidget extends StatelessWidget {
  final String title ;
  final bool enabled;
  const CheckBoxWidget({Key? key,required this.title,required this.enabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 5.h),
      margin: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          border: Border.all(width: 0.5,color: DMUtil.getD2C())
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            fontSize: AppStyle.average.sp,
          ),

          if(enabled)
          CircleAvatar(
            backgroundColor: DMUtil.getRED(),
            radius: 10.w,
            child: Icon(Icons.check,color: Colors.white,size: 14.w,),
          ),


        ],
      ),
    );
  }
}



