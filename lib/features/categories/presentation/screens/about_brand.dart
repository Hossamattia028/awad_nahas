import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutBrand extends StatelessWidget {
  const AboutBrand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CustomText(
            text: "Carl Miele and Reinhard Zinkann sign a contract in June 1899 with the aim of establishing Miele & Cie, a factory for making cream separators by 1 July 1899. \n Miele is a German manufacturer of high-end domestic appliances, commercial equipment and fitted kitchens, headquartered in Gütersloh, Ostwestfalen-Lippe, Germany. \n The company was founded in 1899 by Carl Miele and Reinhard Zinkann, and has always been a family-owned and run company. \nMiele offers products to its customers that set the standards for durability, performance, ease of use, energy efficiency, design and service.",
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
