import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/products/presentation/widgets/related_products_list.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class BrandProductsWidget extends StatelessWidget {
  final ProductsEntity item;
  final String brandTitle;
  const BrandProductsWidget({Key? key,required this.item,this.brandTitle = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        CustomText(
          text: "${translate("products.more_from")} $brandTitle",
          fontSize: AppStyle.average.sp+2,
        ),
        const SizedBox(height: 10,),
        RelatedProductsList(item: item,isBrand: true,),
        const SizedBox(height: 20,),
      ],
    );
  }
}
