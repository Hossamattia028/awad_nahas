import 'package:awad_nahas/features/categories/presentation/widgets/circle_category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';

class HomeCategoriesList extends StatelessWidget {
  final bool viewAll;
  const HomeCategoriesList({Key? key,this.viewAll = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc,CategoriesState>(
      builder: (ctx,state){
        var bloc = CategoriesBloc.get(ctx);
        return SizedBox(
          height: 104.h,
          child: ListView.separated(
            itemCount: viewAll? bloc.categoriesList.length : bloc.categoriesList.length>10?8:bloc.categoriesList.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 3.h),
            itemBuilder: (BuildContext context, int index) {
              var item = bloc.categoriesList[index];
              return CircleCategoryCard(item: item);
            }, separatorBuilder: (BuildContext context, int index)=> const SizedBox(width: 20,),
          ),
        );
      },
    );
  }
}
