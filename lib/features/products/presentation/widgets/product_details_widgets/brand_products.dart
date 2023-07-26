import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/products/presentation/widgets/related_products_list.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class BrandProductsWidget extends StatelessWidget {
  const BrandProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        CustomText(
          text: "${translate("products.more_from")} miele",
          fontSize: AppStyle.average.sp+2,
        ),
        const SizedBox(height: 5,),
        const RelatedProductsList(),
        const SizedBox(height: 20,),
      ],
    );
  }
}
