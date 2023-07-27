import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SearchFilterBottomSheetWidget extends StatelessWidget {
  const SearchFilterBottomSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 540.h,
      decoration: BoxDecoration(
          color: DMUtil.getWC(),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
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
                    text: translate("store.filter"),
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
            const FromToRow(),
            const SizedBox(height: 5,),
            CheckBoxWidget(title: translate("store.on_sale"),),
            CheckBoxWidget(title: translate("store.in_of_stock"),),

            CheckBoxWidget(title: translate("store.size"),plus: true,),
            CheckBoxWidget(title: translate("store.color"),plus: true,),
            CheckBoxWidget(title: translate("store.brand"),plus: true,),

            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  height: 40.h,
                  width: 200.w,
                  circular: 20,
                  widget:  CustomText(
                    text: "${translate("button.view")} 12 items",
                    color: Colors.white,
                    fontSize: AppStyle.average.sp,
                  ),
                  color: DMUtil.getRED(),
                  onPressed: (){},
                ),
                CustomButton(
                  height: 40.h,
                  width: 70.w,
                  circular: 20,
                  sideWidth: 1,
                  sideColor: DMUtil.getRED(),
                  widget:  CustomText(
                    text: translate("button.clear"),
                    color: DMUtil.getDC(),
                    fontSize: AppStyle.average.sp,
                  ),
                  color: DMUtil.getWC(),
                  onPressed: (){},
                ),
              ],
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
  final bool plus ;
  const CheckBoxWidget({Key? key,required this.title,this.plus=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 5.h),
      margin: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
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

          if(plus)...[
            Icon(Icons.add,size: 24,color: DMUtil.getDC(),),
          ]else...[
            Container(
              width: 24.w,
              height: 27.h,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  border: Border.all(width: 1.0,color: DMUtil.getD2C())
              ),
            ),
          ],


        ],
      ),
    );
  }
}

class FromToRow extends StatelessWidget {
  const FromToRow({Key? key}) : super(key: key);
  static final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: translate("store.from"),
              fontSize: AppStyle.average.sp,
            ),
            const SizedBox(height: 5,),
            SizedBox(
              width: 150.w,
              child: CustomTextFromField(
                hintText: "   220.0  ${translate("store.sar")}",
                radius: 10,
                textEditingController: textEditingController,
                validator: () {},
                hintColor: DMUtil.getD2C(),
                textInputType: TextInputType.phone,
                prefixIcon:  null,
                cursorColor: DMUtil.getDC(),
                suffixIcon:  null,
                smallPadding: true,
                hasBorder: true,
                obscureText: false,
                isLabelError: false,
                borderColor: DMUtil.getD2C(),
                labelText: '',
              ),
            ),

          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: translate("store.to"),
              fontSize: AppStyle.average.sp,
            ),
            const SizedBox(height: 5,),
            SizedBox(
              width: 150.w,
              child: CustomTextFromField(
                hintText: "   220.0  ${translate("store.sar")}",
                radius: 10,
                textEditingController: textEditingController,
                validator: () {},
                hintColor: DMUtil.getD2C(),
                textInputType: TextInputType.phone,
                prefixIcon:  null,
                cursorColor: DMUtil.getDC(),
                suffixIcon:  null,
                smallPadding: true,
                hasBorder: true,
                obscureText: false,
                isLabelError: false,
                borderColor: DMUtil.getD2C(),
                labelText: '',
              ),
            ),

          ],
        ),
      ],
    );
  }
}

