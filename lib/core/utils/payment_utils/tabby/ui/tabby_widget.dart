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
  const TabbyWidget({super.key,this.width=double.infinity,this.height=74});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (widget,c){
          if(Util.checkUser()==false)return const SizedBox.shrink();
          if(c.connectionState != ConnectionState.done)return const SizedBox.shrink();
          return BlocBuilder<CartBloc,CartState>(
            builder: (ctx,state){
              // var amount = CartBloc.get(ctx).tabbyAmount;
              return SizedBox(
                height: height.h,
                width: width.w,
                child: TabbyPresentationSnippetNonStantard(
                  // price: amount,
                  currency: Currency.aed,
                  lang: Util.getLang()=="ar"?Lang.ar:Lang.en,
                ),
              );
            },
          );
        },
      )
    );
  }
}
