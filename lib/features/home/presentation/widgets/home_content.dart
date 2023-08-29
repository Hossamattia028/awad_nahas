import 'package:awad_nahas/features/categories/presentation/widgets/our_brands_home.dart';
import 'package:awad_nahas/features/home/presentation/widgets/banners_section.dart';
import 'package:awad_nahas/features/home/presentation/widgets/categories.dart';
import 'package:awad_nahas/features/home/presentation/widgets/single_banner.dart';
import 'package:awad_nahas/features/products/presentation/widgets/cat_list_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/home/presentation/widgets/main_slider.dart';

class HomeContentWidget extends StatelessWidget {
  const HomeContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SliderWidget(),

        const HomeCategories(),
        // OurBrandsScreen(),

        const SizedBox(height: 10,),
        BlocBuilder<CategoriesBloc,CategoriesState>(
          builder: (ctx,state){
            var bloc = CategoriesBloc.get(ctx);
            var list = bloc.activateTransList(bloc.categoriesList);
            if(list.isEmpty)return const SizedBox();
            if(list.first.productsCount==0)return const SizedBox(height: 5,);
            return CatProductsList(cat: list.first,);
          },
        ),
        const SizedBox(height: 10,),
        const OurBrandsHome(),

        const SizedBox(height: 10,),
        const BannersSection(),

        const SizedBox(height: 10,),
        BlocBuilder<CategoriesBloc,CategoriesState>(
          builder: (ctx,state){
            var bloc = CategoriesBloc.get(ctx);
            var list = bloc.activateTransList(bloc.categoriesList);
            if(list.isEmpty)return const SizedBox();
            if(list[2].productsCount==0)return const SizedBox(height: 5,);
            return CatProductsList(cat: list[2],);
          },
        ),

        const SizedBox(height: 10,),
        const SingleBannerWidget(),

        const SizedBox(height: 10,),
        BlocBuilder<CategoriesBloc,CategoriesState>(
          builder: (ctx,state){
            var bloc = CategoriesBloc.get(ctx);
            var list = bloc.activateTransList(bloc.categoriesList);
            if(list.isEmpty)return const SizedBox();
            if(list[3].productsCount==0)return const SizedBox(height: 5,);
            return CatProductsList(cat: list[3],);
          },
        ),

        const SizedBox(height: 10,),
        BlocBuilder<CategoriesBloc,CategoriesState>(
          builder: (ctx,state){
            var bloc = CategoriesBloc.get(ctx);
            var list = bloc.activateTransList(bloc.categoriesList);
            if(list.isEmpty)return const SizedBox();
            if(list[4]==null || list[4].productsCount==0)return const SizedBox(height: 5,);
            return CatProductsList(cat: list[4],);
          },
        ),

        const SizedBox(height: 10,),
        BlocBuilder<CategoriesBloc,CategoriesState>(
          builder: (ctx,state){
            var bloc = CategoriesBloc.get(ctx);
            var list = bloc.activateTransList(bloc.categoriesList);
            if(list.isEmpty)return const SizedBox();
            if(list[5]==null || list[5].productsCount==0)return const SizedBox(height: 5,);
            return CatProductsList(cat: list[5],);
          },
        ),


        const SizedBox(height: 10,),
        // const WhyAwaNahWidget(),

      ],
    );
  }
}
