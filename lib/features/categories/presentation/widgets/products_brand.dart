import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_card.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsBrand extends StatelessWidget {
  final CategoriesEntity itemBrand;
  const ProductsBrand({Key? key,required this.itemBrand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // BlocBuilder<CategoriesBloc,CategoriesState>(
        //   builder: (ctx,state){
        //     var bloc = CategoriesBloc.get(ctx);
        //     return SizedBox(
        //       height: 47.h,
        //       child: ListView.separated(
        //         padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
        //         physics: const BouncingScrollPhysics(),
        //         scrollDirection: Axis.horizontal,
        //         itemCount: bloc.categoriesList.length,
        //         itemBuilder: (ctx,index){
        //           var item = bloc.categoriesList[index];
        //           return Container(
        //             decoration: BoxDecoration(
        //               border: Border(bottom: BorderSide(width: 1,color: item.title.startsWith("Coo")?DMUtil.getPC():Colors.transparent))
        //             ),
        //             child: CustomText(text: item.title, fontSize: AppStyle.average.sp,color: item.title.startsWith("Coo")?DMUtil.getPC():DMUtil.getDC(),),
        //           );
        //         },
        //         separatorBuilder: (ctx,index)=> const SizedBox(width: 10,),
        //       ),
        //     );
        //   },
        // ),

        Expanded(
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (ctx, state) {
              var bloc = ProductsBloc.get(ctx);
              var list = bloc.productsList;
              list = bloc.brandProducts(itemBrand.id);
              if (list.isEmpty) return const SizedBox.shrink();
              return ListView.separated(
                shrinkWrap: true,
                itemCount: list.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 2),
                itemBuilder: (BuildContext context, int index) {
                  var item = list[index];
                  return SizedBox(
                    height: 130.h,
                    child: ProductCard(item: item),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
              );
            },
          ),
        ),

      ],
    );
  }
}
