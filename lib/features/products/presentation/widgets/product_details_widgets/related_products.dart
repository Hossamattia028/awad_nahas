import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/products/presentation/widgets/related_products_list.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class RelatedProductsWidget extends StatelessWidget {
  final ProductsEntity item;
  const RelatedProductsWidget({super.key,required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DMUtil.getWC(),
      margin: EdgeInsets.symmetric(vertical: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          CustomText(
            text: translate("products.related_products"),
            fontSize: AppStyle.average.sp+2,
          ),
          const SizedBox(height: 10,),
          RelatedProductsList(item: item,),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
