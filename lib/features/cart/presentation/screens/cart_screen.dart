import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/presentation/widgets/account_before_auth.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/cart_payment_options.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/releated_products_cart.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/cart_list.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/continue_shopping_check_out.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/coupon_widget.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/order_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';



class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getBackGround(),
      appBar: AppBar(
        title: BlocBuilder<CartBloc,CartState>(
          builder: (ctx,state){
            var bloc = CartBloc.get(ctx);
            return CustomText(text:  "${translate("app_bar.cart")} (${bloc.cartList.length})" , fontSize: AppStyle.average.sp);
          },
        ),
        backgroundColor: DMUtil.getWC(),
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: const CartBottomButton(),
      body: RefreshIndicator(
        onRefresh: () =>  _buildRefresh(context),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              if(Util.checkUser())... const[
                CartPaymentOptions(),
                CartListWidget(),
                CouponWidget(),
                SizedBox(height: 10,),
                OrderDetails(),
                SizedBox(height: 10,),
                CartRelatedProducts(),
              ]else...const[
                AccountNotAuth(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _buildRefresh(BuildContext context) async {
    CartBloc.get(context).add(const FetchAllCartEvent());
  }

}
