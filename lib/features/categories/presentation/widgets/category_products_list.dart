import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/presentation/widgets/discount_widget.dart';
import 'package:awad_nahas/features/shared_widgets/align_child_by_row.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/products/presentation/screens/product_details_screen.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';

class CategoryProductsListWidget extends StatelessWidget {
  const CategoryProductsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        var bloc = ProductsBloc.get(ctx);
        var list = bloc.productsList;
        return Expanded(
          child: GridView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: AppStyle.paddingFromH.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.h,
              mainAxisSpacing: 10.h,
              childAspectRatio: 1.4,
              mainAxisExtent: 270.h,
            ),
            itemBuilder: (BuildContext context, int index) {
              var item = list[index];
              return InkWell(
                onTap: ()=> Util.pushPage(ProductDetailPage(item: item,), context),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: index==1?kBackOpacity:DMUtil.getWC(),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        gradient: index==1? const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              kBackOpacity,
                              kBackOpacity
                            ]
                        ):null,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.0, // soften the shadow
                            spreadRadius: 0.2, //extend the shadow
                            offset: Offset(
                              1.0, // Move to right 10  horizontally
                              2.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                      ),
                      child: Opacity(
                        opacity: index==1?0.5:1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(item.id==0)...[
                              SizedBox(
                                width: 210.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const DiscountWidget(value: "-15%"),
                                    WishListIconWidget(item: item),
                                  ],
                                ),
                              ),
                            ]else...[
                              SizedBox(
                                width: 210.w,
                                child: AlignChildRow(
                                  isStart: false,
                                  child: WishListIconWidget(item: item),
                                ),
                              ),
                            ],
                            ImageWidget(imgUrl: item.imgPath, fit: BoxFit.contain, height:  135,),
                            const SizedBox(height: 3,),
                            SizedBox(
                              width: 207.w,
                              child: CustomText(
                                text: item.title.toString(),
                                color: DMUtil.getDC(),
                                fontSize: AppStyle.average.sp,
                              ),
                            ),
                            ProductPriceWidget(productModel: item,),
                            CustomText(
                              text: "( VAT Included )",
                              color: DMUtil.getD2C(),
                              fontSize: AppStyle.small.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if(index==1)
                      CustomText(text: "SOLD OUT", fontSize: AppStyle.large.sp,color: DMUtil.getWC(),),
                      
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
