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
      backgroundColor: DMUtil.getBCC(),
      radius: 25.w,
      child: SvgPicture.network(iconUrl,width: 24.w,colorFilter: ColorFilter.mode(DMUtil.getRED(), BlendMode.srcIn),),
    );
  }
}
