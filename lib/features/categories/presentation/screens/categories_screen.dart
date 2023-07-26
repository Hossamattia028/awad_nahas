import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/categories/presentation/widgets/vertical_categories_list.dart';
import 'package:awad_nahas/features/root_app/widgets/drawer_icon.dart';
import 'package:awad_nahas/features/search/presentation/widgets/search_widget.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [

          GlobalAppBar(title: translate("app_bar.categories"),),

          Padding(padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,vertical: 10),child: const SearchWidget()),

          const VerticalCategoriesList(),



        ],
      ),
    );
  }
}


