import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
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
              Icon(Icons.remove_circle_outline,color: DMUtil.getREdOPACITY(),),
              const SizedBox(width: 6,),
              CustomText(
                text: translate("profile.delete_account"),
                fontSize: AppStyle.average.sp - 1,
                color: DMUtil.getD2C().withOpacity(0.6),
                fontWeight: FontWeight.w700,
              ),
            ],
          )
      ),
    );
  }
}
