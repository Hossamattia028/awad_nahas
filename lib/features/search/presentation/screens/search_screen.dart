import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/search/presentation/screens/search_category_list.dart';
import 'package:awad_nahas/features/search/presentation/screens/search_product_list.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';




class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      physics: const NeverScrollableScrollPhysics(),
      child: BlocBuilder<ProductsBloc,ProductsState>(
        builder: (ctx,state){
          var bloc = ProductsBloc.get(ctx);
          if(state is FilterLoadingState) {
            return Padding(
              padding: EdgeInsets.only(top: 120.h),
              child: CircularProgressIndicator(color: DMUtil.getRED(),),);
          }
          if(bloc.categorySearchList.isEmpty&&bloc.productSearchList.isEmpty){
            return Padding(
              padding: EdgeInsets.only(top: 120.h),
              child: CustomText(text: translate("search.no_result"), fontSize: AppStyle.small.sp,fontWeight: FontWeight.w600,),
            );
          }
          return const Column(
            children:  [
              SearchCategoryList(),
              SearchProductList(),
            ],
          );
        },
      )
    );
  }
}
