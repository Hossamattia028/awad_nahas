import 'package:awad_nahas/features/home/presentation/widgets/view_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/features/categories/presentation/widgets/home_categories_list.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';


class HomeCategories extends StatelessWidget {
  final bool viewAll;
  const HomeCategories({Key? key,this.viewAll=false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 15,),
        ViewAllRow(title: translate("app_bar.shop_categories"), fn:()=> RootBloc.get(context).add(ChangeIndex(index: 1, title: translate("app_bar.shop_categories")))),

        const SizedBox(height: 12,),
        HomeCategoriesList(viewAll: viewAll,),


      ],
    );
  }
}
