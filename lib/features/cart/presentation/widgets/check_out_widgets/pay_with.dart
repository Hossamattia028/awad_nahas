import 'dart:io';

import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/strings/enum/payment_enum.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/payment_utils/tamara/tamara_widgets.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/circle_dots.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';


class PayWithWidget extends StatelessWidget {
  const PayWithWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: DMUtil.getWC(),
      shape: const RoundedRectangleBorder(
          side: BorderSide(width: 1,color: Colors.white)
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: translate("cart.pay_with"),
              color: DMUtil.getDC(),
              fontSize: AppStyle.average.sp,
            ),
            const SizedBox(height: 10,),

            BlocBuilder<CartBloc,CartState>(
              builder: (ctx,state){
                var bloc = CartBloc.get(ctx);
                var enablePayWithCard = bloc.applePay;
                return Column(
                  children: [
                    InkWell(
                      onTap: ()=> bloc.add(const PaymentWithCardEvent(enableApplePay: false,paymentEnum: PaymentEnum.PAYFORT)),
                      child: Row(
                        children: [
                          CircleDotsWidget(isEnabled: !enablePayWithCard && bloc.paymentWithCard == PaymentEnum.PAYFORT,),
                          const SizedBox(width: 10,),
                          Row(
                            children: [
                              Image.asset(AppImages.paymentRow,width: 60.w,),
                              const SizedBox(width: 10,),
                              CustomText(
                                text: translate("cart.debit_credit"),
                                color: DMUtil.getDC(),
                                fontSize: AppStyle.average.sp,
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                    if(Platform.isIOS)...[
                      const SizedBox(height: 10,),
                      InkWell(
                        onTap: ()=> bloc.add(const PaymentWithCardEvent(enableApplePay: true,paymentEnum: PaymentEnum.PAYFORT)),
                        child: Row(
                          children: [
                            CircleDotsWidget(isEnabled: enablePayWithCard,),
                            const SizedBox(width: 10,),
                            Row(
                              children: [
                                const Icon(Icons.apple),
                                CustomText(
                                  text: "Apple Pay",
                                  color: DMUtil.getDC(),
                                  fontSize: AppStyle.average.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],

                    if(bloc.totalPrice<=2000)...[
                      const SizedBox(height: 10,),
                      InkWell(
                          onTap: ()=> bloc.add(const PaymentWithCardEvent(enableApplePay: false,paymentEnum: PaymentEnum.TAMARA)),
                          child: Row(
                            children: [
                              CircleDotsWidget(isEnabled: !enablePayWithCard && bloc.paymentWithCard == PaymentEnum.TAMARA,),
                              const SizedBox(width: 10,),
                              TamaraSmallCheckOutWidget(price: bloc.totalPrice),
                            ],
                          )
                      ),
                    ],

                  ],
                );
              },
            ),


          ],
        ),
      ),
    );
  }
}
