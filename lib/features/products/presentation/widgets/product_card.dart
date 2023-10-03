import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/cart_button.dart';
import 'package:awad_nahas/features/products/presentation/widgets/discount_widget.dart';
import 'package:awad_nahas/features/products/presentation/widgets/vat_included.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/screens/product_details_screen.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';


class ProductCard extends StatelessWidget {
  final ProductsEntity item;
  final bool enableCartBtn;
  const ProductCard({Key? key,required this.item,this.enableCartBtn= false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Util.pushPage(ProductDetailPage(item: item,), context),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: DMUtil.getWC(),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0, // soften the shadow
              spreadRadius: 0.7, //extend the shadow
              offset: Offset(
                0.01, // Move to right 10  horizontally
                0.01, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            ImageWidget(imgUrl: item.imgPath,width: 70,fit: BoxFit.contain,height: 50,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                  SizedBox(
                    width: 230.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DiscountWidget(item: item),
                        WishListIconWidget(item: item),
                      ],
                    ),
                  ),


                SizedBox(
                  width: 207.w,
                  child: CustomText(
                    text: item.title.toString(),
                    color: DMUtil.getDC(),
                    fontSize: AppStyle.average.sp-1,
                    fontWeight: FontWeight.w600,
                    maxLine: 2,
                    isEllipsis: true,
                  ),
                ),
                const SizedBox(height: 2,),
                ProductPriceWidget(productModel: item,isBig:false),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const VatIncludedWidget(),
                      if(enableCartBtn)
                        CartButtonWidget(item: item),
                    ],
                  ),
                ),
                const SizedBox(height: 2,),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

