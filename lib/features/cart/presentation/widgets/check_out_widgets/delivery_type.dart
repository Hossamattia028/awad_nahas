import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/circle_dots.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';


class DeliveryTypeWidget extends StatelessWidget {
  const DeliveryTypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: DMUtil.getWC(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 0,color: DMUtil.getD2C().withOpacity(0.5)),
          color: DMUtil.getWC(),
        ),
        child: BlocBuilder<CartBloc,CartState>(
          builder: (ctx,state) {
            var bloc = CartBloc.get(ctx);
            var enableDeliveryWithInstallment = bloc.deliveryAndInstallment;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CustomText(
                //   text: translate("cart.delivery_type"),
                //   color: DMUtil.getDC(),
                //   fontSize: AppStyle.average.sp,
                // ),
                // const SizedBox(height: 10,),
                InkWell(
                  onTap: ()=> bloc.add(const DeliveryWithInstallmentEvent(withInstallment: false)),
                  child: Row(
                    children: [
                      CircleDotsWidget(isEnabled: !enableDeliveryWithInstallment,),
                      const SizedBox(width: 10,),
                      CustomText(
                        text: translate("cart.delivery_only"),
                        color: DMUtil.getDC(),
                        fontSize: AppStyle.average.sp,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                InkWell(
                  onTap: ()=> bloc.add(const DeliveryWithInstallmentEvent(withInstallment: true)),
                  child: Row(
                    children: [
                      CircleDotsWidget(isEnabled: enableDeliveryWithInstallment,),
                      const SizedBox(width: 10,),
                      CustomText(
                        text: translate("cart.delivery_install"),
                        color: DMUtil.getDC(),
                        fontSize: AppStyle.average.sp,
                      ),
                    ],
                  ),
                ),

              ],
            );
          }
        ),
      ),
    );
  }
}
