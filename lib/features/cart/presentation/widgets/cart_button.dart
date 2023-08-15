import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CartButtonWidget extends StatelessWidget {
  final ProductsEntity item;
  const CartButtonWidget({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc,CartState>(
      builder: (ctx,state){
        var bloc = CartBloc.get(ctx);
        bool insideCartList = bloc.checkIFProductInsideCartList(item);
        return Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 1.0,
                  offset: const Offset(0.1, 0.1),
                  color: DMUtil.getRED(),
                )
              ]
          ),
          child: CustomButton(
            height: 25.h,
            width: 110.w,
            circular: 10,
            widget: CustomText(
              text: insideCartList?translate("cart.remove_from_cart"):translate("cart.add_to_cart"),
              color: Colors.white,
              fontSize: insideCartList?AppStyle.small.sp-3:AppStyle.average.sp-3,
            ),
            color: DMUtil.getRED(),
            onPressed: ()=> CartBloc.get(context).add(ModifyCartProductEvent(product: item, isAdd: !insideCartList, context: context,remove: insideCartList)),
          ),
        );
      },
    );
  }
}
