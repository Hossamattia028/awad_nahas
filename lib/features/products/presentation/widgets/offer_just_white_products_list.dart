import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/products/presentation/screens/product_details_screen.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/products/presentation/widgets/rate_widget.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';

class OfferJustLubaProductsList extends StatelessWidget {
  const OfferJustLubaProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        var bloc = ProductsBloc.get(ctx);
        if(bloc.productsList.isEmpty)return const SizedBox.shrink();
        return SizedBox(
          width: 194.w,
          height: 150.h,
          child: GridView.builder(
            itemCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 2.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.h,
              mainAxisSpacing: 10.h,
              childAspectRatio: 1.2,
              mainAxisExtent: 156.h,
            ),
            itemBuilder: (BuildContext context, int index) {
              var item = bloc.productsList[index];
              return InkWell(
                onTap: ()=> Util.pushPage(ProductDetailPage(item: item), context),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    borderRadius:  BorderRadius.all(Radius.circular(3)),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RateWidget(countRate: 0,),
                      const SizedBox(height: 3,),
                      ImageWidget(imgUrl: item.imgPath,fit: BoxFit.contain, height:  70,),
                      const SizedBox(height: 3,),
                      SizedBox(
                        width: 50.w,
                        child: CustomText(
                          text: item.title,
                          color: kText1,
                          fontWeight: FontWeight.w500,
                          fontSize: AppStyle.verySmall.sp,
                          isEllipsis: true,
                        ),
                      ),

                      ProductPriceWidget(productModel: item,),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
