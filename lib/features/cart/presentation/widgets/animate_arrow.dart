import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimateArrowWidget extends StatelessWidget {
  const AnimateArrowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      decoration: BoxDecoration(
          color: DMUtil.getWC(),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Icon(
        Icons.arrow_forward_ios,
        color: DMUtil.getD2C(),
      ),
    ).animate(
          delay: 1.seconds,
          onPlay: (controller) => controller.repeat(),
          autoPlay: true,
        )
        .fade(end: 2.8)
        .moveX(
          end: 10.1,
          duration: 1500.ms,
        );
  }
}
