import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/shared_widgets/like_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';

class AddCommentsWidget extends StatelessWidget {
  final ProductsEntity item;
  const AddCommentsWidget({Key? key,required this.item}) : super(key: key);
  static final TextEditingController commentTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 305.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: translate("products.review_product"),
                color: DMUtil.getDC(),
                fontWeight: FontWeight.w600,
                fontSize: AppStyle.average.sp+1,
                isEllipsis: true,
              ),
              const LikeIcon(),
            ],
          ),
          const SizedBox(height: 10,),
          SizedBox(
            width: 340.w,
            child: CustomText(
              text: item.title,
              color: DMUtil.getDC().withOpacity(0.7),
              fontWeight: FontWeight.w600,
              fontSize: AppStyle.average.sp-3,
              isEllipsis: true,
              maxLine: 4,
            ),
          ),
          const SizedBox(height: 15,),
          Align(
            child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 30.w,
              itemBuilder: (context, _) =>  const Icon(
                Icons.star,
                color: Colors.amberAccent,
              ),
              onRatingUpdate: (rating) => ProductsBloc.get(context).add(UpdateProductCommentEvent(value: rating)),
            ),
          ),
          const SizedBox(height: 15,),
          SizedBox(
            height: 70.h,
            child: CustomTextFromField(
                hintText: "",
                labelText: translate("products.add_comment"),
                radius: 1,
                maxLines: 2,
                textEditingController: commentTextEditingController,
                validator: () {},
                hintColor: DMUtil.getD2C(),
                prefixIcon: null,
                cursorColor: DMUtil.getRED(),
                hasBorder: true,
                suffixIcon: null,
                obscureText: false,
                isLabelError: false),
          ),
          const SizedBox(height: 15,),

          Align(
            child: BlocListener<ProductsBloc,ProductsState>(
              listener: (ctx,state){
                if(state is ProductCommentsSuccessfullyState) {
                  commentTextEditingController.text = "";
                  SnackBarBuilder.showFeedBackMessage(context, translate("toast.thanks_for_rating"), DMUtil.getGreen());
                  return Navigator.of(context).pop();
                }

                if(state is ProductCommentsFailedState) {
                  SnackBarBuilder.showFeedBackMessage(context, translate("toast.oops"), DMUtil.getGreen());
                  return Navigator.of(context).pop();
                }
              },
              listenWhen: (ctx,state)=> state is ProductCommentsSuccessfullyState,
              child: BlocBuilder<ProductsBloc,ProductsState>(
                builder: (ctx,state){
                  var bloc = ProductsBloc.get(ctx);
                  return CustomButton(
                    height: 36.h,
                    width: 280.w,
                    circular: 5,
                    widget: state is ProductCommentsLoadingState?
                    const CircularProgressIndicator(color: Colors.white,):
                    CustomText(
                      text: translate("button.send").toUpperCase(),
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: AppStyle.average.sp,
                    ),
                    color: DMUtil.getRED(),
                    onPressed: (){
                      var val = commentTextEditingController.text;
                      if(val.trim().isNotEmpty){
                        bloc.add(AddProductCommentEvent(txt: val,productId: item.id));
                      }else{
                        SnackBarBuilder.showFeedBackMessage(context, translate("toast.field_empty"), Colors.red);
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
