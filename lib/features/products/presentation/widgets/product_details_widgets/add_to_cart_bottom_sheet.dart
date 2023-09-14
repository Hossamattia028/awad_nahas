import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/continue_shopping.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/view_cart.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/successfullly_add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartSuccessBottomSheet extends StatelessWidget {
  const CartSuccessBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 210.h,
        decoration: BoxDecoration(
          color: DMUtil.getWC(),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
        child:  const SingleChildScrollView(
          physics:  BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children:  [
              SizedBox(height: 10,),
              SuccessFullyAddToCart(),
              SizedBox(height: 10,),
              ContinueShoppingButton(),
              SizedBox(height: 10,),
              ViewCartButton(),
            ],
          ),
        )
    );
  }
}
