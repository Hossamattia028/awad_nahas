import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SuccessFullyAddToCart extends StatelessWidget {
  const SuccessFullyAddToCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc,CartState>(
      builder: (ctx,state){
        var bloc = CartBloc.get(ctx);
        if(bloc.cartList.isEmpty)return const SizedBox.shrink();
        var item = bloc.cartList.last;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(AppImages.successIconGif,width: 30.w,),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250.w,
                      child: CustomText(
                        text: item.title,
                        fontSize: AppStyle.average.sp,
                        fontWeight: FontWeight.w600,
                        isEllipsis: true,
                      ),
                    ),
                    const SizedBox(height: 3,),
                    CustomText(
                      text: translate("toast.cart_success"),
                      fontSize: AppStyle.small.sp,
                      color: DMUtil.getGreen(),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                color: DMUtil.getBackGround()
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: translate("order.sub_total"),
                    fontSize: AppStyle.average.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text: "${bloc.totalPrice} ${translate("store.sar")}",
                    fontSize: AppStyle.average.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            )

          ],
        );
      },
    );
  }
}
