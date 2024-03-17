import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/cart_list_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/empty_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CartListWidget extends StatelessWidget {
  const CartListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc,CartState>(
      builder: (ctx,state){
        var bloc = CartBloc.get(ctx);
        var list = bloc.cartList;
        if(list.isEmpty)return const EmptyCartWidget();
        return ListView.separated(
          padding: const EdgeInsets.only(bottom: 10,top: 15),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx,index){
            var item = list[index];
            double height = (bloc.showCountWidget ? 145.h : 85.h) + 79.w;
            if(Util.getLang()!="ar")height+=25.w;
            return CartListCard(item: item, height: height);
          },
          separatorBuilder: (ctx,index)=> const SizedBox(height: 10,),
          itemCount: list.length,
        );
      },
    );
  }
}




