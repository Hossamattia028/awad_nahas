import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutBrand extends StatelessWidget {
  final CategoriesEntity itemBrand;
  const AboutBrand({Key? key,required this.itemBrand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CustomText(
            text: itemBrand.title,
            fontSize: AppStyle.small.sp,
            maxLine: 15,
          ),
          SizedBox(
            height: 150.h,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx,index){
                return Image.asset("assets/images/${index==1||index==3||index==7?"miele-2.png":"32447-large.png"}",width: 120.w,);
              },
              separatorBuilder: (ctx,state)=> const SizedBox(width: 10,),
              itemCount: 5,
            ),
          ),

        ],
      ),
    );
  }
}
