import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/screens/product_details_screen.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter_translate/flutter_translate.dart';


class ProductCardFewData extends StatelessWidget {
  final ProductsEntity item;
  final String qty;
  final bool showPrice;
  final bool isElevation;
  final bool isTrack;
  const ProductCardFewData({Key? key,required this.item,this.showPrice = true,this.isElevation=true,this.qty = "0",this.isTrack = false}) : super(key: key);

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
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageWidget(imgUrl: item.imgPath,width: 80,fit: BoxFit.contain,height: 100,),
                const SizedBox(width: 8,),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 122.w,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: CustomText(
                            text: item.title.toString(),
                            color: DMUtil.getDC(),
                            fontWeight: FontWeight.w600,
                            fontSize: AppStyle.average.sp-4,
                            maxLine: 4,
                            isEllipsis: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if(qty!="0")
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: CircleAvatar(
                                  backgroundColor: DMUtil.getRED(),
                                  radius: 10.w,
                                  child: Padding(
                                    padding: Util.getLang()=="ar" ? const EdgeInsets.only(top: 5) :EdgeInsets.zero,
                                    child: CustomText(
                                      text: qty,
                                      color: Colors.white,
                                      fontSize: AppStyle.small.sp,
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(height: 30.h,),
                            if(showPrice)ProductPriceWidget(productModel: item,isBig:true),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ],
            ),

            if(isTrack)...[

            ],
          ],
        )
      ),
    );
  }
}
