import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/categories/presentation/screens/about_brand.dart';
import 'package:awad_nahas/features/categories/presentation/widgets/products_brand.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class BrandDetailsScreen extends StatelessWidget {
  const BrandDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc,CategoriesState>(
      builder: (ctx,state){
        var bloc  = CategoriesBloc.get(ctx);
        var brand = bloc.currentBrand;
        if(brand==null)return const SizedBox.shrink();
        return Scaffold(
          backgroundColor: DMUtil.getWC(),
          appBar: GlobalAppBar(title: brand.title,leadingIcon: GlobalWidgets.backArrowButton(() => Navigator.of(context).pop(), DMUtil.getD2C(), Alignment.center),),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 90.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("${AppImages.images}/MIELE-Logo-01.png"),
                      fit: BoxFit.fill
                    )
                  ),
                ),


                const SizedBox(height: 10,),
                DefaultTabController(
                  length: 2,
                  child: SizedBox(
                    height: 470.h,
                    child: Column(
                      children: <Widget>[
                        TabBar(
                          indicatorPadding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 2.h),
                          indicator: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                              color: DMUtil.getRED(),
                              border: Border.all(width: 4,color: DMUtil.getRED()),
                              backgroundBlendMode: BlendMode.darken
                          ),
                          unselectedLabelColor: DMUtil.getDC(),
                          labelStyle: TextStyle(color: DMUtil.getDC()),
                          tabs: <Widget>[
                            Tab(text: translate("brand.brand_products"),),
                            Tab(text: translate("brand.about_brand"),),
                          ],
                        ),

                        const Expanded(
                          child: TabBarView(
                            children: <Widget>[
                              ProductsBrand(),
                              AboutBrand(),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        );
      },
    );
  }
}
