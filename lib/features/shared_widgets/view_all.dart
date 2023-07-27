import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class ViewAllWidget extends StatelessWidget {
  final VoidCallback fn;
  const ViewAllWidget({Key? key,required this.fn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fn,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2,),
        // decoration: BoxDecoration(
        //   border: Border.all(width: 1,color: kPrimary),
        // ),
        child: CustomText(
          text: translate("home.view_all"),
          fontSize: AppStyle.small.sp+3,
        ),
      ),
    );
  }
}
