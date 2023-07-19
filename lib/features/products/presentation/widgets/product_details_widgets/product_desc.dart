import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/section_widget.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class ProductDescription extends StatelessWidget {
  final String desc;
  const ProductDescription({Key? key,required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 120.w,
              child: SectionWidget(title: translate("products.desc"),)
            ),
            const Expanded(child: Divider(thickness: 1,)),
          ],
        ),
        const SizedBox(height: 5,),
        CustomText(
            text: desc,
            color: kSecondPrimary,
            fontSize: AppStyle.small.sp,
        ),
      ],
    );
  }
}
