import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/presentation/widgets/discount_widget.dart';
import 'package:awad_nahas/features/shared_widgets/align_child_by_row.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/screens/product_details_screen.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter_translate/flutter_translate.dart';


class ProductCard extends StatelessWidget {
  final ProductsEntity item;
  final bool enableCartBtn;
  const ProductCard({Key? key,required this.item,this.enableCartBtn= false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Util.pushPage(ProductDetailPage(item: item,), context),
      child: Card(
        elevation: 3,
        color: DMUtil.getWC(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Image.asset(AppImages.searImg,width: 100.w,height: 100.h,),
            // ImageWidget(imgUrl: item.imgPath,width: 70.w,fit: BoxFit.fill,),
            const SizedBox(width: 5,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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

                SizedBox(
                  width: 207.w,
                  child: CustomText(
                    text: item.title.toString(),
                    color: DMUtil.getDC(),
                    fontSize: AppStyle.average.sp,
                  ),
                ),
                // const RateWidget(countRate: 300),
                ProductPriceWidget(productModel: item),
                SizedBox(
                  width: 210.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "( VAT Included )",
                        color: DMUtil.getD2C(),
                        fontSize: AppStyle.small.sp,
                      ),
                      if(enableCartBtn)
                      Container(
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
                            width: 100.w,
                            circular: 10,
                            widget: CustomText(
                              text: translate("cart.add_to_cart"),
                              color: DMUtil.getWC(),
                              fontSize: AppStyle.average.sp,
                            ),
                            color: DMUtil.getRED(),
                            onPressed: (){},
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5,),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
