import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/features/shared_widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageWidget extends StatelessWidget {
  final double height;
  final double width;
  final BoxFit fit;
  final String imgUrl;
  const ImageWidget({Key? key,this.width=double.infinity,this.height=130,this.fit=BoxFit.fill,required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      imageBuilder: (ctx,imgProvider){
        return Container(
          height: height.h,
          width: width.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imgProvider,
              fit: fit,
            ),
          ),
        );
      },
      height: height.h,
      width: width.h,
      fit: fit,
      placeholder: (context, url) => LoadingWidget(height: height.h,),
      errorWidget: (context, url, error) => Image.asset(AppImages.logo),
    );
  }
}
