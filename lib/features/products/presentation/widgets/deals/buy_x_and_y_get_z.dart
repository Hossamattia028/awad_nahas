import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:flutter_translate/flutter_translate.dart';

class DealsBuyXAndYGetZWidget extends StatelessWidget {
  const DealsBuyXAndYGetZWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        var bloc = ProductsBloc.get(ctx);
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
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        var bloc = ProductsBloc.get(ctx);
        var list = bloc.productsList;
        return SizedBox(
          height: 200.w,
          child: ListView.separated(
            padding: const EdgeInsets.all(2),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx,index){
              var item = list[index];
              return const SizedBox();
            },
            separatorBuilder: (ctx,index) => SizedBox(width: 10.w,),
            itemCount: list.length
          ),
        );
      },
    );
  }
}
