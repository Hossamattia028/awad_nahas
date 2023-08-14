import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/widgets/circle_category_card.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';


class SearchCategoryList extends StatelessWidget {
  const SearchCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc,RootState>(
      builder: (ctx,state){
        var bloc = RootBloc.get(ctx);
        if(bloc.categorySearchList.isEmpty)return const SizedBox.shrink();
        var list = bloc.categorySearchList;
        list = CategoriesBloc.get(context).activateTransList(list);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: translate("app_bar.categories"),
              color: DMUtil.getDC(),
              fontSize: AppStyle.average.sp+2,
            ),
            GridView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 5.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10.h,
                mainAxisSpacing: 10.h,
                childAspectRatio: 1.2,
                mainAxisExtent: 102.h,
              ),
              itemBuilder: (BuildContext context, int index) {
                var item = list[index];
                return CircleCategoryCard(item: item);
              },
            ),

          ],
        );
      },
    );
  }
}
