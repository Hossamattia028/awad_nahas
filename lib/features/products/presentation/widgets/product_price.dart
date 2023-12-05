import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProductPriceWidget extends StatelessWidget {
  final ProductsEntity productModel;
  final bool isBig;
  final bool isCart;
  const ProductPriceWidget({Key? key,required this.productModel,this.isBig=false,this.isCart =false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(isCart)...[
          CustomText(
            text: "${productModel.priceWithoutTax.toString()} ${translate("store.sar")}" ,
            fontSize: (isBig?AppStyle.average.sp+1:AppStyle.small.sp) - 1.w,
            fontWeight: FontWeight.w500,
          ),
        ]else ...[
          if(productModel.discount!=productModel.price && productModel.discount != 0 )...[
            CustomText(
              text: "${productModel.price.toString()} ${translate("store.sar")}" ,
              fontSize: (isBig ? AppStyle.average.sp -3.w: AppStyle.small.sp-3)-1.w,
              color: DMUtil.getRED(),
              textDecoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.w500,
            ),
            CustomText(
              text: "${productModel.discount.toString()} ${translate("store.sar")}" ,
              fontSize: (isBig?AppStyle.average.sp+1:AppStyle.small.sp)-1.w,
              fontWeight: FontWeight.w500,
            ),
          ]else...[
            CustomText(
              text: "${productModel.price.toString()} ${translate("store.sar")}" ,
              fontSize: (isBig?AppStyle.average.sp+1:AppStyle.small.sp) - 1.w,
              fontWeight: FontWeight.w500,
            ),
          ],
        ],
      ],
    );
  }

}