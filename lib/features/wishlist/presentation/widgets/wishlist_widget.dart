import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/presentation/screens/product_details_screen.dart';
import 'package:awad_nahas/features/products/presentation/widgets/add_to_cart_button.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/products/presentation/widgets/rate_widget.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_empty.dart';

class WishListWidget extends StatelessWidget {
  const WishListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc,WishlistState>(
      builder: (ctx,state){
        var bloc = WishlistBloc.get(ctx);
        var list = bloc.wishlistList;
        if(list.isEmpty)return const WishListEmpty();
        return GridView.builder(
          itemCount: list.length,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 10.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.h,
            mainAxisSpacing: 10.h,
            childAspectRatio: 1.2,
            mainAxisExtent: 270.h,
          ),
          itemBuilder: (BuildContext context, int index) {
            var item = list[index];
            return InkWell(
              onTap: ()=> Util.pushPage(ProductDetailPage(item: item,), context),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius:  BorderRadius.all(Radius.circular(3)),
                          color: kPrimary,
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            const SizedBox(height: 13,),
                            ImageWidget(imgUrl: item.imgPath,fit: BoxFit.contain,),
                            const SizedBox(height: 5,),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 3),
                                decoration: const BoxDecoration(
                                  borderRadius:  BorderRadius.all(Radius.circular(3)),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5,),
                                    SizedBox(
                                      width: 60.w,
                                      child: CustomText(
                                        text: item.title,
                                        color: kText1,
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppStyle.verySmall.sp,
                                        isEllipsis: true,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150.w,
                                      child: CustomText(
                                        text: item.desc,
                                        color: kText1,
                                        fontWeight: FontWeight.w700,
                                        fontSize: AppStyle.verySmall.sp,
                                        isEllipsis: true,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ProductPriceWidget(productModel: item,),
                                        const RateWidget(countRate: 300,),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    AddToCartButton(item: item,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: ()=> bloc.add(AddToWishlistEvent(product: item)),
                        child: Container(
                          width: 50.w,
                          margin: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: kSecondPrimary,
                            borderRadius: BorderRadius.all(Radius.circular(6))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(CupertinoIcons.delete,color: Colors.white,size: 13,),
                              CustomText(
                                text: translate("button.remove"),
                                color: Colors.white,
                                fontSize: AppStyle.small.sp -2,
                              ),
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                  if(item.discountRate!=0)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(AppImages.logo,width: 50.w,height: 20.h,fit: BoxFit.cover,),
                        CustomText(
                          text: "${item.discountRate}%",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: AppStyle.verySmall.sp,
                          alignCenter: true,
                        ),
                      ],
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
