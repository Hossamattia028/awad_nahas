import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/screens/cart_screen.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';


class ContinueShoppingAndCheckOut extends StatelessWidget {
  final BuildContext ctxDialog;
  const ContinueShoppingAndCheckOut({super.key,required this.ctxDialog});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.logo,height: 50.h,),
          const SizedBox(height: 30,),
          CustomText(
            text: translate("toast.cart_success").toUpperCase(),
            color: kPrimary,
            fontWeight: FontWeight.w500,
            fontSize: AppStyle.small.sp,
          ),
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                height: 34.h,
                width: 135.w,
                circular: 6,
                widget: CustomText(
                  text: translate("cart.continue_shopping").toUpperCase(),
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: AppStyle.small.sp-3,
                ),
                color: kPrimary,
                onPressed: () {
                  Navigator.pop(ctxDialog);
                  Util.pushPageAndRemoveRoutes(const RootScreen(), context);
                },
              ),
              CustomButton(
                height: 34.h,
                width: 120.w,
                circular: 6,
                widget: CustomText(
                  text: translate("cart.checkOut").toUpperCase(),
                  color: Colors.white,
                  fontSize: AppStyle.small.sp,
                ),
                color: Colors.black,
                onPressed: ()  {
                  Navigator.pop(ctxDialog);
                  Util.pushPage(const CartScreen(), context);
                },
              )
            ],
          ),
        ],
      )
    );
  }
}
