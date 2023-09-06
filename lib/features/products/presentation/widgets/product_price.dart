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
  final bool isRedPrice;
  const ProductPriceWidget({Key? key,required this.productModel,this.isBig=false,this.isRedPrice = false}) : super(key: key);
  static double highPrice = 0 , lowPrice = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(productModel.price>10000 )...[
        // if(productModel.discount!=productModel.price && productModel.discount != 0 )...[
          CustomText(
            text: "${productModel.price.toString()} ${translate("store.sar")}" ,
            fontSize: isBig ? AppStyle.average.sp: AppStyle.small.sp,
            color: DMUtil.getRED(),
            textDecoration: TextDecoration.lineThrough,
            fontWeight: FontWeight.w500,
          ),
          CustomText(
            text: "${productModel.discount.toString()} ${translate("store.sar")}" ,
            fontSize: isBig?AppStyle.average.sp+1:AppStyle.small.sp,
          ),
        ]else...[
          CustomText(
            text: "${productModel.price.toString()} ${translate("store.sar")}" ,
            fontSize: isBig?AppStyle.average.sp+1:AppStyle.small.sp,
          ),
        ],


      ],
    );
  }

}