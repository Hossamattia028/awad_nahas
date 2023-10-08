import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullImageViewer extends StatelessWidget {
  final List<String> images;
  const FullImageViewer({Key? key,required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      body: BlocBuilder<CategoriesBloc,CategoriesState>(
        builder: (ctx,state){
          var bloc = CategoriesBloc.get(ctx);
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int itemIndex) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(images[itemIndex].toString()),
                    initialScale: PhotoViewComputedScale.contained * 0.8,
                    heroAttributes: PhotoViewHeroAttributes(tag: images[itemIndex].toString()),
                  );
                },
                itemCount: images.length,
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded / 2,
                    ),
                  ),
                ),
                backgroundDecoration: const BoxDecoration(),
                pageController: controller,
                onPageChanged: (index) => bloc.add(ChangeSliderIndexEvent(val: index)),
              ),
              Align(
                alignment: Util.getLang()!="ar"? Alignment.topLeft:Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(25.0.h),
                  child: BackArrowButton(color: DMUtil.getRED()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SizedBox(
                  height: 50.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx,index){
                      return InkWell(
                        onTap: (){
                          bloc.add(ChangeSliderIndexEvent(val: index));
                          controller.animateToPage(index, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                        },
                        child: ImageWidget(imgUrl: images[index],width: 50.w,),
                      );
                    },
                    separatorBuilder: (ctx,index) =>  const SizedBox(width: 10,),
                    itemCount: images.length,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  for(int i = 0 ; i<images.length; i++)...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15,left: 10),
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
