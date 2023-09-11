import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
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
        var newSortList = [];
        newSortList.add(bloc.getCat(list,"mi","م"));
        newSortList.add(bloc.getCat(list,"sm","س"));
        newSortList.add(bloc.getCat(list,"li","ل"));
        newSortList.add(bloc.getCat(list,"ae","أ"));
        newSortList.add(bloc.getCat(list,"ba","باو"));
        if(list.isEmpty)return const SizedBox.shrink();
        return SizedBox(
          height: 40.h,
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx,index){
                var item = newSortList[index];
                if(item == null || item.darkIcon == null|| item.lightIcon == null)return const SizedBox.shrink();
                return InkWell(
                  onTap: (){
                    bloc.add(ChangeCurrentBrand(brandModel: item));
                    Util.pushPage(const BrandDetailsScreen(), context);
                  },
                  child: SvgPicture.asset(DMUtil.currentThemeIsDark() ? item.darkIcon  : item.lightIcon,height: 39.h,fit: BoxFit.fill,),
                );
              },
              separatorBuilder: (ctx,index)=> const SizedBox(width: 10,),
              itemCount: newSortList.length,
          ),
        );
      },
    );
  }

}
