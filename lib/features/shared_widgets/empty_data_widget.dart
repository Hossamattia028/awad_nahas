import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class EmptyDataWidget extends StatelessWidget {
  final String? txt;
  const EmptyDataWidget({super.key,this.txt});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(text: txt ?? translate("toast.empty"), color: DMUtil.getD2C(), fontSize: AppStyle.small.sp),
    );
  }
}
