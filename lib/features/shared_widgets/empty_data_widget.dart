import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class EmptyDataWidget extends StatelessWidget {
  final String? txt;
  const EmptyDataWidget({Key? key,this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(text: txt ?? translate("toast.empty"), color: Colors.black38, fontSize: AppStyle.small.sp),
    );
  }
}
