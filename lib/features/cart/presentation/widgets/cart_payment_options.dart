import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/payment_utils/tamara/tamara_widgets.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPaymentOptions extends StatelessWidget {
  const CartPaymentOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc,CartState>(
        builder:(ctx,state){
          var bloc = CartBloc.get(ctx);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w),
            child: Column(
              children: [
                if(bloc.totalPrice<=bloc.tamaraMax && bloc.totalPrice!=0)...[
                  const SizedBox(height: 5,),
                  TamaraSmallProductWidget(price: bloc.totalPrice,isSmall: true,),
                ],
              ],
            ),
          );
        });
  }
}
