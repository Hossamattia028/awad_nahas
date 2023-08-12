import 'package:awad_nahas/features/home/presentation/widgets/banners_section.dart';
import 'package:awad_nahas/features/home/presentation/widgets/categories.dart';
import 'package:awad_nahas/features/home/presentation/widgets/single_banner.dart';
import 'package:awad_nahas/features/home/presentation/widgets/why_awad_nahas.dart';
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


        BlocBuilder<CategoriesBloc,CategoriesState>(
          builder: (ctx,state){
            var bloc = CategoriesBloc.get(ctx);
            var list = bloc.activateTransList(bloc.categoriesList);
            if(list.isEmpty)return const SizedBox(height: 5,);
            if(list.first.productsCount==0)return const SizedBox(height: 5,);
            return CatProductsList(cat: list.first,);
          },
        ),

        const BannersSection(),

        BlocBuilder<CategoriesBloc,CategoriesState>(
          builder: (ctx,state){
            var bloc = CategoriesBloc.get(ctx);
            var list = bloc.activateTransList(bloc.categoriesList);
            if(list.isEmpty)return const SizedBox(height: 5,);
            if(list[2].productsCount==0)return const SizedBox(height: 5,);
            return CatProductsList(cat: list[2],);
          },
        ),

        const SingleBannerWidget(),
        BlocBuilder<CategoriesBloc,CategoriesState>(
          builder: (ctx,state){
            var bloc = CategoriesBloc.get(ctx);
            var list = bloc.activateTransList(bloc.categoriesList);
            if(list.isEmpty)return const SizedBox(height: 5,);
            if(list[3].productsCount==0)return const SizedBox(height: 5,);
            return CatProductsList(cat: list[3],);
          },
        ),

        const WhyAwaNahWidget(),

      ],
    );
  }
}
