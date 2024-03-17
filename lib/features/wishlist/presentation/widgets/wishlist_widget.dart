import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_card.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_empty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_state.dart';

class WishListWidget extends StatelessWidget {
  const WishListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc,WishlistState>(
      builder: (ctx,state){
        var bloc = WishlistBloc.get(ctx);
        var list = bloc.wishlistList;
        var productBloc  = ProductsBloc.get(context);
        list = productBloc.filterByCurrentLang(list);
        if(list.isEmpty)return const WishListEmpty();
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,vertical: AppStyle.paddingFromTop.h),
          itemCount: list.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            var item = list[index];
            return ProductCard(item: item,enableCartBtn: true,);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 15),
        );
      },
    );
  }
}
