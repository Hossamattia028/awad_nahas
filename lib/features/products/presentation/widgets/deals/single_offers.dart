import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/data/models/product_model.dart';
import 'package:awad_nahas/features/products/presentation/screens/deals.dart';
import 'package:awad_nahas/features/products/presentation/widgets/cat_list_products.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/view_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SingleOfferWidget extends StatelessWidget {
  final bool viewAll;
  const SingleOfferWidget({super.key,this.viewAll=false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        var bloc = ProductsBloc.get(ctx);
        var list = bloc.productsList.where((element) => ProductModel.calcDiscount(element.price, element.discount)!=0).toList();
        if(list.isEmpty)return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: translate("app_bar.single_offers"),
                  fontWeight: FontWeight.w600,
                  fontSize: AppStyle.average.sp,
                ),
                if(viewAll)ViewAllWidget(fn: ()=> Util.pushPage(const DealsScreen(), context)),
              ],
            ),
            const SizedBox(height: 10,),
            const SingleOfferListWidget(),
          

          ],
        );
      },
    );
  }
}


class SingleOfferListWidget extends StatelessWidget {
  const SingleOfferListWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        var bloc = ProductsBloc.get(ctx);
        var list = bloc.productsList.where((element) => ProductModel.calcDiscount(element.price, element.discount)!=0).toList();
        if(list.isEmpty)return const SizedBox.shrink();
        return SizedBox(
          height: 214.w,
          child: ListView.separated(
            padding: const EdgeInsets.all(2),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx,index){
              var item = list[index];
              return ProductCardH(item: item,);
            },
            separatorBuilder: (ctx,index) => SizedBox(width: 10.w,),
            itemCount: list.length
          ),
        );
      },
    );
  }
}
