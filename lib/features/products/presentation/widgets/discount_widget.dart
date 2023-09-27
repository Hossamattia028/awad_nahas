
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountWidget extends StatelessWidget {
  final ProductsEntity item;
  const DiscountWidget({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return item.discount!=item.price && item.discount != 0 ? Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
      decoration: BoxDecoration(
          color: DMUtil.getRED(),
          borderRadius: const BorderRadius.all(Radius.circular(15))
      ),
      child: CustomText(
        text: '-${Util.calcDiscountRate(oldPrice: item.price, newPrice: item.discount)}%',
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: AppStyle.small.sp,
      ),
    ): const SizedBox.shrink();
  }
}
