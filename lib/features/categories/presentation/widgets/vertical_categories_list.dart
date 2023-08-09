import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/categories/presentation/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalCategoriesList extends StatelessWidget {
  const VerticalCategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc,CategoriesState>(
        builder:(ctx,state){
          var bloc = CategoriesBloc.get(ctx);
          var list = bloc.categoriesList;
          list = bloc.activateTransList(list);
          return Expanded(
            child: ListView.separated(
              itemCount: list.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,vertical: 10),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var item = list[index];
                return CategoryCard(item: item);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
            ),
          );
        },
    );
  }
}
