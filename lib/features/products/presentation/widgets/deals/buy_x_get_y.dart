import 'package:awad_nahas/features/products/presentation/bloc/deals/deals_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/deals/deals_state.dart';
import 'package:awad_nahas/features/products/presentation/widgets/cat_list_products.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:flutter_translate/flutter_translate.dart';

class DealsBuyXGetYWidget extends StatelessWidget {
  const DealsBuyXGetYWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DealsBloc,DealsState>(
      builder: (ctx,state){
        var bloc = DealsBloc.get(ctx);
        var list = bloc.getProductsHasBuyXGetYOffer(context);
        if(list.isEmpty)return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            CustomText(
              text: translate("app_bar.buy_x_get_y"),
              fontWeight: FontWeight.w600,
              fontSize: AppStyle.average.sp,
            ),
            const SizedBox(height: 10,),
            const DealsBuyXGetYListWidget(),

          ],
        );
      },
    );
  }
}


class DealsBuyXGetYListWidget extends StatelessWidget {
  const DealsBuyXGetYListWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DealsBloc,DealsState>(
      builder: (ctx,state){
       var bloc = DealsBloc.get(ctx);
       var list = bloc.getProductsHasBuyXGetYOffer(context);
        if(list.isEmpty)return const SizedBox.shrink();
        return SizedBox(
          height: 200.w,
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
