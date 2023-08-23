import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartNavIconWidget extends StatelessWidget {
  final bool selected;
  const CartNavIconWidget({Key? key,required this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc,CartState>(
      builder: (ctx,state){
        var bloc = CartBloc.get(ctx);
        var list = bloc.cartList;
        int length = list.length;
        return Stack(
          alignment: Alignment.topRight,
          children: [
            SvgPicture.asset(AppImages.cartSelected, colorFilter: ColorFilter.mode(selected?DMUtil.getRED():DMUtil.getD2C(), BlendMode.srcIn),height: 23.w,),
            if(length!=0)Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CircleAvatar(
                backgroundColor:selected? DMUtil.getWC() : DMUtil.getPC(),
                radius: 6.w,
                child: CustomText(text: "$length",fontSize: AppStyle.small.sp-3,color: selected? DMUtil.getPC() : Colors.white,),
              ),
            )
          ],
        );
      },
    );
  }
}