import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/products/presentation/screens/product_details_screen.dart';
import 'package:awad_nahas/features/products/presentation/widgets/add_to_cart_button.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';

class RelatedProductsList extends StatelessWidget {
  const RelatedProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        var bloc =  ProductsBloc.get(ctx);
        return SizedBox(
          height: 262.h,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: bloc.productsList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              var item = bloc.productsList[index];
              return InkWell(
                onTap: ()=> Util.pushPage(ProductDetailPage(item: item,), context),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius:  BorderRadius.all(Radius.circular(3)),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const SizedBox(height: 13,),
                          ImageWidget(imgUrl: item.imgPath,fit: BoxFit.contain,height: 120,width: 100,),
                          const SizedBox(height: 5,),
                          Expanded(
                            child: Container(
                              width: 170.w,
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
                                    width: 120.w,
                                    child: CustomText(
                                      text: item.title,
                                      color: kText1,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppStyle.small.sp,
                                      isEllipsis: true,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: CustomText(
                                      text: item.desc,
                                      color: kText1,
                                      // fontWeight: FontWeight.w700,
                                      fontSize: AppStyle.verySmall.sp,
                                      isEllipsis: true,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ProductPriceWidget(productModel: item,),
                                      // const RateWidget(countRate: 300,),
                                    ],
                                  ),
                                  const SizedBox(height: 5),

                                  AddToCartButton(item: item,)

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
            separatorBuilder: (BuildContext context, int index) => const SizedBox(
              width: 5,
            ),
          ),
        );
      },
    );
  }
}
