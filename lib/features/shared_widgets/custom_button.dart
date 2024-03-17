import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final Widget widget;
  final Color color;
  final Function()? onPressed;
  final Color? sideColor;
  final double? sideWidth;
  final double circular;

  const CustomButton({
    super.key,
    required this.height,
    required this.width,
    required this.widget,
    required this.color,
    required this.onPressed,
    this.sideColor,
    this.sideWidth,
    this.circular = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circular),
            side: BorderSide(
              color: sideColor ?? color,
              width: sideWidth ?? 0.0,
            ),
          ),
        ),
        child: widget,
      ),
    );
  }
}
