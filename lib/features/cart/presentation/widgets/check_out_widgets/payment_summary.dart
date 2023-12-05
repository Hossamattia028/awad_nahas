import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/order_details.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';


class PaymentSummaryWidget extends StatelessWidget {
  const PaymentSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 0,color: DMUtil.getD2C().withOpacity(0.5)),
          color: DMUtil.getWC(),
        ),
        child: BlocBuilder<CartBloc,CartState>(
          builder: (ctx,state){
            var bloc = CartBloc.get(ctx);
            var list = bloc.cartList;
            if(list.isEmpty)return const SizedBox.shrink();
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
                  decoration: BoxDecoration(
                      color: DMUtil.getWC(),
                      borderRadius: const BorderRadius.all(Radius.circular(4))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: translate("cart.payment_summary"),
                        color: DMUtil.getDC(),
                        fontSize: AppStyle.average.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 20,),
                      OrderRow(title: translate("cart.total_products_price") ,value:  "${bloc.totalProducts} ${translate("store.sar")}",),
                      const SizedBox(height: 15,),
                      OrderRow(title: translate("cart.vat") ,value:  "${bloc.vatValue}${translate("store.sar")}",),
                      const SizedBox(height: 15,),
                      OrderRow(title: translate("cart.shipping_cost") ,value: bloc.shippingCost==0 ? translate("cart.free"): "${bloc.shippingCost} ${translate("store.sar")}",),
                      const Divider(),
                      if(bloc.couponValue!=null&&bloc.couponModel!=null)...[
                        OrderRow(title: translate("cart.coupon_t") ,value: "${bloc.couponValue}${translate("store.sar")}",),
                        const Divider(),
                      ],
                      const SizedBox(height: 15,),
                      OrderRow(title: translate("cart.total_price") ,value: "${bloc.totalPrice} ${translate("store.sar")}",isTotal:true),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
