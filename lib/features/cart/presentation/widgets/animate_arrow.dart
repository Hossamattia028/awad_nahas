import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimateArrowWidget extends StatelessWidget {
  const AnimateArrowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Icon(
        Icons.arrow_forward,
        color: DMUtil.getRED(),
        size: 18.w,
      ),
    ).animate(
          delay: 1.seconds,
          onPlay: (controller) => controller.repeat(),
          autoPlay: true,
        ).moveX(
          end: -10.1,
          begin: 10,
          duration: 2800.ms,
        ).addEffect(const Effect(delay: Duration(milliseconds: 1000)));
  }
}
