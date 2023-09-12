import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/presentation/widgets/vat_included.dart';
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
        return Card(
          color: DMUtil.getWC(),
          child: Column(
            children: [
              SizedBox(height: 15.h,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4))
                ),
                child: Column(
                  children: [

                    OrderRow(title: translate("cart.shipping_cost") ,value: bloc.shippingCost==0 ? translate("cart.free"): "${bloc.shippingCost}${translate("store.sar")}",),
                    const Divider(),
                    if(bloc.couponValue!=null&&bloc.couponModel!=null)...[
                      OrderRow(title: translate("cart.coupon_t") ,value: "${bloc.couponValue}${translate("store.sar")}",),
                      const Divider(),
                    ],
                    OrderRow(title: translate("cart.total_price") ,value: "${bloc.totalPrice}${translate("store.sar")}",isTotal:true),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class OrderRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isBig;
  final bool isTotal ;
  const OrderRow({Key? key,required this.title,required this.value,this.isBig=false,this.isTotal=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomText(
              text: title,
              color: isTotal? DMUtil.getDC(): DMUtil.getD2C().withOpacity(0.8),
              fontSize: isBig?AppStyle.average.sp+2:AppStyle.average.sp-2,
              fontWeight: isTotal? FontWeight.w600:FontWeight.w400,
            ),
            if(isTotal)const VatIncludedWidget(),
          ],
        ),
        CustomText(
          text: value,
          color: value==translate("cart.free")  ? DMUtil.getRED() : DMUtil.getDC(),
          fontSize: isBig?AppStyle.average.sp+2:AppStyle.average.sp-2,
        ),
      ],
    );
  }
}

