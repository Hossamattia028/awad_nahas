import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_horizional_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';

class RelatedProductsList extends StatelessWidget {
  final ProductsEntity item;
  final bool isBrand;
  const RelatedProductsList({Key? key,required this.item,this.isBrand = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        var bloc =  ProductsBloc.get(ctx);
        var list = [];
        if(isBrand){
          list = bloc.brandProducts(item.brandID!);
        }else{
          list = bloc.relatedProducts(item.categoryList);
        }
        return SizedBox(
          height: 260.h,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(2),
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              var item = list[index];
              return ProductHorizontalCard(item: item, index: index, isSmall: true);
            },
            separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 10,),
          ),
        );
      },
    );
  }
}
