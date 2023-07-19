import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/products/presentation/screens/product_details_screen.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';

class BigOfferProductsList extends StatelessWidget {
  const BigOfferProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        var bloc = ProductsBloc.get(ctx);
        var list = bloc.bigOfferProducts;
        return GridView.builder(
          itemCount: list.length>4?4:list.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.h,
            mainAxisSpacing: 10.h,
            childAspectRatio: 1.2,
            mainAxisExtent: 214.h,
          ),
          itemBuilder: (BuildContext context, int index) {
            var item = bloc.bigOfferProducts[index];
            return InkWell(
              onTap: ()=> Util.pushPage(ProductDetailPage(item: item,), context),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius:  BorderRadius.all(Radius.circular(10)),
                        color: kPrimary,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const SizedBox(height: 15,),
                          ImageWidget(imgUrl: item.imgPath,fit: BoxFit.contain, height:  110,),
                          const SizedBox(height: 5,),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: const BoxDecoration(
                                borderRadius:  BorderRadius.all(Radius.circular(3)),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5,),
                                  SizedBox(
                                    width: 90.w,
                                    child: CustomText(
                                      text: item.title,
                                      color: kText1,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppStyle.verySmall.sp,
                                      isEllipsis: true,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: CustomText(
                                      text: item.desc,
                                      color: kText1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: AppStyle.verySmall.sp,
                                      isEllipsis: true,
                                    ),
                                  ),
                                  ProductPriceWidget(productModel: item,),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                  ),
                  BlocBuilder<CategoriesBloc,CategoriesState>(
                    builder: (ctx,state){
                      var bloc = CategoriesBloc.get(ctx);
                      // print(item.id);
                      // print(item.categoryList.first.id);
                      int indexC = bloc.categoriesList.indexWhere((element) => element.id==item.categoryList.first.id);
                      if(item.discountRate==0 || indexC==-1)return const SizedBox.shrink();
                      var catTitle = bloc.categoriesList[indexC].title;
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(AppImages.logo,width: 90.w,height: 20.h,fit: BoxFit.fill,),
                              SizedBox(
                                width: 80.w,
                                child: CustomText(
                                  text: catTitle,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppStyle.verySmall.sp,
                                  alignCenter: true,
                                  isEllipsis: true,
                                ),
                              ),
                            ],
                          ),
                        );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
