import 'package:awad_nahas/features/home/presentation/widgets/view_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/screens/all_categories.dart';
import 'package:awad_nahas/features/categories/presentation/widgets/home_categories_list.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';


class HomeCategories extends StatelessWidget {
  final bool viewAll;
  const HomeCategories({Key? key,this.viewAll=false}) : super(key: key);
  static ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10,),
       ViewAllRow(title: translate("app_bar.categories"), fn:()=> RootBloc.get(context).add(ChangeIndex(index: 1, title: translate("app_bar.categories")))),


        HomeCategoriesList(viewAll: viewAll,),


      ],
    );
  }
}
