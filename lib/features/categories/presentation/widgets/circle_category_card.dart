import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/shared_widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/screens/category_products.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CircleCategoryCard extends StatelessWidget {
  final CategoriesEntity item;
  const CircleCategoryCard({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        CategoriesBloc.get(context).add(ChangeCategoriesEvent(categoriesModel: item));
        Util.pushPage(const CategoryProductsScreen(), context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(DMUtil.currentThemeIsDark() && item.darkIcon!=null && item.darkIcon.toString().trim()!="")...[
            SvgPicture.network(item.darkIcon!,height: 59.h,fit: BoxFit.contain,),
          ]else if(!DMUtil.currentThemeIsDark() && item.lightIcon!=null && item.lightIcon.toString().trim()!="")...[
            SvgPicture.network(item.lightIcon!,height: 59.h,fit: BoxFit.contain,),
          ]else ...[
            SvgIconWidget(iconUrl: item.iconPath),
          ],

          const SizedBox(height: 5,),
          SizedBox(
            height: 42.h,
            width: 60.w,
            child: CustomText(
              text: item.title.toString(),
              fontSize: AppStyle.small.sp,
              alignCenter: true,
              maxLine: item.title.toString().contains(" ") ? 2 : 1,
            ),
          )
        ],
      ),
    );
  }
}
