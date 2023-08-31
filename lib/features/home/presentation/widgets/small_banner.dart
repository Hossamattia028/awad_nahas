import 'package:awad_nahas/features/categories/domain/entities/slider_entity.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallBannerWidget extends StatelessWidget {
  final String position;
  const SmallBannerWidget({Key? key,required this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc,CategoriesState>(
      builder: (ctx,state){
        var bloc = CategoriesBloc.get(ctx);
        List<SliderEntity> list = bloc.filterSliderByLang(bloc.anotherSliders);
        int index = list.indexWhere((element) => element.title.toLowerCase().contains(position));
        if(index==-1)return const SizedBox();
        SliderEntity slider = list[index];
        return InkWell(
          onTap: ()=> bloc.goSliderPath(slider, context),
          child: Container(
            height: 145.h,
            width: 170.w,
            padding: const EdgeInsets.only(top: 40,left: 20,right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(slider.img,),
                    fit: BoxFit.fill
                )
            ),
          ),
        );
      },
    );
  }
}
