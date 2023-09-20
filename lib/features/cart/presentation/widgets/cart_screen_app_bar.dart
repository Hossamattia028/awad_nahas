import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';


class CartAppBarWidget extends StatelessWidget {
  const CartAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<CartBloc,CartState>(
          builder: (ctx,state){
            var bloc = CartBloc.get(ctx);
            return Text.rich(
                TextSpan(
                    text: translate("app_bar.cart"),
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: AppStyle.average.sp,color: DMUtil.getD2C(),fontFamily: primaryFontReg),
                    children: [
                      TextSpan(
                          text: " (${bloc.cartList.length} ${bloc.cartList.length > 1 ? translate("store.items") : translate("store.item")})",
                          style: TextStyle(fontWeight: FontWeight.w600,fontSize: AppStyle.average.sp,color: DMUtil.getOpacity(),fontFamily: primaryFontReg)
                      ),
                    ]
                )
            );
          },
        ),
        InkWell(
          onTap: ()=> RootBloc.get(context).add(const ChangeIndex(index: 2, title: "")),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              border: Border.all(width: 0,color: DMUtil.getOpacity()),
            ),
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.favorite_border,color: DMUtil.getOpacity(),size: 13.w,),
                ),
                const SizedBox(width: 3,),
                CustomText(
                  text: translate("wishlist.my_fav"),
                  fontSize: AppStyle.small.sp,
                  fontWeight: FontWeight.w600,
                  alignCenter: true,
                ),
                const SizedBox(width: 7,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.arrow_forward_ios_rounded,color: DMUtil.getOpacity(),size: 12.w,),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
