import 'package:flutter/material.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/select_product_quantity_widget.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/products/presentation/widgets/rate_widget.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/empty_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';

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
          padding: const EdgeInsets.only(bottom: 10,top: 5),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx,index){
            int ind = ProductsBloc.get(context).productsList.indexWhere((element) => list[index].id==element.id);
            if(ind==-1)return const SizedBox.shrink();
            var item = ProductsBloc.get(context).productsList[ind];
            return Container(
              height: 120.h,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageWidget(imgUrl: item.imgPath,fit: BoxFit.contain,width: 60.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 180.w,
                            child: CustomText(
                              text: item.title,
                              color: kText1,
                              fontWeight: FontWeight.w700,
                              fontSize: AppStyle.small.sp - 1,
                              isEllipsis: true,
                            ),
                          ),
                          const RateWidget(countRate: 300),
                          ProductPriceWidget(productModel: item),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // InkWell(
                      //   onTap: ()=> bloc.add(AddToCartEvent(product: item)),
                      //   child: Image.asset(AppImages.removeIcon,height: 20.h,fit: BoxFit.fill,),
                      // ),
                      SelectProductQuantityWidget(item: list[index],),
                    ],
                  )

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
