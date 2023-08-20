import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_card_with_few_data.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';


class AddToCartButton extends StatelessWidget {
  final ProductsEntity item;
  const AddToCartButton({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc,CartState>(
      listener: (ctx,state){
        // if(state is AddToCartSuccessfullyState){
        //   SnackBarBuilder.showFeedBackMessage(context, translate("toast.cart_success"), Colors.green);
        // }else if (state is RemoveCartSuccessfullyState){
        //    SnackBarBuilder.showFeedBackMessage(context, translate("toast.cart_remove_success"), Colors.red);
        // }
      },
      child: BlocBuilder<CartBloc,CartState>(
        builder: (ctx,state){
          var bloc = CartBloc.get(ctx);
          bool insideCartList = bloc.checkIFProductInsideCartList(item);
          return CustomButton(
            color: insideCartList?Colors.white:kBackBlueColor,
            height: 30.h,
            circular: 6,
            sideColor: kBackBlueColor,
            sideWidth: 1,
            width: double.infinity,
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  <Widget>[
                Icon(
                  insideCartList?Icons.remove_shopping_cart:Icons.shopping_cart_outlined,
                  color: insideCartList? Colors.red: Colors.white70,
                ),
                const SizedBox(
                  width: 4.0,
                ),
                CustomText(
                  text: insideCartList?translate("cart.remove_from_cart").toUpperCase():translate("cart.add_to_cart").toUpperCase(),
                  color: insideCartList?Colors.black:Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: AppStyle.small.sp,
                ),
              ],
            ),
            onPressed: (){
              if(item.stockStatus!=true){
                SnackBarBuilder.showFeedBackMessage(context, translate("toast.out_of_stock"), Colors.red);
              }else{
                bloc.add(ModifyCartProductEvent(product: item, context: context, isAdd: true,remove: insideCartList));
              }
            },
          );
        },
      )
    );
  }
}


class AddToCartButtonWidget extends StatelessWidget {
  final ProductsEntity item;
  const AddToCartButtonWidget({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc,CartState>(
        listener: (ctx,state){
          // if(state is AddToCartSuccessfullyState){
          //   SnackBarBuilder.showFeedBackMessage(context, translate("toast.cart_success"), Colors.green);
          // }else if (state is RemoveCartSuccessfullyState){
          //    SnackBarBuilder.showFeedBackMessage(context, translate("toast.cart_remove_success"), Colors.red);
          // }
        },
        child: BlocBuilder<CartBloc,CartState>(
          builder: (ctx,state){
            var bloc = CartBloc.get(ctx);
            bool insideCartList = bloc.checkIFProductInsideCartList(item);
            return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  color: Colors.transparent,
                  height: 65.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Expanded(child: ProductCardFewData(item: item,showPrice: false,isElevation: false,)),
                      CustomButton(
                          height: 50.h,
                          width: 118.w,
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                insideCartList?Icons.remove_shopping_cart:Icons.shopping_cart_outlined,
                                color:  Colors.white,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    CustomText(
                                      text: insideCartList?translate("cart.remove_from_cart").toUpperCase():translate("cart.add_to_cart").toUpperCase(),
                                      color: Colors.white,
                                      fontSize: AppStyle.small.sp + 1,
                                    ),
                                    CustomText(
                                      text: "${item.discount} ${translate("store.sar")}",
                                      color: Colors.white,
                                      fontSize: AppStyle.small.sp,
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                          color: DMUtil.getRED(),
                          onPressed: ()=> CartBloc.get(context).add(ModifyCartProductEvent(product: item, context: context, isAdd: true,remove: insideCartList)),
                      ),

                    ],
                  ),
                )
            );

          },
        )
    );
  }
}
