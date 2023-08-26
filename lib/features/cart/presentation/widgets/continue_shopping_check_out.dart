import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/screens/check_out_screen.dart';
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
import 'package:awad_nahas/features/order/presentation/screens/order_completed.dart';
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
                color: DMUtil.getWC(),
                borderRadius: BorderRadius.circular(10)
            ),
            child: BlocListener<OrderBloc,OrderState>(
                listener: (ctx,state){
                  if(state is OrderSuccessfullyState){
                    cartBloc.add(const FetchAllCartEvent());
                    // Util.pushPage(const OrderCompletedScreen(), context);
                  }
                },
                child: BlocBuilder<OrderBloc,OrderState>(
                  builder: (ctx,state){
                    var orderBloc = OrderBloc.get(ctx);
                    return CustomButton(
                      height: 45.h,
                      width: double.infinity,
                      circular: 20,
                      widget: state is OrderLoadingState ?
                      const CircularProgressIndicator(color: Colors.white,):
                      CustomText(
                        text: translate("cart.checkOut"),
                        color: Colors.white,
                        fontSize: AppStyle.average.sp+1,
                        alignCenter: true,
                      ),
                      color: DMUtil.getRED(),
                      onPressed: () => Util.pushPage(const CheckOutScreen(), context) ,
                    );
                  },
                )
            ),
        );
      },
    );
  }
}
