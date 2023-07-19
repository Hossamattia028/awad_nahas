import 'package:flutter/material.dart';
import 'package:awad_nahas/core/strings/app_images.dart';

class LoadingShimmer extends StatelessWidget {
  final double height;
  final double width;
  const LoadingShimmer({Key? key,required this.height,required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(AppImages.loadingGif,height: height, width: width,fit: BoxFit.fill,),);
  }
}
