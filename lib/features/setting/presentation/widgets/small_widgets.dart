import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';


class SettingLineOption extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  const SettingLineOption({Key? key,required this.title,required this.iconPath,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 7.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              color: kPrimaryBlack,
              fontSize: AppStyle.average.sp,
              fontFamily: primaryFontBold,
            ),
            Icon(Icons.arrow_forward_ios,color: Colors.black45,size: 15.w),
          ],
        ),
      ),
    );
  }
}
