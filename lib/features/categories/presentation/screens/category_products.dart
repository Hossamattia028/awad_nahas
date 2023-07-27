import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/categories/presentation/widgets/category_products_list.dart';
import 'package:awad_nahas/features/categories/presentation/widgets/sub_categories.dart';
import 'package:awad_nahas/features/home/presentation/widgets/filter_row.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      body: SizedBox(
        child: BlocBuilder<CategoriesBloc,CategoriesState>(
            builder: (ctx,state) {
              var bloc = CategoriesBloc.get(ctx);
              if(bloc.currentCategory==null)return const SizedBox.shrink();
              return Column(
                children: [

                  GlobalAppBar(title: bloc.currentCategory!.title,leadingIcon: const BackArrowButton()),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const FilterRow(),
                        InkWell(
                          onTap: (){},
                          child: Icon(Icons.search,color: DMUtil.getD2C(),),
                        ),
                      ],
                    )
                  ),

                  const SubCategoriesHList(),

                  const CategoryProductsListWidget(),

                ],
              );
            }
        ),
      ),
    );
  }
}
