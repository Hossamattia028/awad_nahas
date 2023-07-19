import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final bool isExpanded;
  const SectionWidget({Key? key,required this.title,this.isExpanded = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 10.w,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.w)),
            color: kBackBlueColor,
          ),
          child: CustomText(
            text: title,
            fontSize: AppStyle.small.sp,
            color: Colors.white,
          ),
        ),
        CircleAvatar(
          backgroundColor: kText1,
          radius: 14.w,
          child: Icon(isExpanded?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down,color: Colors.white,),
        ),
      ],
    );
  }
}
