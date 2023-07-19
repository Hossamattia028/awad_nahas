import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/presentation/widgets/discount_widget.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/products/presentation/screens/product_details_screen.dart';
import 'package:awad_nahas/features/products/presentation/screens/products_list.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';
import 'package:awad_nahas/features/shared_widgets/view_all.dart';

class CatProductsList extends StatelessWidget {
  final CategoriesEntity cat;
  const CatProductsList({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (ctx, state) {
        var bloc = ProductsBloc.get(ctx);
        var list = bloc.productsList;
        list = bloc.filterByCategoryID(cat.id);
        if (list.isEmpty) return const SizedBox.shrink();
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: cat.title,
                  color: Colors.black,
                  fontSize: AppStyle.large.sp,
                  // fontWeight: FontWeight.w700,
                ),
                ViewAllWidget(fn: ()=> Util.pushPage(ProductListScreen(catID: cat.id.toString()), context),),
              ],
            ),
            const SizedBox(height: 5,),
            SizedBox(
              height: 277.h,
              width: 470.w,
              child: ListView.separated(
                itemCount: list.length > 2 ? 2 : list.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(vertical: 4.h,),
                itemBuilder: (BuildContext context, int index) {
                  var item = list[index];
                  return InkWell(
                    onTap: () => Util.pushPage(ProductDetailPage(item: item,), context),
                    child: Container(
                      width: 160.w,
                      padding: const EdgeInsets.symmetric(horizontal: 3,),
                      decoration:  BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        color: DMUtil.getBC(),
                        boxShadow: [
                          BoxShadow(
                            color:  Colors.grey.withOpacity(0.06),
                            blurRadius: 1,
                            offset: const Offset(2, 3), // Shadow position
                          ),
                          BoxShadow(
                            color:  Colors.grey.withOpacity(0.06),
                            blurRadius: 1,
                            offset: const Offset(-2, 3), // Shadow position
                          ),

                        ],
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const SizedBox(height: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               const DiscountWidget(value: "-15%"),
                              WishListIconWidget(item: item),
                            ],
                          ),
                          ImageWidget(
                            imgUrl: item.imgPath,
                            fit: BoxFit.fill,
                            height: 120,
                            width: 110,
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 190.w,
                                    height: 45.h,
                                    child: CustomText(
                                      text: "${item.title} test test  test test test",
                                      color: DMUtil.getDC(),
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppStyle.average.sp,
                                      isEllipsis: true,
                                      maxLine: 2,
                                    ),
                                  ),
                                  ProductPriceWidget(
                                    productModel: item,
                                    isRedPrice: true,
                                  ),
                                  CustomText(
                                    text: "( VAT Included )",
                                    color: DMUtil.getD2C(),
                                    fontSize: AppStyle.small.sp,
                                  ),

                                  const SizedBox(height: 2),

                                  // AddToCartButton(item: item,),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 20,),
              ),
            ),
            const SizedBox(height: 5,),
          ],
        );
      },
    );
  }
}
