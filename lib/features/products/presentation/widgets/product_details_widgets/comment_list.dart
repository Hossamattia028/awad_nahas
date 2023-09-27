import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/empty_data_widget.dart';
import 'package:awad_nahas/features/shared_widgets/loading_widget.dart';

class CommentList extends StatelessWidget {
  const CommentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (ctx,state){
        var bloc = ProductsBloc.get(ctx);
        if(bloc.currentProduct==null)return const SizedBox.shrink();
        var list = bloc.currentProduct!.reviewsList;
        if(state is ProductCommentsLoadingState)return  LoadingWidget(height: 50.h,);
        if(list!.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: EmptyDataWidget(),
          );
        }
        return ListView.separated(
          itemCount: list.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            var item = list[index];
            return InkWell(
              child: SizedBox(
                width: double.infinity,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20.w,
                          backgroundColor: kPrimary,
                          child: Icon(
                            CupertinoIcons.person_crop_circle,
                            color: Colors.white,
                            size: 30.w,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: item.userName,
                              fontSize: AppStyle.small.sp,
                              color: kText1,
                            ),
                            CustomText(
                              text: item.commentContent,
                              fontSize: AppStyle.small.sp-1,
                              color: kSecondPrimary,
                            ),
                          ],
                        ),
                      ],
                    ),
                    CustomText(
                      text: Util.formatToDayFullMonthYear(DateTime.parse(item.date)).toString().replaceAll("null", ""),
                      fontSize: AppStyle.small.sp,
                      color: kText1,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        );
      },
    );
  }
}
