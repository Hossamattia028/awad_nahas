import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/screens/category_products.dart';
import 'package:awad_nahas/features/home/presentation/widgets/view_all.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/widgets/discount_widget.dart';
import 'package:awad_nahas/features/products/presentation/widgets/vat_included.dart';
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
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';

class CatProductsList extends StatelessWidget {
  final CategoriesEntity cat;
  const CatProductsList({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (ctx, state) {
        var bloc = ProductsBloc.get(ctx);
        var list = bloc.productsList;
        list = bloc.filterByCategoryID(cat.id,-1);
        list = bloc.filterByCurrentLang(list);
        if (list.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            ViewAllRow(
              title: cat.title,
              fn: (){
                CategoriesBloc.get(context).add(ChangeCategoriesEvent(categoriesModel: cat));
                bloc.add(UpdateCurrentCatAndSubCat(catID: cat.id));
                Util.pushPage(const CategoryProductsScreen(), context);
              },
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //
            //     // CustomText(
            //     //   text: cat.title,
            //     //   color: DMUtil.getDC(),
            //     //   fontSize: AppStyle.large.sp,
            //     // ),
            //     // ViewAllWidget(fn: (){
            //     //   CategoriesBloc.get(context).add(ChangeCategoriesEvent(categoriesModel: cat));
            //     //   Util.pushPage(const CategoryProductsScreen(), context);
            //     // },),
            //   ],
            // ),
            const SizedBox(height: 15,),
            SizedBox(
              height: Util.getLang()=="ar"? 250.h : 260.h ,
              child: ListView.separated(
                itemCount: list.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 1),
                itemBuilder: (BuildContext context, int index) {
                  var item = list[index];
                  return ProductCardH(item: item);
                },
                separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 10,),
              ),
            ),
            const SizedBox(height: 5,),
          ],
        );
      },
    );
  }
}


class ProductCardH extends StatelessWidget {
  final ProductsEntity item;
  final bool isMarginBottom;
  const ProductCardH({Key? key,required this.item,this.isMarginBottom = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Util.pushPage(ProductDetailPage(item: item,), context),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: DMUtil.getWC(),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0, // soften the shadow
              spreadRadius: 0.7, //extend the shadow
              offset: Offset(
                0.01, // Move to right 10  horizontally
                0.01, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 2,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              width: 134.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DiscountWidget(item: item),
                  WishListIconWidget(item: item,isMarginToast: isMarginBottom,),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            Expanded(
              child: ImageWidget(
                imgUrl: item.imgPath,
                fit: BoxFit.contain,
                width: 120,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 5),
                decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: DMUtil.getWC(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 130.w,
                      height: 42.h,
                      child: CustomText(
                        text: item.title.toString(),
                        color: DMUtil.getDC(),
                        fontWeight: FontWeight.w500,
                        fontSize: AppStyle.large.sp-5,
                        isEllipsis: true,
                        maxLine: 2,
                      ),
                    ),
                    ProductPriceWidget(
                      productModel: item,
                      isBig: true,
                    ),
                    const VatIncludedWidget(),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

