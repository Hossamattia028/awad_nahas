import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconWidget extends StatelessWidget {
  final String iconUrl;
  const SvgIconWidget({Key? key,required this.iconUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: DMUtil.getBCD(),
      radius: 26.w,
      child:iconUrl.contains("file:///")||iconUrl.isEmpty?
      Image.asset(AppImages.logo):
      SvgPicture.network(iconUrl,height: 28.w,colorFilter: ColorFilter.mode(DMUtil.getBCIcon(), BlendMode.srcIn),),
    );
  }
}
