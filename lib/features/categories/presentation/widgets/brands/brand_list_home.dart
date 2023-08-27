import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/categories/presentation/screens/brand_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandListHome extends StatelessWidget {
  const BrandListHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc,CategoriesState>(
      builder: (ctx,state){
        var bloc = CategoriesBloc.get(ctx);
        var list = bloc.activateTransList(bloc.brandsList);
        return SizedBox(
          height: 45.h,
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx,index){
                var item = list[index];
                return InkWell(
                  onTap: (){
                    bloc.add(ChangeCurrentBrand(brandModel: item));
                    Util.pushPage(const BrandDetailsScreen(), context);
                  },
                  child: Card(
                    child: SvgPicture.network(item.iconPath,width: 30.w,height: 40.h,),
                  ),
                );
              },
              separatorBuilder: (ctx,index)=> const SizedBox(width: 10,),
              itemCount: list.length,
          ),
        );
      },
    );
  }
}
