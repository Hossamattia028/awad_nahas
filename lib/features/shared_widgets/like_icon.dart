import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikeIcon extends StatelessWidget {
  const LikeIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: DMUtil.getBackGround(),
      radius: 19.w,
      child: Image.asset(AppImages.like,width: 20.w,),
    );
  }
}
