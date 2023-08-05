import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/presentation/widgets/account_before_auth.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/cart_list.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/continue_shopping_check_out.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/coupon_widget.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/order_details.dart';
import 'package:flutter_translate/flutter_translate.dart';



class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      appBar: GlobalAppBar(title: translate("app_bar.cart"),),
      body: RefreshIndicator(
        onRefresh: () =>  _buildRefresh(context),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              if(Util.checkUser())... const[
                CartListWidget(),
                CouponWidget(),
                SizedBox(height: 80,),
                OrderDetails(),
                CartBottomButton(),
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
