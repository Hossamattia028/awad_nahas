import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/search/presentation/widgets/sort_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/features/search/presentation/widgets/filter_bottom_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: (){
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
              ),
              builder: (ctx){
                return const SortBottomSheetWidget();
              },
            );
          },
          child: Image.asset(AppImages.sort,width: 31.w,height: 25.h,),
        ),
        const SizedBox(width: 2,),
        InkWell(
          onTap: (){
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
              ),
              builder: (ctx){
                return const SearchFilterBottomSheetWidget();
              },
            );
          },
          child: Image.asset(AppImages.filter,width: 31.w,height: 20.h,),
        ),



      ],
    );
  }
}
