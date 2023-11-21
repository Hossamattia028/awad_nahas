import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/search/presentation/widgets/sort_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/features/search/presentation/widgets/filter_bottom_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              useRootNavigator: true,
              isScrollControlled: true,
              useSafeArea: true,
              backgroundColor: Colors.transparent,
              shape:  const RoundedRectangleBorder(
                borderRadius:  BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
              ),
              builder: (ctx){
                return const SortBottomSheetWidget();
              },
            );
          },
          child: SvgPicture.asset(AppImages.sort,colorFilter: ColorFilter.mode(DMUtil.getD2C(), BlendMode.srcIn),width: (10.h + 12.w),),
        ),
        SizedBox(width: 4.w,),
        InkWell(
          onTap: (){
            ProductsBloc.get(context).add(const UpdateFilterAttributesDataEvent());
            showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              isScrollControlled: true,
              useSafeArea: true,
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
              ),
              builder: (ctx){
                return const SearchFilterBottomSheetWidget();
              },
            );
          },
          child: SvgPicture.asset(AppImages.filter,colorFilter: ColorFilter.mode(DMUtil.getD2C(), BlendMode.srcIn),width: (10.h + 16.w),),
        ),


      ],
    );
  }
}
