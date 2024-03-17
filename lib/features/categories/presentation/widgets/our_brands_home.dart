import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/screens/our_brand.dart';
import 'package:awad_nahas/features/categories/presentation/widgets/brands/brand_list_home.dart';
import 'package:awad_nahas/features/home/presentation/widgets/view_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class OurBrandsHome extends StatelessWidget {
  const OurBrandsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        ViewAllRow(title: translate("app_bar.brands"), fn:()=> Util.pushPage(const OurBrandsScreen(), context)),


        const SizedBox(height: 15,),
        const BrandListHome(),
        const SizedBox(height: 10,),
      ],
    );
  }
}
