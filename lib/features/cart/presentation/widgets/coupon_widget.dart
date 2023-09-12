
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';


class CouponWidget extends StatelessWidget {
  const CouponWidget({Key? key}) : super(key: key);
  static final TextEditingController couponTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc,CartState>(
      listener: (ctx,state){
        if(state is CartErrorState){
          SnackBarBuilder.showFeedBackMessage(context, state.errors,Colors.red);
        }
        if(state is CouponSuccessfullyState){
          SnackBarBuilder.showFeedBackMessage(context, translate("cart.coupon_activated"),Colors.green);
        }
      },
      listenWhen: (ctx,state){
        return state is CartErrorState || state is CouponSuccessfullyState ;
      },
      child: BlocBuilder<CartBloc,CartState>(
        builder: (ctx,state){
          var bloc = CartBloc.get(ctx);
          if(bloc.cartList.isEmpty)return const SizedBox.shrink();
          return Card(
            child: Container(
              height: 84.h,
              width: 400.w,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: DMUtil.getWC(),
                  // border: Border.all(width: 1,color: kPrimary),
                  borderRadius: BorderRadius.circular(4)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                      text: translate("cart.do_you_have_coupon"),
                      fontSize: AppStyle.average.sp,
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFromField(
                          smallPadding: false,
                          hintText: translate("cart.coupon"),
                          labelText: "",
                          hasBorder: true,
                          borderColor: DMUtil.getBC(),
                          textEditingController: couponTextEditingController,
                          validator: (){},
                          obscureText: false,
                          isLabelError: false,
                          cursorColor: kPrimary,
                          radius: 5,
                        ),
                      ),
                      const SizedBox(width: 5,),
                      state is CouponLoadingState?
                      SizedBox(height: 25.h,width: 25.w,child: const CircularProgressIndicator(backgroundColor: kPrimary,)):
                      CustomButton(
                        height: 40.h,
                        width: 100.w,
                        circular: 10,
                        widget: CustomText(
                          color: Colors.white,
                          fontSize: AppStyle.small.sp-3,
                          fontWeight: FontWeight.w600,
                          text: bloc.couponModel==null ? translate("cart.active_coupon"):  translate("button.update"),
                        ),
                        color: DMUtil.getRED(),
                        onPressed: () {
                          if(couponTextEditingController.text.trim().isNotEmpty){
                            bloc.add(ImplementCouponDiscountEvent(couponTxt: couponTextEditingController.text.trim()));
                          }else{
                            SnackBarBuilder.showFeedBackMessage(context, translate("cart.couponـwrong"),Colors.red);
                          }
                        },
                      ),

                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
