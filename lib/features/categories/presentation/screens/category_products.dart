import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/categories/presentation/widgets/category_products_list.dart';
import 'package:awad_nahas/features/categories/presentation/widgets/sub_categories.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/root_app/widgets/bottom_nav_bar.dart';
import 'package:awad_nahas/features/search/presentation/screens/search_screen.dart';
import 'package:awad_nahas/features/search/presentation/widgets/search_widget.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      bottomNavigationBar: const BottomNavBar(isRoot: false,),
      body: BlocBuilder<CategoriesBloc,CategoriesState>(
          builder: (ctx,state) {
            var bloc = CategoriesBloc.get(ctx);
            if(bloc.currentCategory==null)return const SizedBox.shrink();
            return Column(
              children: [

                GlobalAppBar(title: bloc.currentCategory!.title.toString(),leadingIcon: BackArrowButton(
                  fn: (){
                    ProductsBloc.get(context)..add(const UpdateCurrentCatAndSubCat(catID: null,subCatID: null))..add(const FilterProductEvent(filterModel: null))..add(const EnableSearchEvent(enable: false));
                    Navigator.of(context).pop();
                  },
                )),
                const SizedBox(height: 10,),
                const SearchWidget(showDrawer: false,),



                const SubCategoriesHList(),



                BlocBuilder<ProductsBloc,ProductsState>(
                  builder: (ctx,state){
                    var rootBloc = ProductsBloc.get(ctx);
                    return  rootBloc.enableSearch?  const Expanded(child: SearchScreen(enableScroll:  true,)) :
                    CategoryProductsListWidget(catID: bloc.currentCategory!.id,subCatID: bloc.currentSubCategory==null?-1:bloc.currentSubCategory!.id,);
                  },
                ),


              ],
            );
          }
      ),
    );
  }
}
