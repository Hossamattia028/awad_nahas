import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/bloc/deals/deals_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/deals/deals_state.dart';
import 'package:awad_nahas/features/products/presentation/widgets/cat_list_products.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:flutter_translate/flutter_translate.dart';

class DealsBuyXAndYGetZWidget extends StatelessWidget {
  const DealsBuyXAndYGetZWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DealsBloc,DealsState>(
      builder: (ctx,state){
        var bloc = DealsBloc.get(ctx);
        var list = bloc.getProductsHasBuyXYGetZOffer(context);
        if(list.isEmpty)return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            CustomText(
              text: translate("app_bar.buy_x_and_y_get_z"),
              fontWeight: FontWeight.w600,
              fontSize: AppStyle.average.sp,
            ),
            const SizedBox(height: 10,),
            const DealsBuyXAndYGetZListWidget(),
            const SizedBox(height: 40,),
          ],
        );
      },
    );
  }
}


class DealsBuyXAndYGetZListWidget extends StatelessWidget {
  const DealsBuyXAndYGetZListWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DealsBloc,DealsState>(
      builder: (ctx,state){
        var bloc = DealsBloc.get(ctx);
        var list = bloc.getProductsHasBuyXYGetZOffer(context);
        if(list.isEmpty)return const SizedBox.shrink();
        return SizedBox(
          height: 210.w,
          child: ListView.separated(
            padding: const EdgeInsets.all(2),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx,index){
              var item = list[index];
              if(item.banner==null||item.list==null||item.list!.isEmpty)return const SizedBox.shrink();
              return BuyXYGetZ(dealImage: item.banner.toString(), xProduct: item.list!.first, yProduct: item.list!.last);
            },
            separatorBuilder: (ctx,index) => SizedBox(width: 10.w,),
            itemCount: list.length
          ),
        );
      },
    );
  }
}


class BuyXYGetZ extends StatelessWidget {
  final ProductsEntity xProduct;
  final ProductsEntity yProduct;
  final String dealImage ;
  const BuyXYGetZ({super.key,required this.dealImage,required this.xProduct,required this.yProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: DMUtil.getBackGround(),
        borderRadius: const BorderRadius.all(Radius.circular(5))
      ),
      child: Row(
        children: [
          ImageWidget(imgUrl: dealImage,width: 140.w,fit: BoxFit.fill,),
          SizedBox(width: 10.w,),
          Row(
            children: [
              ProductCardH(item: xProduct),
              SizedBox(width: 10.w,),
              ProductCardH(item: yProduct),
            ],
          ),
        ],
      ),
    );
  }
}