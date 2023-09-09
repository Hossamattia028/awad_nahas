import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/slider_full_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';

class ImagesSlider extends StatelessWidget {
  final List<String> images;
  const ImagesSlider({Key? key,required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 160.h,
          width: double.infinity,
          child:  CarouselSlider.builder(
            itemCount: images.length,
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
              enlargeCenterPage: false,
              // onPageChanged: (index,reason)=> bloc.add(ChangeSliderIndexEvent(val: index)),
            ),
            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
              return InkWell(
                  onTap: ()=> Util.pushPage(FullImageViewer(images: images), context),
                  child: ImageWidget(
                    imgUrl: images[itemIndex].toString(),
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ));
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for(int i = 0 ; i<images.length; i++)...[
              Padding(
                padding: const EdgeInsets.only(bottom: 10,left: 10),
                child: Icon(Icons.circle,color: kText1,size: 11.w,),
              ),
            ],
          ],
        ),

      ],
    );
  }
}
