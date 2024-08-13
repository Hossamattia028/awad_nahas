import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';

class CouponWidget extends StatelessWidget {
  const CouponWidget({super.key});
  static final TextEditingController couponTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (ctx, state) {
        if (state is CartErrorState) {
          SnackBarBuilder.showFeedBackMessage(
              context, state.errors, Colors.red);
        }
        if (state is CouponSuccessfullyState) {
          SnackBarBuilder.showFeedBackMessage(
              context, translate("cart.coupon_activated"), Colors.green);
        }
      },
      listenWhen: (ctx, state) {
        return state is CartErrorState || state is CouponSuccessfullyState;
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (ctx, state) {
          var bloc = CartBloc.get(ctx);
          if (bloc.cartList.isEmpty) return const SizedBox.shrink();
          return Container(
            height: 72.w,
            width: double.infinity,
            decoration: BoxDecoration(
              color: DMUtil.getD2C().withOpacity(0.1),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.w),
            child: CustomTextFromField(
              height: 32,
              smallPadding: true,
              hintText: "${translate("cart.coupon")} ",
              labelText: "",
              hasBorder: true,
              borderColor: DMUtil.getRED(),
              textEditingController: couponTextEditingController,
              validator: () {},
              strokeBorder: true,
              obscureText: false,
              isLabelError: false,
              hintColor: DMUtil.getRED(),
              cursorColor: DMUtil.getRED(),
              borderWidth: 0,
              radius: 6,
              suffixIcon: state is CouponLoadingState
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
                      child: CircularProgressIndicator(
                        backgroundColor: DMUtil.getRED(),
                      ))
                  : Padding(
                      padding: EdgeInsets.only(
                            top: 8.w ,bottom: 8.w
                          ) +
                          const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        child: Container(
                          width: 42.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: DMUtil.getRED(),
                            // border: Border.all(width: 1,color: DMUtil.getRED()),
                            borderRadius: const BorderRadius.all(Radius.circular(5))
                          ),
                          child: CustomText(
                            color: DMUtil.getWC(),
                            fontSize: AppStyle.small.sp-1,
                            fontWeight: FontWeight.w600,
                            text: bloc.couponModel == null
                                ? translate("cart.active_coupon")
                                : translate("button.update"),
                          ),
                        ),
                        onTap: () {
                          if (couponTextEditingController.text
                              .trim()
                              .isNotEmpty) {
                            bloc.add(ImplementCouponDiscountEvent(
                                couponTxt:
                                    couponTextEditingController.text.trim()));
                          } else {
                            SnackBarBuilder.showFeedBackMessage(context,
                                translate("cart.couponـwrong"), Colors.red);
                          }
                        },
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

