import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/screens/product_details_screen.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';


class ProductCardFewData extends StatelessWidget {
  final ProductsEntity item;
  final bool showPrice;
  final bool isElevation;
  const ProductCardFewData({Key? key,required this.item,this.showPrice = true,this.isElevation=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Util.pushPage(ProductDetailPage(item: item,), context),
      child: Card(
        elevation: isElevation?2:0,
        color: DMUtil.getWC(),
        shape:  RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          side: BorderSide(width: 1,color: DMUtil.getBCC())
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 5,),
            ImageWidget(imgUrl: item.imgPath,width: 70.w,fit: BoxFit.contain,),
            const SizedBox(width: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 130.w,
                  child: SingleChildScrollView(
                    child: CustomText(
                      text: item.title.toString(),
                      color: DMUtil.getDC(),
                      fontSize: AppStyle.average.sp-1,
                      maxLine: 4,
                    ),
                  ),
                ),
                if(showPrice)ProductPriceWidget(productModel: item,isBig:true),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
