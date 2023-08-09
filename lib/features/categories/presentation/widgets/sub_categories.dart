import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubCategoriesHList extends StatelessWidget {
  const SubCategoriesHList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc,CategoriesState>(
      builder: (ctx,state){
        var bloc = CategoriesBloc.get(ctx);
        var list = bloc.subCategoriesList;
        if(bloc.currentCategory!=null) list = list.where((element) => element.parentID.toString()==bloc.currentCategory!.id.toString()).toList();
        return SizedBox(
          height: 44.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,vertical: 10),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (ctx,index){
              var item = list[index];
              bool isEnabled = item == bloc.currentSubCategory;
              return InkWell(
                onTap: ()=> bloc.add(ChangeSubCategoriesEvent(categoriesModel: item)),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1,color:  isEnabled ? DMUtil.getPC():Colors.transparent))
                  ),
                  child: CustomText(text: item.title.toString(), fontSize: AppStyle.average.sp,color: isEnabled ?DMUtil.getPC():DMUtil.getDC(),),
                ),
              );
            },
            separatorBuilder: (ctx,index)=> const SizedBox(width: 10,),
          ),
        );
      },
    );
  }
}
