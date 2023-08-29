import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/widgets/discount_widget.dart';
import 'package:awad_nahas/features/shared_widgets/align_child_by_row.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/presentation/screens/product_details_screen.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';

class ProductHorizontalCard extends StatelessWidget {
  final ProductsEntity item;
  final int index;
  final bool isSmall;
  const ProductHorizontalCard({Key? key,required this.item,required this.index,this.isSmall = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widTh = isSmall?130.w:210.w;
    return InkWell(
      onTap: ()=> Util.pushPage(ProductDetailPage(item: item,), context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: DMUtil.getWC(),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              // gradient: index==1? const LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [
              //       kBackOpacity,
              //       kBackOpacity
              //     ]
              // ):null,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(item.id==0)...[
                  SizedBox(
                    width: widTh.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // const DiscountWidget(value: "-15%"),
                        WishListIconWidget(item: item),
                      ],
                    ),
                  ),
                ]else...[
                  SizedBox(
                    width: widTh.w,
                    child: AlignChildRow(
                      isStart: false,
                      child: WishListIconWidget(item: item),
                    ),
                  ),
                ],
                ImageWidget(imgUrl: item.imgPath, fit: BoxFit.contain, height: 140,width: isSmall?150:double.infinity,),
                const SizedBox(height: 3,),
                SizedBox(
                  width: widTh.w,
                  child: CustomText(
                    text: item.title.toString(),
                    color: DMUtil.getDC(),
                    fontSize: AppStyle.average.sp,
                  ),
                ),
                const SizedBox(height: 5,),
                ProductPriceWidget(productModel: item,isBig: true,),
                CustomText(
                  text: "( VAT Included )",
                  color: DMUtil.getD2C(),
                  fontSize: AppStyle.average.sp,
                ),
              ],
            ),
          ),
          // if(index==1)
          //   CustomText(text: "SOLD OUT", fontSize: AppStyle.large.sp,color: DMUtil.getWC(),),

        ],
      ),
    );
  }
}
