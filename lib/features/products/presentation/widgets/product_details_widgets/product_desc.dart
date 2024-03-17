import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/prodcut_desc.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  final ProductsEntity item;
  const ProductDescription({super.key,required this.item});

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
