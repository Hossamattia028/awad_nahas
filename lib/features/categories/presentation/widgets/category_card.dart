import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/screens/category_products.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCard extends StatelessWidget {
  final CategoriesEntity item;
  const CategoryCard({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        CategoriesBloc.get(context).add(ChangeCategoriesEvent(categoriesModel: item));
        Util.pushPage(const CategoryProductsScreen(), context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: DMUtil.getWC(),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0, // soften the shadow
              spreadRadius: 0.7, //extend the shadow
              offset: Offset(
                0.01, // Move to right 10  horizontally
                0.05, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Container(
             height: 120.h,
             width: 150.w,
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(10)),
               image: DecorationImage(
                 fit: BoxFit.fill,
                 image: AssetImage("${AppImages.images}/009-small-appliances-300x300.png")
               )
             ),
           ),
            // SvgPicture.asset(item.imgPath, colorFilter: ColorFilter.mode(DMUtil.getRED(), BlendMode.srcIn),width: 100.w,height: 70.h,),
            // ImageWidget(imgUrl: item.imgPath,width: 70.w,fit: BoxFit.fill,),

            Expanded(
              child: CustomText(
                text: item.title,
                fontSize: AppStyle.large.sp,
                alignCenter: true,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
