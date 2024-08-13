import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/cart_payment_options.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/cart_screen_app_bar.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/releated_products_cart.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/select_location_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/cart_list.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/continue_shopping_check_out.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/coupon_widget.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/order_details.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getBackGround(),
      appBar: AppBar(
        title: const CartAppBarWidget(),
        backgroundColor: DMUtil.getWC(),
        elevation: 0,
        toolbarHeight: AppStyle.appBarHeight.h,
        iconTheme: IconThemeData(color: DMUtil.getD2C()),
        centerTitle: false,
      ),
      bottomNavigationBar: const CartBottomButton(),
      body: RefreshIndicator(
        onRefresh: () =>  _buildRefresh(context),
        child: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
                CartPaymentOptions(),
                SelectLocations(),
                CartListWidget(),
                CouponWidget(),
                SizedBox(height: 15,),
                OrderDetails(),
                CartRelatedProducts(),
                SizedBox(height: 20,),
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
