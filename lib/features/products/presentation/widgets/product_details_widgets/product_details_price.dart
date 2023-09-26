import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:flutter_translate/flutter_translate.dart';


class ProductDetailsPrice extends StatelessWidget {
  final ProductsEntity productModel;
  const ProductDetailsPrice({Key? key,required this.productModel,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          if(productModel.discount!=productModel.price && productModel.discount != 0 )...[
          Text.rich(
            TextSpan(
              text: productModel.discount.toString(),
              style: TextStyle(color: DMUtil.getDC(),fontWeight: FontWeight.w600,fontSize: AppStyle.average.sp+2),
              children: [
                TextSpan(
                  text:  translate("store.sar"),
                  style: TextStyle(fontFamily: primaryFontReg,fontSize: AppStyle.verySmall.sp,color: DMUtil.getD2C()),
                ),

                TextSpan(
                  text: "  (${translate("products.vat")})  ",
                  style: TextStyle(fontFamily: primaryFontReg,fontSize: AppStyle.small.sp,color: DMUtil.getOpacity()),
                ),
              ]
            )
          ),
          Text.rich(
              TextSpan(
                  text: productModel.price.toString(),
                  style: TextStyle(color: DMUtil.getOpacity(),fontWeight: FontWeight.w600,decoration: TextDecoration.lineThrough),
                  children: [
                    TextSpan(
                      text: "  ${translate("store.offer")} ${productModel.price-productModel.discount} ",
                      style: TextStyle(fontFamily: primaryFontReg,fontSize: AppStyle.small.sp,color: DMUtil.getGreen(),fontWeight: FontWeight.w600,decoration: TextDecoration.none),
                    ),
                  ]
              )
          ),
        ]else...[
          Text.rich(
              TextSpan(
                  text: productModel.price.toString(),
                  style: TextStyle(color: DMUtil.getDC(),fontWeight: FontWeight.w600,fontSize: AppStyle.average.sp+2),
                  children: [
                    TextSpan(
                      text: translate("store.sar"),
                      style: TextStyle(fontFamily: primaryFontReg,fontSize: AppStyle.small.sp,color: DMUtil.getD2C()),
                    ),

                    TextSpan(
                      text: "  (${translate("products.vat")})  ",
                      style: TextStyle(fontFamily: primaryFontReg,fontSize: AppStyle.small.sp,color: DMUtil.getOpacity()),
                    ),
                  ]
              )
          ),
        ],


      ],
    );
  }
}
