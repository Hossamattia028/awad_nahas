import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
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
          int index = bloc.cartList.indexWhere((element) => element.id==item.id);
          bool insideCartList = false;
          if(index!=-1)insideCartList=true;
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
                bloc.add(AddToCartEvent(product: item,));
              }
            },
          );
        },
      )
    );
  }
}

class AddToCartButtonBottomNav extends StatelessWidget {
  final ProductsEntity item;
  const AddToCartButtonBottomNav({Key? key,required this.item,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocBuilder<CartBloc,CartState>(
            builder: (ctx,state){
              var bloc = CartBloc.get(ctx);
              int index = bloc.cartList.indexWhere((element) => element.id==item.id);
              bool insideCartList = false;
              if(index!=-1)insideCartList=true;
              return CustomButton(
                color: insideCartList?Colors.white:kBackBlueColor,
                height: 34.h,
                circular: 6,
                sideColor: kBackBlueColor,
                sideWidth: 1,
                width: 250.w,
                widget: CustomText(
                  text: insideCartList?translate("cart.remove_from_cart").toUpperCase():translate("cart.add_to_cart").toUpperCase(),
                  color: insideCartList?Colors.red:Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: AppStyle.average.sp-1,
                ),
                onPressed: (){
                  if(item.stockStatus!=true){
                    SnackBarBuilder.showFeedBackMessage(context, translate("toast.out_of_stock"), Colors.red);
                  }else{
                    bloc.add(AddToCartEvent(product: item,));
                  }
                },
              );
            },
          ),
          WishListIconWidget(item: item),

        ],
      )
    );
  }
}
