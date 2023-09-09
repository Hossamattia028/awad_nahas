import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/prodcut_desc.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  final ProductsEntity item;
  const ProductDescription({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ProductDescriptionWidget(txt: item.desc),
      ],
    );
  }
}
