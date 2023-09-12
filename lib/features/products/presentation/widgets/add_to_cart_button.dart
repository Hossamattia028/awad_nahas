import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';
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
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: DMUtil.getWC(),
              height: 65.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // state is CartLoadingState ? const CircularProgressIndicator(color: Colors.white,) :
                  Expanded(
                    child: CustomButton(
                      height: 50.h,
                      width: double.infinity,
                      widget:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Icon(
                          //   insideCartList?Icons.remove_shopping_cart:Icons.shopping_cart_outlined,
                          //   color:  Colors.white,
                          // ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: insideCartList?translate("cart.remove_from_cart").toUpperCase():translate("cart.add_to_cart").toUpperCase(),
                                  color: Colors.white,
                                  fontSize: AppStyle.small.sp,
                                  fontWeight: FontWeight.w600,
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                      color: DMUtil.getRED(),
                      onPressed: (){
                        if(!Util.checkUser()){
                          SnackBarBuilder.showFeedBackMessage(context, translate("toast.login"), DMUtil.getRED(),isMarginBottom: true);
                          return;
                        }
                        CartBloc.get(context).add(ModifyCartProductEvent(product: item, context: context, isAdd: true,remove: insideCartList));
                      },
                    ),
                  ),
                  // Card(
                  //   child: Row(
                  //     children: [
                  //       // ImageWidget(imgUrl: item.imgPath,width: 50,height: 40,),
                  //       // const SizedBox(width: 2,),
                  //       // CustomText(
                  //       //   text: "${item.discount} ${translate("store.sar")}",
                  //       //   color: DMUtil.getD2C(),
                  //       //   fontSize: AppStyle.small.sp ,
                  //       // ),
                  //       // const SizedBox(width: 3,),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            );

          },
        )
    );
  }
}
