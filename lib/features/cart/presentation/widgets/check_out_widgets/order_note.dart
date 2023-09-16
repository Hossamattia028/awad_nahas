import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class OrderNoteWidget extends StatelessWidget {
  const OrderNoteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController noteTextEditingController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(10),
      color: DMUtil.getWC(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: DMUtil.getWC(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: translate("cart.order_note"),
              color: DMUtil.getDC(),
              fontSize: AppStyle.average.sp,
            ),

            CustomTextFromField(
                hintText: "",
                labelText: "",
                height: 80,
                maxLines: 15,
                cursorColor: DMUtil.getRED(),
                hasBorder: true,
                smallPadding: true,
                radius: 7,
                textInputType: TextInputType.text,
                textEditingController: noteTextEditingController,
                validator: (){},
                obscureText: false,
                isLabelError: false),
          ],
        ),
      ),
    );
  }
}
