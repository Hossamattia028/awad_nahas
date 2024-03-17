import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/slider_full_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';

class ImagesSlider extends StatelessWidget {
  final List<String> images;
  final double height ;
  const ImagesSlider({super.key,required this.images,this.height = 160});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc,CategoriesState>(
      builder: (ctx,state){
        var bloc = CategoriesBloc.get(ctx);
        return Column(
          // alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: height.h,
              width: double.infinity,
              child:  CarouselSlider.builder(
                itemCount: images.length,
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  enlargeCenterPage: false,
                  onPageChanged: (index,reason)=> bloc.add(ChangeSliderIndexEvent(val: index)),
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
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for(int i = 0 ; i<images.length; i++)...[
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(Icons.circle,color: bloc.currentSliderIndex == i?DMUtil.getRED(): DMUtil.getD2C(),size: 9.w,),
                  ),
                ],
              ],
            ),

          ],
        );
      },
    );
  }
}
