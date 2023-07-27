import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/screens/category_products.dart';
import 'package:awad_nahas/features/products/presentation/screens/products_list.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              padding: EdgeInsets.symmetric(vertical: 6.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10.h,
                mainAxisSpacing: 10.h,
                childAspectRatio: 1.2,
                mainAxisExtent: 92.h,
              ),
              itemBuilder: (BuildContext context, int index) {
                var item = list[index];
                return InkWell(
                  onTap: (){
                    CategoriesBloc.get(context).add(ChangeCategoriesEvent(categoriesModel: item));
                    Util.pushPage(const CategoryProductsScreen(), context);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: DMUtil.getBCC(),
                        radius: 24.w,
                        child: SvgPicture.asset(item.imgPath, colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),width: 26.w,),
                      ),
                      SizedBox(
                        height: 38.h,
                        width: item.title.length>10&&(!item.title.toString().contains(" "))?65.w:50.w,
                        child: CustomText(
                          text: item.title,
                          fontSize: AppStyle.small.sp,
                          alignCenter: true,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),

          ],
        );
      },
    );
  }
}
