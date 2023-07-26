import 'package:awad_nahas/features/products/presentation/widgets/product_horizional_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';

class RelatedProductsList extends StatelessWidget {
  const RelatedProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        var bloc =  ProductsBloc.get(ctx);
        return SizedBox(
          height: 266.h,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(2),
            itemCount: bloc.productsList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              var item = bloc.productsList[index];
              return ProductHorizontalCard(item: item, index: index, isSmall: true);
            },
            separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 10,),
          ),
        );
      },
    );
  }
}
