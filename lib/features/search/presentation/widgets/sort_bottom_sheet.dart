import 'package:awad_nahas/core/strings/enum/filter_enum.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SortBottomSheetWidget extends StatelessWidget {
  const SortBottomSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420.h,
      decoration: BoxDecoration(
          color: DMUtil.getWC(),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
      child:  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomText(
                    text: translate("store.sort_by"),
                    fontSize: AppStyle.average.sp,
                    alignCenter: true,
                  ),
                ),
                InkWell(
                  onTap: ()=> Navigator.of(context).pop(),
                  child: Icon(Icons.close,color: DMUtil.getDC(),),
                ),
              ],
            ),
            const SizedBox(height: 10,),

                BlocBuilder<ProductsBloc,ProductsState>(
                  builder: (ctx,state){
                    var bloc = ProductsBloc.get(ctx);
                    return Column(
                      children: [
                        CheckBoxWidget(title: translate("store.popularity"),enabled: bloc.currentSort == SortEnum.POPULAR,sortType: SortEnum.POPULAR,),

                        CheckBoxWidget(title: translate("store.averageـrating"),enabled: bloc.currentSort == SortEnum.AVERAGE_RATE,sortType: SortEnum.AVERAGE_RATE,),

                        CheckBoxWidget(title: translate("store.newness"),enabled: bloc.currentSort == SortEnum.NEW,sortType: SortEnum.NEW,),

                        CheckBoxWidget(title: translate("store.low_to_high"),enabled: bloc.currentSort == SortEnum.PRICE_LOW_TO_HIGH,sortType: SortEnum.PRICE_LOW_TO_HIGH,),

                        CheckBoxWidget(title: translate("store.high_to_low"),enabled: bloc.currentSort == SortEnum.PRICE_HIGH_TO_LOW,sortType: SortEnum.PRICE_HIGH_TO_LOW,),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 10,),
              ],
            ),
          )
    );
  }
}


class CheckBoxWidget extends StatelessWidget {
  final String title ;
  final bool enabled;
  final SortEnum sortType;
  const CheckBoxWidget({Key? key,required this.title,required this.enabled,required this.sortType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        ProductsBloc.get(context).add(ChangeSortEvent(sortEnum: sortType));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 0.5,color: DMUtil.getD2C())
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              fontSize: AppStyle.average.sp,
            ),

            if(enabled)
            CircleAvatar(
              backgroundColor: DMUtil.getRED(),
              radius: 10.w,
              child: Icon(Icons.check,color: Colors.white,size: 14.w,),
            ),


          ],
        ),
      ),
    );
  }
}



