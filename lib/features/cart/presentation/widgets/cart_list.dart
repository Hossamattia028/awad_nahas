import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/cart_qty_card.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/empty_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CartListWidget extends StatelessWidget {
  const CartListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc,CartState>(
      builder: (ctx,state){
        var bloc = CartBloc.get(ctx);
        var list = bloc.cartList;
        if(list.isEmpty)return const EmptyCartWidget();
        return ListView.separated(
          padding: const EdgeInsets.only(bottom: 10,top: 15),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx,index){
            var item = list[index];
            return Container(
              height: bloc.showCountWidget ? 220.h : 190.h,
              padding: const EdgeInsets.all(10),
              decoration:  BoxDecoration(
                color: DMUtil.getWC(),
                boxShadow: DMUtil.currentThemeIsDark()?  const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0, // soften the shadow
                    spreadRadius: 0.7, //extend the shadow
                    offset: Offset(
                      0.01, // Move to right 10  horizontally
                      0.01, // Move to bottom 10 Vertically
                    ),
                  )
                ]:const [],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ImageWidget(imgUrl: item.imgPath,fit: BoxFit.fill,width: 100,height: 100,),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250.w,
                                child: SingleChildScrollView(
                                  child: CustomText(
                                    text: item.title,
                                    color: DMUtil.getD2C(),
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppStyle.average.sp-1,
                                    maxLine: 3,
                                    isEllipsis: true,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 7,),
                              ProductPriceWidget(productModel: item),
                              const SizedBox(height: 5,),
                              CustomText(
                                text: translate("cart.free_delivery"),
                                fontSize: AppStyle.small.sp-2,
                                fontWeight: FontWeight.w600,
                                color: DMUtil.getGreen(),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconQtyCart(item: item,),
                              // SelectProductQuantityWidget(item: item,),
                              const SizedBox(width: 10,),
                              InkWell(
                                onTap: ()=> bloc.add(ModifyCartProductEvent(product: item, isAdd: false,context: context,remove: true)),
                                child: Container(
                                    height: 28.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                                      border: Border.all(width: 0,color: DMUtil.getD2C().withOpacity(0.5)),
                                      color: DMUtil.getWC(),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(CupertinoIcons.delete,color: DMUtil.getD2C().withOpacity(0.6),size: 14.w,),

                                        CustomText(
                                          text: translate("button.remove"),
                                          color: DMUtil.getD2C().withOpacity(0.6),
                                          fontSize: AppStyle.small.sp-2,
                                        ),
                                      ],
                                    )
                                ),
                              ),
                            ],
                          ),
                          WishListButtonInCartScreen(item: item),
                        ],
                      ),
                      CartQtyCard(item: item,),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (ctx,index)=> const SizedBox(height: 10,),
          itemCount: list.length,
        );
      },
    );
  }
}




