import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';

class FullImageViewer extends StatelessWidget {
  final List<String> images;
  const FullImageViewer({Key? key,required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      body: BlocBuilder<CategoriesBloc,CategoriesState>(
        builder: (ctx,state){
          var bloc = CategoriesBloc.get(ctx);
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [

              SizedBox(
                height: double.infinity,
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
                    return ImageWidget(imgUrl: images[itemIndex].toString(),fit: BoxFit.contain,width: double.infinity,height: double.infinity,);
                  },
                ),
              ),
              Align(
                alignment: Util.getLang()!="ar"? Alignment.topLeft:Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(25.0.h),
                  child: BackArrowButton(color: DMUtil.getRED()),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for(int i = 0 ; i<images.length; i++)...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10,left: 10),
                      child: Icon(Icons.circle,color: bloc.currentSliderIndex == i? DMUtil.getRED():DMUtil.getD2C(),size: 11.w,),
                    ),
                  ],
                ],
              ),

            ],
          );
        },
      )
    );
  }
}
