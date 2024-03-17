import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ProductDescriptionWidget extends StatelessWidget {
  final String txt;
  const ProductDescriptionWidget({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    // bool checkTxtLength = txt.toString().length<400?false:true;
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        // var bloc =  ProductsBloc.get(ctx);
        return Column(
          children: [
            // bloc.showFullContent?
            Padding(
              padding: EdgeInsets.all(10.0.w),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: HtmlWidget(
                  '''
                        $txt
                        ''',
                  customStylesBuilder: (element) {
                    if (element.classes.contains('name')) {
                      return {'color': 'red'};
                    }
                    return null;
                  },
                  textStyle: TextStyle(color: DMUtil.getD2C(),fontFamily: primaryFontReg,height: 1.5,fontSize: AppStyle.small.sp),
                ),
              ),
            )
            //     : Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: SingleChildScrollView(
            //       physics: const NeverScrollableScrollPhysics(),
            //       child: HtmlWidget(
            //         '''
            //         $txt
            //         ''',
            //         customStylesBuilder: (element) {
            //           if (element.classes.contains('name')) {
            //             return {'color': 'red'};
            //           }
            //           return null;
            //         },
            //         textStyle: TextStyle(color: DMUtil.getD2C(),fontFamily: primaryFontReg,height: 1.5),
            //       ),
            //     ),
            //   ),
            // ),

            // Visibility(
            //   visible: checkTxtLength,
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            //     color: DMUtil.getWC(),
            //     child: CustomButton(
            //       height: 35.h,
            //       width: double.infinity,
            //       widget: CustomText(
            //         text:  bloc.showFullContent==false? translate("store.show_more").toUpperCase() :translate("store.show_less").toUpperCase(),
            //         fontSize: AppStyle.small.sp,
            //         color: DMUtil.getRED(),
            //         fontWeight: FontWeight.w600,
            //       ),
            //       circular: 6,
            //       color: DMUtil.getWC(),
            //       sideColor: DMUtil.getRED(),
            //       onPressed: ()=> bloc.add(const ShowFullContentEvent()),
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
