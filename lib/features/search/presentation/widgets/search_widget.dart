
import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';

class SearchWidget extends StatelessWidget {
  final bool isPop;
  const SearchWidget({Key? key,this.isPop =false}) : super(key: key);
  static TextEditingController searchTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: ()=> Scaffold.of(context).openEndDrawer(),
          child: Image.asset(AppImages.drawer,height: 34.h,width: 30.w,),
        ),
        const SizedBox(width: 5,),
        Expanded(
          child: Container(
              height: 39.h,
              decoration: const BoxDecoration(
                  color: kHomeSearchBack,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: BlocBuilder<RootBloc,RootState>(
                builder: (ctx,state){
                  var bloc = RootBloc.get(ctx);
                  return CustomTextFromField(
                    onChanged: (val){
                      if(val.toString().trim()==""){
                        return bloc.add(SearchEvent(word: val.toString().trim().toLowerCase(),
                            categoryList: CategoriesBloc.get(context).categoriesList,productList: ProductsBloc.get(context).productsList));
                      }
                    },
                    onFieldSubmitted:(val){
                      bloc.add(SearchEvent(word: val.toString().trim().toLowerCase(),categoryList: CategoriesBloc.get(context).categoriesList,productList:ProductsBloc.get(context).productsList));
                      bloc.add(const ChangeIndex(index: 0, title: ""));
                      if(isPop)return Navigator.of(context).pop();
                    },
                    hintText: translate("app_bar.search"),
                    labelText: "",
                    hintColor: kSecondPrimary,
                    radius: 10,
                    textEditingController: searchTextEditingController,
                    cursorColor: kPrimary,
                    validator: () {},
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: DMUtil.getDC(),
                    ),
                    smallPadding: true,
                    obscureText: false,
                    hasBorder: true,
                    isLabelError: false,
                  );
                },
              )
          ),
        ),
      ],
    );
  }
}
