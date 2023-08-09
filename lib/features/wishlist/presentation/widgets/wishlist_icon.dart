import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishListIconWidget extends StatelessWidget {
  final ProductsEntity item ;
  const WishListIconWidget({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc,WishlistState>(
      builder: (ctx,state){
        var bloc = WishlistBloc.get(ctx);
        int index = bloc.wishlistList.indexWhere((element) => element.id==item.id);
        bool isFav = false;
        if(index!=-1)isFav = true;
        return InkWell(
          onTap: ()=> bloc.add(AddToWishlistEvent(product: item)),
          child: Icon(isFav?CupertinoIcons.heart_fill:CupertinoIcons.heart,color: isFav?kPrimary:DMUtil.getD2C(),size: 23.w,),
        );
      },
    );
  }
}
