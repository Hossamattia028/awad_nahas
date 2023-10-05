import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/home/presentation/widgets/filter_row.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';

class SearchWidget extends StatelessWidget {
  final bool showDrawer;
  const SearchWidget({Key? key,this.showDrawer =true}) : super(key: key);
  static TextEditingController searchTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if(showDrawer)
        InkWell(
          onTap: ()=> Scaffold.of(context).openDrawer(),
          child: SvgPicture.asset(AppImages.drawer,colorFilter: ColorFilter.mode(DMUtil.getD2C(), BlendMode.srcIn),width: 25.w,),
        ),

        const SizedBox(width: 10,),


        Expanded(
          child: Container(
              height: 42.h,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: BlocBuilder<ProductsBloc,ProductsState>(
                builder: (ctx,state){
                  var bloc = ProductsBloc.get(ctx);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 42.h,
                        width: 240.w,
                        child: CustomTextFromField(
                          onChanged: (val){
                            if(val.toString().trim()==""){
                              bloc.add(const FilterProductEvent(filterModel: null,));
                            }
                          },
                          onFieldSubmitted:(val)=> bloc.add(FilterProductEvent(
                              filterModel: FilterModel(
                                isDiscount: bloc.filterModel?.isDiscount,
                                isAvailable: bloc.filterModel?.isAvailable,
                                filterPrice: bloc.filterModel?.filterPrice,
                                brandID: bloc.filterModel?.brandID,
                                weight: bloc.filterModel?.weight,
                                searchModel: SearchModel(word: val.toString().trim().toLowerCase(),categoryList: CategoriesBloc.get(context).categoriesList,brandList: CategoriesBloc.get(context).brandsList),
                              ))),
                          hintText: translate("app_bar.search"),
                          labelText: "",
                          hintColor: kBackOpacity,
                          radius: 10,
                          textEditingController: searchTextEditingController,
                          cursorColor: kPrimary,
                          validator: () {},
                          prefixIcon: InkWell(
                            onTap: ()=> bloc.add(FilterProductEvent(
                                filterModel: FilterModel(
                                  isDiscount: bloc.filterModel?.isDiscount,
                                  isAvailable: bloc.filterModel?.isAvailable,
                                  filterPrice: bloc.filterModel?.filterPrice,
                                  brandID: bloc.filterModel?.brandID,
                                  weight: bloc.filterModel?.weight,
                                  searchModel: SearchModel(word: searchTextEditingController.text.toString().trim().toLowerCase(),categoryList: CategoriesBloc.get(context).categoriesList,brandList: CategoriesBloc.get(context).brandsList),
                                ))),
                            child: Icon(
                              CupertinoIcons.search,
                              color: DMUtil.getDC(),
                            ),
                          ),
                          smallPadding: true,
                          obscureText: false,
                          hasBorder: true,
                          isLabelError: false,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      const FilterRow(),
                    ],
                  );
                },
              )
          ),
        ),


      ],
    );
  }
}
