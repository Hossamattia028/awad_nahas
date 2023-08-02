import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleDotsWidget extends StatelessWidget {
  final bool isEnabled;
  const CircleDotsWidget({Key? key,this.isEnabled = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 18.w,
        width: 18.w,
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: DMUtil.getD2C()),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        child: CircleAvatar(
          radius: 18.w,
          backgroundColor: isEnabled?DMUtil.getRED():DMUtil.getWC(),
        )
    );
  }
}
