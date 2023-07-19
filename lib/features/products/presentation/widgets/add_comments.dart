import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';

class AddCommentsWidget extends StatelessWidget {
  const AddCommentsWidget({Key? key}) : super(key: key);
  static final TextEditingController commentTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.h,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 54.h,
            child: CustomTextFromField(
                hintText: "",
                labelText: translate("products.add_comment"),
                radius: 1,
                textEditingController: commentTextEditingController,
                validator: () {},
                hintColor: kSecondPrimary,
                prefixIcon: null,
                cursorColor: kPrimary,
                hasBorder: true,
                suffixIcon: const SizedBox(),
                obscureText: false,
                isLabelError: false),
          ),
          const SizedBox(
            height: 20,
          ),

          BlocListener<ProductsBloc,ProductsState>(
            listener: (ctx,state){
              if(state is ProductCommentsSuccessfullyState) {
                commentTextEditingController.text = "";
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
                    text: translate("products.add_comment").toUpperCase(),
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: AppStyle.average.sp,
                  ),
                  color: kSecondPrimary,
                  onPressed: (){
                    var val = commentTextEditingController.text;
                    if(val.trim().isNotEmpty){
                      bloc.add(AddProductCommentEvent(txt: val,));
                    }else{
                      SnackBarBuilder.showFeedBackMessage(context, translate("toast.field_empty"), Colors.red);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
