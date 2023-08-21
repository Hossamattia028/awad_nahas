import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/prodcut_desc.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class ProductDescription extends StatelessWidget {
  final ProductsEntity item;
  const ProductDescription({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageWidget(imgUrl: item.imgPath,fit: BoxFit.contain,height: 160,),
        const SizedBox(height: 5,),

        ProductDescriptionWidget(txt: item.desc),
      ],
    );
  }
}
