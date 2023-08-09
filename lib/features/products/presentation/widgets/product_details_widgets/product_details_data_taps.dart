import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/product_desc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProductDetailsDataRow extends StatelessWidget {
  final ProductsEntity item;
  const ProductDetailsDataRow({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Builder(
          builder: (ctxB){
            return SizedBox(
              height: 470.h,
              child: Column(
                children: <Widget>[
                  TabBar(
                    indicatorPadding: const EdgeInsets.symmetric(horizontal: 6),
                    unselectedLabelColor: DMUtil.getDC(),
                    indicatorColor: DMUtil.getPC(),
                    labelColor: DMUtil.getPC(),
                    labelStyle: TextStyle(color: DMUtil.getPC(),fontSize: AppStyle.small.sp),
                    tabs: <Widget>[
                      Tab(text: translate("products.desc"),),
                      Tab(text: translate("products.reviews"),),
                      Tab(text: translate("products.shipping_delivery"),),
                    ],
                  ),

                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        ProductDescription(desc: item.desc,),
                        const SizedBox(),
                        const SizedBox(),
                      ],
                    ),
                  ),

                ],
              ),
            );
          },
        )
    );
  }
}
