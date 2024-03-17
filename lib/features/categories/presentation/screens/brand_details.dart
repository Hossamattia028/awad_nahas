import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/categories/presentation/screens/about_brand.dart';
import 'package:awad_nahas/features/categories/presentation/widgets/products_brand.dart';
import 'package:awad_nahas/features/root_app/widgets/bottom_nav_bar.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

class BrandDetailsScreen extends StatelessWidget{
  const BrandDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc,CategoriesState>(
      builder: (ctx,state){
        var bloc  = CategoriesBloc.get(ctx);
        var brand = bloc.currentBrand;
        if(brand==null)return const SizedBox.shrink();
        return Scaffold(
          backgroundColor: DMUtil.getWC(),
          bottomNavigationBar: const BottomNavBar(isRoot: false,),
          appBar: const GlobalAppBar(title: "",leadingIcon: BackArrowButton()),
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,),
            child: Column(
              children: [
                if(DMUtil.currentThemeIsDark())...[
                  FadeInImage(
                    placeholder: const AssetImage(AppImages.loadingGif),
                    image: AssetImage(brand.darkIcon.toString()),
                  ),
                  // SvgPicture.asset(brand.darkIcon.toString(),height: 80.w,fit: BoxFit.fill,)
                ]else...[
                  SvgPicture.network(brand.iconPath,width: double.infinity,height: 80.w,),
                ],



                SizedBox(height: 15.w,),
                DefaultTabController(
                    length: 2,
                    child: Builder(
                      builder: (ctxB){
                        return BlocBuilder<CategoriesBloc,CategoriesState>(
                          builder: (ctx,state){
                            var bloc = CategoriesBloc.get(ctx);
                            return SizedBox(
                              height: 510.h,
                              child: Column(
                                children: <Widget>[
                                  TabBar(
                                    indicatorPadding: EdgeInsets.zero,
                                    unselectedLabelColor: DMUtil.getDC(),
                                    indicatorColor: Colors.transparent,
                                    labelStyle: TextStyle(color: DMUtil.getDC()),
                                    tabs: <Widget>[
                                      Tab(
                                        height: 33.w,
                                        child: InkWell(
                                            onTap:() {
                                              DefaultTabController.of(ctxB).animateTo(0);
                                              bloc.add(const ChangeBrandIndexEvent(index: 0));
                                            },
                                            child: TabWidget(
                                              title: Util.getLang()=="ar"?
                                              "${translate("store.products")} ${brand.title}" :
                                              "${brand.title} ${translate("store.products")}",isSelected: bloc.currentBrandIndex==0,
                                            )
                                        ),
                                      ),
                                      Tab(
                                        height: 33.w,
                                        child: InkWell(
                                          onTap:() {
                                            DefaultTabController.of(ctxB).animateTo(1);
                                            bloc.add(const ChangeBrandIndexEvent(index: 1));
                                          },
                                          child: TabWidget(
                                            title: "${translate("brand.about")} ${brand.title}",
                                            isSelected: bloc.currentBrandIndex==1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.w,),

                                  Expanded(
                                    child: TabBarView(
                                      physics: const NeverScrollableScrollPhysics(),
                                      children: <Widget>[
                                        ProductsBrand(itemBrand: brand,),
                                        AboutBrand(itemBrand: brand,),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            );
                          },
                        );
                      },
                    )
                ),


              ],
            ),
          ),
        );
      },
    );
  }
}


class TabWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  const TabWidget({super.key,required this.title,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: isSelected?DMUtil.getRED():Colors.transparent,
        border: Border.all(width: 1,color:DMUtil.getRED()),
      ),
      child: CustomText(
        text: title,
        fontSize: AppStyle.small.sp+1.w,
        color: isSelected?Colors.white:DMUtil.getDC(),
        fontWeight: FontWeight.w600,
      )
    );
  }
}
