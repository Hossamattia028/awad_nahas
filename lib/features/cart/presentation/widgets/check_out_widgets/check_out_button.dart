import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_event.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc,OrderState>(
      builder: (ctx,state){
        var orderBloc = OrderBloc.get(ctx);
        return CustomButton(
          height: 45.h,
          width: double.infinity,
          circular: 20,
          widget: state is OrderLoadingState ?
          const CircularProgressIndicator(color: Colors.white,):
          CustomText(
            text: translate("cart.place_order"),
            color: Colors.white,
            fontSize: AppStyle.small.sp,
            alignCenter: true,
          ),
          color: DMUtil.getRED(),
          onPressed: ()=> orderBloc.add(AddOrderEvent(list: CartBloc.get(context).cartList, totalPrice: CartBloc.get(context).totalPrice)),
        );
      },
    );
  }
}
