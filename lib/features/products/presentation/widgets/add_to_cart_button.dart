import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/add_to_cart_bottom_sheet.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:flutter/cupertino.dart';
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
          if(state is AddToCartSuccessfullyState){
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              shape:  const RoundedRectangleBorder(
                borderRadius:  BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
              ),
              builder: (ctx){
                return const CartSuccessBottomSheet();
              },
            );
            // SnackBarBuilder.showFeedBackMessage(context, translate("toast.cart_success"), Colors.green);
          }else if (state is RemoveCartSuccessfullyState){
             SnackBarBuilder.showFeedBackMessage(context, translate("toast.cart_remove_success"), Colors.red);
          }
        },
        child: BlocBuilder<CartBloc,CartState>(
          builder: (ctx,state){
            var bloc = CartBloc.get(ctx);
            bool insideCartList = bloc.checkIFProductInsideCartList(item);
            int currentCount = bloc.currentCount;
            // if(insideCartList){
            //   var p = bloc.getProductInCart(item);
            //   if(p!=null)currentCount = p.quantity;
            // }
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              color: DMUtil.getWC(),
              height: bloc.showCountWidget ? 124.h : 65.h,
              // duration: const Duration(milliseconds: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(bloc.showCountWidget)...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 3,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: translate("products.quantity"),
                              color: DMUtil.getD2C(),
                              fontSize: AppStyle.small.sp ,
                            ),
                            InkWell(
                                onTap: ()=> bloc.add(const UpdateCountWidgetEvent()),
                                child: Icon(Icons.close,color: DMUtil.getD2C().withOpacity(0.8),size: AppStyle.large.w,),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            QtyCard(val: 1, selected: currentCount==1,),
                            QtyCard(val: 2, selected: currentCount==2,),
                            QtyCard(val: 3, selected: currentCount==3,),
                            QtyCard(val: 4, selected: currentCount==4,),
                            QtyCard(val: 5, selected: currentCount==5,),
                          ],
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ],

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: ()=> bloc.add(const UpdateCountWidgetEvent()),
                        child: Container(
                            height: 43.h,
                            width: 50.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(6)),
                                border: Border.all(width: 1,color: DMUtil.getD2C().withOpacity(0.7))
                            ),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: translate("products.qty").toUpperCase(),
                                      color: DMUtil.getD2C(),
                                      fontSize: AppStyle.verySmall.sp ,
                                    ),
                                    const SizedBox(height: 1,),
                                    CustomText(
                                      text: "$currentCount",
                                      color: DMUtil.getD2C(),
                                      fontSize: AppStyle.average.sp-1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                )
                            )
                        ),
                      ),
                      const SizedBox(width: 10,),

                      Expanded(
                        child: CustomButton(
                          height: 40.h,
                          width: double.infinity,
                          widget:  state is CartLoadingState ? const CircularProgressIndicator(color: Colors.white,) :    Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if(insideCartList)...[
                                Row(
                                  children: [
                                    const Icon(CupertinoIcons.cart_badge_minus),
                                    const SizedBox(width: 10,),
                                    CustomText(
                                      text: translate("cart.in_your_cart"),
                                      color: Colors.white,
                                      fontSize: AppStyle.small.sp,
                                      fontWeight: FontWeight.w600,
                                    ),

                                  ],
                                ),
                              ]else...[
                                CustomText(
                                  text: translate("cart.add_to_cart").toUpperCase(),
                                  color: Colors.white,
                                  fontSize: AppStyle.small.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ],
                          ),
                          color: DMUtil.getRED(),
                          onPressed: ()=> bloc.addToCartInView(context: context, bloc: bloc,item: item, insideCartList: insideCartList),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            );

          },
        )
    );
  }


}


class QtyCard extends StatelessWidget {
  final int val;
  final bool selected;
  final bool? isCart;
  final ProductsEntity? item;
  final CartBloc? bloc;
  final bool? insideCartList;
  const QtyCard({Key? key,required this.val,required this.selected,this.isCart=false,this.item,this.insideCartList,this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        CartBloc.get(context).add(UpdateCountBeforeInsertInCart(value: val));
        if(item!=null && insideCartList!=null && isCart==true && bloc != null){
          CartBloc.get(context).addToCartInView(context: context, bloc: bloc,item: item, insideCartList: insideCartList!,val: val);
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
