import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/empty_data_widget.dart';
import 'package:awad_nahas/features/shared_widgets/loading_widget.dart';
import 'package:flutter_translate/flutter_translate.dart';

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
        return Column(
          children: [
            ListView.separated(
              itemCount: bloc.showComments==true?list.length: (list.length>5 ? 5 :list.length),
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
                                RatingBar.builder(
                                  initialRating: item.rating==0.0?1.0:item.rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 24.w,
                                  itemBuilder: (context, _) =>  const Icon(
                                    Icons.star,
                                    color: Colors.amberAccent,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                                SizedBox(
                                  width: 172.w,
                                  child: CustomText(
                                    text: item.commentContent,
                                    fontSize: AppStyle.small.sp-1,
                                    color: DMUtil.getD2C().withOpacity(0.7),
                                    maxLine: 6,
                                    isEllipsis: true,
                                  ),
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
              separatorBuilder: (BuildContext context, int index) => const Divider(height: 30,),
            ),
            const SizedBox(height: 10,),
            Visibility(
              visible: list.length>5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                color: DMUtil.getWC(),
                child: CustomButton(
                  height: 35.h,
                  width: double.infinity,
                  widget: CustomText(
                    text:  bloc.showComments==false? translate("store.show_more").toUpperCase() :translate("store.show_less").toUpperCase(),
                    fontSize: AppStyle.small.sp,
                    color: DMUtil.getRED(),
                    fontWeight: FontWeight.w600,
                  ),
                  circular: 6,
                  color: DMUtil.getWC(),
                  sideColor: DMUtil.getRED(),
                  onPressed: ()=> bloc.add(const ShowCommentsEvent()),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
