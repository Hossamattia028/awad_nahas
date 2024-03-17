import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/strings/app_images.dart';

class LoadingShimmerProducts extends StatelessWidget {
  const LoadingShimmerProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      padding: EdgeInsets.all(15.sp),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.h,
        mainAxisSpacing: 10.h,
        childAspectRatio: 0.8,
        mainAxisExtent: 130.h,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Image.asset(AppImages.loadingGif,fit: BoxFit.contain,);
      },
    );
  }
}
