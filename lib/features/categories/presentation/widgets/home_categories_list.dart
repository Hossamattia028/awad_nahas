import 'package:awad_nahas/features/categories/presentation/widgets/circle_category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';

class HomeCategoriesList extends StatelessWidget {
  final bool viewAll;
  const HomeCategoriesList({super.key,this.viewAll = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc,CategoriesState>(
      builder: (ctx,state){
        var bloc = CategoriesBloc.get(ctx);
        var list = bloc.categoriesList;
        list = bloc.activateTransList(list);
        return SizedBox(
          height: 90.h + 13.w,
          child: ListView.separated(
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 2.h),
            itemBuilder: (BuildContext context, int index) {
              var item = list[index];
              return CircleCategoryCard(item: item);
            }, separatorBuilder: (BuildContext context, int index)=> const SizedBox(width: 15,),
          ),
        );
      },
    );
  }
}
