import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_state.dart';
import 'package:awad_nahas/features/order/presentation/screens/order_completed.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';


class CartBottomButton extends StatelessWidget {
  const CartBottomButton({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc,CartState>(
      builder: (ctx,state){
        var cartBloc = CartBloc.get(ctx);
        if(cartBloc.cartList.isEmpty)return const SizedBox.shrink();
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  height: 40.h,
                  width: double.infinity,
                  circular: 4,
                  sideWidth: 1,
                  sideColor: kPrimary,
                  widget: CustomText(
                    text: translate("cart.continue_shopping").toUpperCase(),
                    color: kPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: AppStyle.small.sp,
                  ),
                  color: Colors.white,
                  onPressed: () => RootBloc.get(context).add(const ChangeIndex(index: 0, title: "")),
                ),
                const SizedBox(height: 5,),
                BlocListener<OrderBloc,OrderState>(
                  listener: (ctx,state){
                    if(state is OrderSuccessfullyState){
                      cartBloc.add(const FetchAllCartEvent());
                      Util.pushPage(const OrderCompletedScreen(), context);
                    }
                  },
                  child: BlocBuilder<OrderBloc,OrderState>(
                    builder: (ctx,state){
                      var orderBloc = OrderBloc.get(ctx);
                      return CustomButton(
                        height: 40.h,
                        width: double.infinity,
                        circular: 4,
                        widget: state is OrderLoadingState ?
                          const CircularProgressIndicator(color: Colors.white,):
                          Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                text: translate("cart.checkOut").toUpperCase(),
                                color: Colors.white,
                                fontSize: AppStyle.small.sp,
                                alignCenter: true,
                              ),
                            ),
                            const Icon(Icons.arrow_circle_left_outlined),
                          ],
                        ),
                        color: kPrimary,
                        onPressed: () {},
                      );
                    },
                  )
                ),
              ],
            )
        );
      },
    );
  }
}
