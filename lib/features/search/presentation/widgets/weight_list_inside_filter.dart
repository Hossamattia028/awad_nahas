import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeightFilterList extends StatelessWidget {
  const WeightFilterList({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        var bloc = ProductsBloc.get(ctx);
        var list = bloc.weightList;
        var fModel = bloc.filterModel;
        return SizedBox(
          height: 26.h,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx,index){
              var item = list[index];
              return InkWell(
                onTap: ()=> bloc.add(FilterProductEvent(filterModel: FilterModel(filterPrice: fModel?.filterPrice,
                    isDiscount: fModel?.isDiscount ,
                    isAvailable: fModel?.isAvailable,
                    brandID: fModel?.brandID,
                    weight: item == fModel?.weight ? null : item,
                    searchModel: fModel?.searchModel,
                ))),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: fModel?.weight == item ? DMUtil.getPC() : Colors.transparent,
                      border: Border.all(color: fModel?.weight == item ? DMUtil.getPC() : DMUtil.getBCC())
                  ),
                  child: CustomText(
                    text: item.toString(),
                    color: fModel?.weight == item ?Colors.white:DMUtil.getD2C(),
                    fontSize: AppStyle.small.sp,
                    alignCenter: true,
                  ),
                ),
              );
            },
            separatorBuilder: (ctx,index)=> const SizedBox(width: 5,),
            itemCount: list.length,
          ),
        );
      },
    );
  }
}
