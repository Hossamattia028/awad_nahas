import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWidget extends StatelessWidget {
  final double width;
  final double height;
  final BoxFit fit;
  final bool isWhite;
  const LogoWidget({Key? key,this.height=30,this.width=double.infinity,this.fit=BoxFit.fill,this.isWhite = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: DMUtil.currentThemeIsDark() ?
      SvgPicture.asset(AppImages.whiteLogoSvg,width: width.w,fit: fit,) :
      Image.asset(isWhite? AppImages.logoWhite:AppImages.logo,height: height.h,width: width.w,fit: fit,),
    );
  }
}
