import 'package:awad_nahas/features/products/presentation/widgets/product_horizional_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';

class CategoryProductsListWidget extends StatelessWidget {
  final int catID;
  const CategoryProductsListWidget({Key? key,required this.catID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        var bloc = ProductsBloc.get(ctx);
        var list = bloc.productsList;
        list = bloc.filterByCategoryID(catID);
        list = bloc.filterByCurrentLang(list);
        return Expanded(
          child: GridView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: AppStyle.paddingFromH.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.h,
              mainAxisSpacing: 10.h,
              childAspectRatio: 1.4,
              mainAxisExtent: 255.h,
            ),
            itemBuilder: (BuildContext context, int index) {
              var item = list[index];
              return ProductHorizontalCard(item: item, index: index);
            },
          ),
        );
      },
    );
  }
}
