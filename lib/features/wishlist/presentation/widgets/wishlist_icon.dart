import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class WishListIconWidget extends StatelessWidget {
  final ProductsEntity item ;
  final double iconSize;
  final bool isMarginToast;
  const WishListIconWidget({Key? key,required this.item,this.iconSize = 23,this.isMarginToast = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc,WishlistState>(
      builder: (ctx,state){
        var bloc = WishlistBloc.get(ctx);
        int index = bloc.wishlistList.indexWhere((element) => element.id==item.id || element.imgPath==item.imgPath);
        bool isFav = false;
        if(index!=-1)isFav = true;
        return InkWell(
          onTap: (){
            // if(Util.checkUser()){
              bloc.add(AddToWishlistEvent(product: item));
              int index = ProductsBloc.get(context).productsList.indexWhere((element) => element.id!=item.id && element.imgPath==item.imgPath);
              if(index!=-1)bloc.add(AddToWishlistEvent(product: ProductsBloc.get(context).productsList[index]));
            // }else{
            //   SnackBarBuilder.showFeedBackMessage(context, translate("toast.login"), Colors.red,isMarginBottom: isMarginToast);
            // }
          },
          child: Icon(isFav?CupertinoIcons.heart_fill:CupertinoIcons.heart,color: isFav?kPrimary:DMUtil.getOpacity(),size: iconSize.w,),
        );
      },
    );
  }
}

class WishListNavIconWidget extends StatelessWidget {
  final bool selected;
  const WishListNavIconWidget({Key? key,required this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc,WishlistState>(
      builder: (ctx,state){
        var bloc = WishlistBloc.get(ctx);
        var list = bloc.wishlistList;
        list = ProductsBloc.get(context).filterByCurrentLang(list);
        int length = list.length;
        return Stack(
          alignment: Alignment.topRight,
          children: [
            Icon(selected?CupertinoIcons.heart_fill:CupertinoIcons.heart,color: selected? DMUtil.getPC() : DMUtil.getDLight(),size: 23.w,),
            if(length!=0)CircleAvatar(
              radius: 7.w,
              backgroundColor: selected? DMUtil.getBCC() : DMUtil.getPC(),
              child: Padding(
                padding: EdgeInsets.only(top: Util.getLang()=="ar"?2:0,bottom: Util.getLang()!="ar"?2:0),
                child: CustomText(text: "$length",fontSize: AppStyle.small.sp-2,color: selected? DMUtil.getPC() : Colors.white,),
              )
            )
          ],
        );
      },
    );
  }
}


class WishListButtonInCartScreen extends StatelessWidget {
  final ProductsEntity item;
  const WishListButtonInCartScreen({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        WishlistBloc.get(context).add(AddToWishlistEvent(product: item));
        int index = ProductsBloc.get(context).productsList.indexWhere((element) => element.id!=item.id && element.imgPath==item.imgPath);
        if(index!=-1)WishlistBloc.get(context).add(AddToWishlistEvent(product: ProductsBloc.get(context).productsList[index]));
      },
      child: Container(
          width: 118.w,
          height: 30.h,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            border: Border.all(width: 0,color: DMUtil.getD2C().withOpacity(0.5)),
            color: DMUtil.getWC(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WishListIconWidget(item: item,iconSize: 15,),
              CustomText(
                text: translate("wishlist.add_to_fav"),
                fontSize: AppStyle.small.sp - 1,
                color: DMUtil.getD2C().withOpacity(0.6),
              ),
            ],
          )
      ),
    );
  }
}