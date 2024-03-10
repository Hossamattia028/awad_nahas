// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/payment_utils/amwal/ui/amwal_widgets.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/login.dart';
import 'package:awad_nahas/features/cart/presentation/screens/check_out_screen.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/animate_arrow.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class CartBottomButton extends StatelessWidget {
  const CartBottomButton({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (ctx, state) {
        var cartBloc = CartBloc.get(ctx);
        if (cartBloc.cartList.isEmpty) return const SizedBox.shrink();
        return Container(
          height: 120.h,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(color: DMUtil.getWC(), borderRadius: BorderRadius.circular(5)),
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (ctx, state) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      QuickCheckOutButton(amount: cartBloc.totalPrice, list: cartBloc.cartList,amWalListen: false,ctX: context,),
                      const SizedBox(height: 5,),
                      CustomButton(
                        height: 40.h,
                        width: double.infinity,
                        circular: 10,
                        widget: state is OrderLoadingState
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        ):
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: CustomText(
                                text: translate("cart.checkOut"),
                                color: Colors.white,
                                fontSize: AppStyle.average.sp + 1,
                                alignCenter: true,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const AnimateArrowWidget(),
                          ],
                        ),
                        color: DMUtil.getRED(),
                        onPressed: () {
                          if(!Util.checkUser()){
                            SnackBarBuilder.showFeedBackMessage(context, translate("toast.login"), DMUtil.getRED(),);
                            Util.pushPage(const LoginScreen(), context);
                            return;
                          }
                          Util.pushPage(const CheckOutScreen(), context);
                        },
                      ),
                    ],
                  ),

                  Positioned(
                    left: 1.w,
                    bottom: 87.h,
                    child: CustomText(
                      text: "${cartBloc.totalPrice.toStringAsFixed(2)} ${translate("store.sar")}",
                      fontSize: AppStyle.average.sp,
                      color: DMUtil.getD2C(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Positioned(
                    right: 1.w,
                    bottom: 87.h,
                    child: CustomText(
                      text:
                      "${cartBloc.cartList.length} ${cartBloc.cartList.length > 1 ? translate("store.items") : translate("store.item")}",
                      fontSize: AppStyle.average.sp,
                      color: DMUtil.getD2C().withOpacity(0.8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
