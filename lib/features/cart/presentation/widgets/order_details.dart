import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc,CartState>(
      builder: (ctx,state){
        var bloc = CartBloc.get(ctx);
        var list = bloc.cartList;
        if(list.isEmpty)return const SizedBox.shrink();
        return Column(
          children: [
            // const SizedBox(height: 10,),


            const SizedBox(height: 5,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              decoration: BoxDecoration(
                color: DMUtil.getWC(),
                borderRadius: const BorderRadius.all(Radius.circular(4))
              ),
              child: Column(
                children: [
                  // ListView.builder(
                  //   shrinkWrap:true,
                  //   itemCount: list.length,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemBuilder: (ctx,index){
                  //     var productList = ProductsBloc.get(context).productsList;
                  //     if(productList.isEmpty)return const SizedBox.shrink();
                  //     int ind = productList.indexWhere((element) => list[index].id==element.id);
                  //     if(ind==-1)return const SizedBox.shrink();
                  //     var item = ProductsBloc.get(context).productsList[ind];
                  //     return OrderRow(title: item.title,value: "${item.price}${translate("store.sar")}",);
                  //   },
                  // ),
                  // OrderRow(title: translate("cart.total_after_discount") ,value: "${bloc.subTotal}${translate("store.sar")}",),
                  OrderRow(title: translate("cart.shipping_cost") ,value: "${bloc.shippingCost}${translate("store.sar")}",),
                  const Divider(),
                  OrderRow(title: translate("cart.total_price") ,value: "${bloc.totalPrice}${translate("store.sar")}",),
                ],
              ),
            ),

          ],
        );
      },
    );
  }
}

class OrderRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isBig;
  const OrderRow({Key? key,required this.title,required this.value,this.isBig=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          color: DMUtil.getDC(),
          fontSize: isBig?AppStyle.average.sp+2:AppStyle.average.sp-2,
        ),
        CustomText(
          text: value,
          color: DMUtil.getDC(),
          fontSize: isBig?AppStyle.average.sp+2:AppStyle.average.sp-2,
        ),
      ],
    );
  }
}

