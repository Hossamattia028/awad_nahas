import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';

class TabbyWidget extends StatelessWidget {
  final double width;
  final double height;
  const TabbyWidget({super.key,this.width=double.infinity,this.height=84});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc,CartState>(
      builder: (ctx,state){
        // var amount = CartBloc.get(ctx).totalPrice;
        return Container(
          // height: height.w,
          width: width.w,
          padding: EdgeInsets.only(bottom: 10.w),
          child: TabbyPresentationSnippetNonStantard(
            // price: amount,
            currency: Currency.sar,
            lang: Util.getLang()=="ar"?Lang.ar:Lang.en,
          ),
        );
      },
    );
  }
}
