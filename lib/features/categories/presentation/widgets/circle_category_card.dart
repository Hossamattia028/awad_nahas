import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/screens/category_products.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';


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
          CircleAvatar(
            backgroundColor: DMUtil.getBCC(),
            radius: 26.w,
            child: Image.network(item.imgPath,width: 30.w,),
          ),

          const SizedBox(height: 2,),
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
  }
}
