import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/screens/category_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                      child: SvgPicture.asset(item.imgPath, colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),width: 27.w,),
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
            }, separatorBuilder: (BuildContext context, int index)=> const SizedBox(width: 20,),
          ),
        );
      },
    );
  }
}
