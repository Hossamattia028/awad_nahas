import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/shared_widgets/custom_dialogs.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class DeleteAccountWidget extends StatelessWidget {
  const DeleteAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> CustomDialogs.deleteAccount(context),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              const Icon(Icons.remove_circle_outline,color: Colors.black26,),
              const SizedBox(width: 6,),
              CustomText(
                text: translate("profile.delete_account"),
                color: kSecondPrimary,
                fontSize: AppStyle.average.sp - 1,
                fontWeight: FontWeight.w700,
              ),
            ],
          )
      ),
    );
  }
}
