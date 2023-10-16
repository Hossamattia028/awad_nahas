import 'dart:async';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/search/presentation/widgets/brand_list_inside_filter.dart';
import 'package:awad_nahas/features/search/presentation/widgets/weight_list_inside_filter.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SearchFilterBottomSheetWidget extends StatelessWidget {
  const SearchFilterBottomSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420.h,
      decoration: BoxDecoration(
          color: DMUtil.getWC(),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
      ),
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
      child:  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomText(
                    text: translate("store.filter"),
                    fontSize: AppStyle.average.sp,
                    alignCenter: true,
                  ),
                ),
                InkWell(
                  onTap: ()=> Navigator.of(context).pop(),
                  child: Icon(Icons.close,color: DMUtil.getDC(),size: 19.w,),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            const FromToRow(),
            const SizedBox(height: 5,),
            BlocBuilder<ProductsBloc,ProductsState>(
              builder: (ctx,state){
                var bloc = ProductsBloc.get(ctx);
                var fModel = bloc.filterModel;
                return Column(
                  children: [
                    InkWell(
                      onTap:()=> bloc.add(FilterProductEvent(filterModel: FilterModel(filterPrice: fModel?.filterPrice,
                        isDiscount: fModel?.isDiscount ==null ?true:(fModel?.isDiscount==true?false:true),
                        isAvailable: fModel?.isAvailable,
                        weight: fModel?.weight,
                        brandID: fModel?.brandID,
                        searchModel: fModel?.searchModel,
                      ))),
                      child: CheckBoxWidget(
                        title: translate("store.on_sale"),
                        isEnabled: fModel?.isDiscount == true,
                      ),
                    ),
                    InkWell(
                      onTap:()=> bloc.add(FilterProductEvent(filterModel: FilterModel(filterPrice: fModel?.filterPrice,
                           isDiscount: fModel?.isDiscount ,
                           isAvailable: fModel?.isAvailable ==null ?true:(fModel?.isAvailable==true?false:true),
                           weight: fModel?.weight,
                           brandID: fModel?.brandID,
                           searchModel: fModel?.searchModel,
                      ))),
                      child: CheckBoxWidget(
                         title: translate("store.in_of_stock"),
                         isEnabled: fModel?.isAvailable == true,
                       ),
                    ),


                    CheckBoxWidget(title: translate("store.weight"),isEnabled: bloc.showWeightFilter == true,plus: true,onTapPlusIcon: ()=> bloc.add(const EnableWeightFilterEvent()),),
                     if(bloc.showWeightFilter)... const[
                       SizedBox(height: 5,),
                       WeightFilterList(),
                       SizedBox(height: 5,),
                     ],

                     // CheckBoxWidget(title: translate("store.size"),plus: true,),
                     // CheckBoxWidget(title: translate("store.color"),plus: true,),

                    CheckBoxWidget(title: translate("store.brand"),isEnabled: bloc.showBrandFilter == true,plus: true,onTapPlusIcon: ()=> bloc.add(const EnableBrandFilterEvent()),),

                     if(bloc.showBrandFilter)...[
                       const SizedBox(height: 5,),
                       BrandFilterList(bloc: bloc),
                       const SizedBox(height: 5,),
                     ],

                     const SizedBox(height: 10,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         BlocBuilder<ProductsBloc,ProductsState>(
                           builder: (ctx,state){
                             var rootBloc = ProductsBloc.get(ctx);
                             return CustomButton(
                               height: 40.h,
                               width: 200.w,
                               circular: 20,
                               widget:  CustomText(
                                 text: "${translate("button.view")} ${bloc.productSearchList.length} ${translate("products.product")}",
                                 color: Colors.white,
                                 fontSize: AppStyle.average.sp,
                               ),
                               color: DMUtil.getRED(),
                               onPressed: (){
                                 Timer(const Duration(milliseconds: 200), () {
                                   rootBloc.add(EnableSearchEvent(productList: bloc.productSearchList,enable: true));
                                 });
                                 Navigator.of(context).pop();
                               },
                             );
                           },
                         ),
                         CustomButton(
                           height: 40.h,
                           width: 70.w,
                           circular: 20,
                           sideWidth: 1,
                           sideColor: DMUtil.getRED(),
                           widget:  CustomText(
                             text: translate("button.clear"),
                             color: DMUtil.getDC(),
                             fontSize: AppStyle.average.sp,
                           ),
                           color: DMUtil.getWC(),
                           onPressed: ()=> bloc..add(const FilterProductEvent(filterModel: null))..add(const EnableSearchEvent(enable: false)),
                         ),
                     ],
                   ),
                 ],
               );
             },
           ),

            const SizedBox(height: 10,),
          ],
        ),
      )
    );
  }
}


class CheckBoxWidget extends StatelessWidget {
  final String title ;
  final bool plus ;
  final bool isEnabled;
  final VoidCallback? onTapPlusIcon;
  const CheckBoxWidget({Key? key,required this.title,this.plus=false,this.isEnabled=false,this.onTapPlusIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapPlusIcon,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 6.h),
        margin: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            border: Border.all(width: 0.5,color: DMUtil.getD2C())
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: title,
              fontSize: AppStyle.average.sp,
            ),

            if(plus)...[
              InkWell(
                onTap: onTapPlusIcon ,
                child: Icon(isEnabled ? Icons.remove :Icons.add,size: 24,color: DMUtil.getDC(),),
              ),
            ]else...[
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    border: Border.all(width: 1.0,color: isEnabled?DMUtil.getPC(): DMUtil.getD2C()),
                  color: isEnabled?DMUtil.getPC() : Colors.transparent
                ),
              ),
            ],


          ],
        ),
      ),
    );
  }
}

class FromToRow extends StatelessWidget {
  const FromToRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        var bloc = ProductsBloc.get(ctx);
        var fModel = bloc.filterModel;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: translate("store.from"),
                  fontSize: AppStyle.average.sp,
                ),
                const SizedBox(height: 5,),
                SizedBox(
                  width: 150.w,
                  child: CustomTextFromField(
                    hintText: "  ${bloc.filterModel?.filterPrice?.start ?? 0}  ${translate("store.sar")}",
                    radius: 10,
                    textEditingController: bloc.textStartEditingController,
                    validator: () {},
                    hintColor: DMUtil.getD2C(),
                    textInputType: TextInputType.number,
                    prefixIcon:  null,
                    cursorColor: DMUtil.getDC(),
                    suffixIcon:  null,
                    smallPadding: true,
                    hasBorder: true,
                    obscureText: false,
                    isLabelError: false,
                    borderColor: DMUtil.getD2C(),
                    labelText: '',
                  ),
                ),

              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: translate("store.to"),
                  fontSize: AppStyle.average.sp,
                ),
                const SizedBox(height: 5,),
                SizedBox(
                  width: 150.w,
                  child: CustomTextFromField(
                    hintText: "   ${bloc.filterModel?.filterPrice?.end ?? 0}  ${translate("store.sar")}",
                    radius: 10,
                    onFieldSubmitted: (val){
                      bloc.add(FilterProductEvent(filterModel: FilterModel(filterPrice: FilterPrice(start: val.toString().isEmpty?0.0:double.parse(bloc.textStartEditingController.text.trim()),
                          end: val.toString().isEmpty?0.0:double.parse(bloc.textEndEditingController.text.trim())),
                          isDiscount: fModel?.isDiscount ,
                          isAvailable: fModel?.isAvailable ,
                          brandID: fModel?.brandID,
                          searchModel: fModel?.searchModel
                      )));
                    },
                    textEditingController: bloc.textEndEditingController,
                    validator: () {},
                    hintColor: DMUtil.getD2C(),
                    textInputType: TextInputType.number,
                    prefixIcon:  null,
                    cursorColor: DMUtil.getDC(),
                    suffixIcon:  null,
                    smallPadding: true,
                    hasBorder: true,
                    obscureText: false,
                    isLabelError: false,
                    borderColor: DMUtil.getD2C(),
                    labelText: '',
                  ),
                ),

              ],
            ),
          ],
        );
      },
    );
  }
}

