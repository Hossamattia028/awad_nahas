import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProductQuantityWidget extends StatelessWidget {
  const ProductQuantityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: translate("products.qty"),
            fontSize: AppStyle.small.sp,
        ),
        BlocBuilder<CartBloc,CartState>(
          builder: (ctx,state){
            var bloc = CartBloc.get(ctx);
            return Container(
              width: 80.w,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(width: 1,color: DMUtil.getRED())
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: ()=> bloc.add(UpdateCountEvent(value: bloc.cartCount+1)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: DMUtil.getBCC(),
                          borderRadius: const BorderRadius.all(Radius.circular(12))
                      ),
                      child: const Icon(
                          Icons.add
                      ),
                    ),
                  ),
                  CustomText(
                    text: bloc.cartCount.toString(),
                    fontSize: AppStyle.small.sp,
                  ),
                  InkWell(
                    onTap: ()=> bloc.add(UpdateCountEvent(value: bloc.cartCount-1)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: DMUtil.getBCC(),
                          borderRadius: const BorderRadius.all(Radius.circular(12))
                      ),
                      child: const Icon(
                          Icons.remove
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}


class QtyCard extends StatelessWidget {
  final int val;
  final bool selected;
  final bool? isCart;
  final ProductsEntity? item;
  final CartBloc? bloc;
  const QtyCard({Key? key,required this.val,required this.selected,this.isCart=false,this.item,this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        CartBloc.get(context).add(UpdateCountBeforeInsertInCart(value: val));
        if(item!=null && isCart==true && bloc != null){
          CartBloc.get(context).addToCartInView(context: context, bloc: bloc,item: item,val: val);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 6.h),
        margin: const EdgeInsets.symmetric(horizontal: 10,),
        decoration: BoxDecoration(
            border: Border.all(width: 1,color: selected ? DMUtil.getRED():DMUtil.getBackGround()),
            borderRadius: const BorderRadius.all(Radius.circular(2))
        ),
        child: CustomText(
          text: "$val",
          color: DMUtil.getD2C(),
          fontSize: AppStyle.small.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}