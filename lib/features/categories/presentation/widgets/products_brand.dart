import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_card.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProductsBrand extends StatelessWidget {
  final CategoriesEntity itemBrand;
  const ProductsBrand({Key? key,required this.itemBrand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc,CategoriesState>(
      builder: (ctx,state){
        var catBloc = CategoriesBloc.get(ctx);
        var list = catBloc.activateTransList(catBloc.categoriesList);
        var currentCat = catBloc.currentCategory;
        var bloc = ProductsBloc.get(ctx);
        var productList = bloc.productsList;
        if(currentCat!=null)productList = bloc.filterByCategoryID(currentCat.id, -1);
        productList = bloc.brandProducts(itemBrand.id,list: productList);
        var subCatList  = [];
        for(var i in list){
          if(bloc.brandProducts(itemBrand.id,list: bloc.filterByCategoryID(i.id, -1)).isNotEmpty){
            subCatList.add(i);
          }
        }
        return subCatList.isEmpty ? const SizedBox.shrink():
          BlocBuilder<ProductsBloc, ProductsState>(
          builder: (ctx, state) {
            var productsBloc = ProductsBloc.get(ctx);
            return Column(
              children: [
                SizedBox(
                  height: 47.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: subCatList.length,
                    itemBuilder: (ctx,index){
                      var item = subCatList[index];
                        return InkWell(
                          onTap: (){
                            catBloc.add(ChangeCategoriesEvent(categoriesModel: item));
                            productsBloc.add(UpdateCurrentCatAndSubCat(catID: item.id));
                          },
                          // onTap: ()=> catBloc.add(ChangeCategoriesEvent(categoriesModel: item)),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1,color: currentCat?.id==item.id?DMUtil.getPC():Colors.transparent))
                            ),
                            child: CustomText(text: item.title, fontSize: AppStyle.average.sp,color: currentCat?.id==item.id?DMUtil.getPC():DMUtil.getDC(),),
                          ),
                        );
                    },
                    separatorBuilder: (ctx,index)=> SizedBox(width: 8.w,),
                  ),
                ),

                productList.isEmpty? Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(text: translate("products.empty"), fontSize: AppStyle.small.sp-2),
                      Icon(Icons.hourglass_empty,color: DMUtil.getRED(),),
                    ],
                  ),
                ):
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: productList.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 2) + EdgeInsets.only(bottom: 120.w),
                    itemBuilder: (BuildContext context, int index) {
                      var item = productList[index];
                      if(productList.isEmpty)return CustomText(text: translate("products.empty"), fontSize: AppStyle.small.sp);
                      return SizedBox(
                        height:Util.getLang()=="ar"? 103.w : 125.w,
                        child: ProductCard(item: item),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => SizedBox(height: 7.w,),
                  ),
                ),

              ],
            );
          },
        );
      },
    );
  }
}
