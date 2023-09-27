import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandFilterList extends StatelessWidget {
  final ProductsBloc bloc;
  const BrandFilterList({Key? key,required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc,CategoriesState>(
      builder: (ctx,state){
        var catBloc = CategoriesBloc.get(ctx);
        var list = catBloc.activateTransList(catBloc.brandsList);
        var fModel = bloc.filterModel;
        return SizedBox(
          height: 30.h,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx,index){
              var item = list[index];
              return InkWell(
                onTap: ()=> bloc.add(FilterProductEvent(filterModel: FilterModel(filterPrice: fModel?.filterPrice,
                    isDiscount: fModel?.isDiscount ,
                    isAvailable: fModel?.isAvailable,
                    weight: fModel?.weight,
                    brandID: item.id == fModel?.brandID ? null : item.id,
                    searchModel: fModel?.searchModel,
                ))),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    color: fModel?.brandID == item.id ? DMUtil.getPC() : Colors.transparent,
                    border: Border.all(color: fModel?.brandID == item.id ? DMUtil.getPC() : DMUtil.getBCC())
                  ),
                  child: CustomText(
                    text: item.title,
                    color: fModel?.brandID == item.id ?Colors.white:DMUtil.getD2C(),
                    fontSize: AppStyle.small.sp,
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
