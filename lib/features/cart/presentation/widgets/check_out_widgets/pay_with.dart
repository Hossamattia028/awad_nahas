import 'dart:io';

import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/strings/enum/payment_enum.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/payment_utils/tamara/tamara_widgets.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/circle_dots.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/payfort_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';


class PayWithWidget extends StatelessWidget {
  const PayWithWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: DMUtil.getWC(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomText(
          //   text: translate("cart.pay_with"),
          //   color: DMUtil.getDC(),
          //   fontSize: AppStyle.average.sp,
          // ),
          // const SizedBox(height: 10,),

          BlocBuilder<CartBloc,CartState>(
            builder: (ctx,state){
              var bloc = CartBloc.get(ctx);
              var enablePayWithCard = bloc.applePay;
              return Column(
                children: [
                  if(Platform.isIOS)...[
                    const SizedBox(height: 5,),
                    InkWell(
                      onTap: ()=> bloc.add(const PaymentWithCardEvent(enableApplePay: true,paymentEnum: PaymentEnum.PAYFORT)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleDotsWidget(isEnabled: enablePayWithCard,),
                              const SizedBox(width: 10,),
                              CustomText(
                                text: "Apple Pay",
                                color: DMUtil.getDC(),
                                fontSize: AppStyle.average.sp,
                              ),
                            ],
                          ),

                          Icon(Icons.apple,size: 20.w,),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    const Divider(),
                    const SizedBox(height: 10,),
                  ],

                  InkWell(
                    onTap: ()=> bloc.add(const PaymentWithCardEvent(enableApplePay: false,paymentEnum: PaymentEnum.PAYFORT)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleDotsWidget(isEnabled: !enablePayWithCard && bloc.paymentWithCard == PaymentEnum.PAYFORT,),
                            const SizedBox(width: 10,),
                            CustomText(
                              text: translate("payment.payfort-title"),
                              color: DMUtil.getD2C(),
                              fontSize: AppStyle.average.sp-1,
                            ),
                          ],
                        ),
                        const PayfortCardsWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Divider(),
                  if(bloc.totalPrice<=2000)...[
                    const SizedBox(height: 5,),
                    InkWell(
                        onTap: ()=> bloc.add(const PaymentWithCardEvent(enableApplePay: false,paymentEnum: PaymentEnum.TAMARA)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleDotsWidget(isEnabled: !enablePayWithCard && bloc.paymentWithCard == PaymentEnum.TAMARA,),
                                const SizedBox(width: 10,),
                                TamaraSmallCheckOutWidget(price: bloc.totalPrice),
                              ],
                            ),

                            Image.asset(Util.getLang()=="ar"?AppImages.tamaraAr:AppImages.tamaraEn,width: 55.w,fit: BoxFit.fill,),
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
    );
  }
}
