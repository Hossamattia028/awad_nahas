import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/screens/check_out_screen.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/animate_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
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
          height: 80.h,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(color: DMUtil.getWC(), borderRadius: BorderRadius.circular(5)),
          child: BlocListener<OrderBloc, OrderState>(
            listener: (ctx, state) {
              if (state is OrderSuccessfullyState) {
                cartBloc.add(const FetchAllCartEvent());
                // Util.pushPage(const OrderCompletedScreen(), context);
              }
            },
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (ctx, state) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
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
                      onPressed: () =>
                          Util.pushPage(const CheckOutScreen(), context),
                    ),
                    Positioned(
                      left: 1.w,
                      bottom: 46.h,
                      child: CustomText(
                        text: "${cartBloc.totalPrice} ${translate("store.sar")}",
                        fontSize: AppStyle.average.sp,
                        color: DMUtil.getD2C(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Positioned(
                      right: 1.w,
                      bottom: 46.h,
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
          ),
        );
      },
    );
  }
}
