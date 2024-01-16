
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
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
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 14.w),
            child: CustomTextFromField(
              height: 32,
              smallPadding: true,
              hintText: translate("cart.coupon"),
              labelText: "",
              hasBorder: true,
              borderColor :DMUtil.getRED(),
              textEditingController: couponTextEditingController,
              validator: (){},
              strokeBorder: true,
              obscureText: false,
              isLabelError: false,
              cursorColor: DMUtil.getRED(),
              borderWidth: 0,
              radius: 6,
              suffixIcon: state is CouponLoadingState?
              Padding(padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.w),child: CircularProgressIndicator(backgroundColor: DMUtil.getRED(),)):
              Padding(
                padding: EdgeInsets.only(top: Util.getLang()=="ar"?  10.h : 5.h,) + const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  child: CustomText(
                    color: DMUtil.getRED(),
                    fontSize: AppStyle.small.sp,
                    fontWeight: FontWeight.w600,
                    text: bloc.couponModel==null ? translate("cart.active_coupon"):  translate("button.update"),
                  ),
                  // color: DMUtil.getRED(),
                  onTap: () {
                    if(couponTextEditingController.text.trim().isNotEmpty){
                      bloc.add(ImplementCouponDiscountEvent(couponTxt: couponTextEditingController.text.trim()));
                    }else{
                      SnackBarBuilder.showFeedBackMessage(context, translate("cart.couponـwrong"),Colors.red);
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
