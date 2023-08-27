import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/categories/presentation/widgets/brands/brand_list_home.dart';
import 'package:awad_nahas/features/home/presentation/widgets/view_all.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class OurBrandsHome extends StatelessWidget {
  const OurBrandsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        // ViewAllRow(title: translate("app_bar.shop_categories"), fn:(){}),

        CustomText(
          text: translate("app_bar.brands"),
          fontSize: AppStyle.large.sp,
        ),
        const SizedBox(height: 5,),
        const BrandListHome(),
        const SizedBox(height: 10,),
      ],
    );
  }
}
