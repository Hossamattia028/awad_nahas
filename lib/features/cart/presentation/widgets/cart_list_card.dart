import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/cart_qty_card.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/screens/product_details_screen.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CartListCard extends StatelessWidget {
  final ProductsEntity item;
  final double height;
  const CartListCard({super.key,required this.item,required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(8),
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
          Row(
            children: [
              ImageWidget(imgUrl: item.imgPath,fit: BoxFit.fill,width: 100,height: 80,),
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5,),
                    InkWell(
                      onTap: (){
                        var list = ProductsBloc.get(context).storedProductsList;
                        int index = list.indexWhere((element) => element.id == item.id);
                        if(index==-1)return;
                        Util.pushPage(ProductDetailPage(item: list[index],), context);
                      },
                      child: SizedBox(
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
                    ),
                    const SizedBox(height: 7,),
                    ProductPriceWidget(productModel: item,isCart: true,),
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
          const SizedBox(height: 10,),
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
                        onTap: ()=> CartBloc.get(context).add(ModifyCartProductEvent(product: item, isAdd: false,context: context,remove: true)),
                        child: Container(
                            height: 28.h,
                            width: 60.w,
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
  }
}
