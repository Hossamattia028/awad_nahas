import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/comment_list.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_dialogs.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class ProductReviewsWidget extends StatelessWidget {
  const ProductReviewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        var bloc = ProductsBloc.get(ctx);
        return InkWell(
          onTap: ()=> bloc.add(const ShowCommentsEvent()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15,),
              const SizedBox(height: 10,),
             if(bloc.showComments==true)...[
               const CommentList(),
               const SizedBox(height: 10,),
               if(Util.checkUser())
               CustomButton(
                 height: 36.h,
                 width: 280.w,
                 circular: 5,
                 widget: CustomText(
                   text: translate("products.add_comment").toUpperCase(),
                   color: Colors.white,
                   fontWeight: FontWeight.w500,
                   fontSize: AppStyle.average.sp,
                 ),
                 color: kSecondPrimary,
                 onPressed: () => CustomDialogs.addComment(context),
               ),
             ],
            ],
          ),
        );
      },
    );
  }
}
