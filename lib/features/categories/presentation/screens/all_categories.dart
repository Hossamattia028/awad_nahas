import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/products/presentation/screens/products_list.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';

class AllCategoriesList extends StatelessWidget {
  const AllCategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(
        title: "",
        justLogo: true,
        leadingIcon: BackArrowButton(),
      ),
      body: BlocBuilder<CategoriesBloc,CategoriesState>(
        builder: (ctx,state){
          var bloc = CategoriesBloc.get(ctx);
          var list = bloc.categoriesList;
          if(list.isEmpty)return const SizedBox.shrink();
          return GridView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 10.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10.h,
              mainAxisSpacing: 10.h,
              childAspectRatio: 1.2,
              mainAxisExtent: 80.h,
            ),
            itemBuilder: (BuildContext context, int index) {
              var item = list[index];
              return InkWell(
                onTap: ()=> Util.pushPage(ProductListScreen(catID: item.id.toString()), context),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius:  BorderRadius.all(Radius.circular(3)),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5,),
                      ImageWidget(imgUrl: item.imgPath,fit: BoxFit.contain,width: 45.w,height:  44.h,),
                      const SizedBox(height: 5,),
                      SizedBox(
                        width: 60.w,
                        child: CustomText(
                          text: item.title,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: AppStyle.verySmall.sp,
                          alignCenter: true,
                          isEllipsis: true,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
