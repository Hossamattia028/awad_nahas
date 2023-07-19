import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/shared_widgets/custom_dialogs.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class SignOutWidget extends StatelessWidget {
  const SignOutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> CustomDialogs.signOut(context),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              const Icon(Icons.logout),
              CustomText(
                text: translate("activity_setting.sign_out"),
                color: kSecondPrimary,
                fontSize: AppStyle.average.sp,
                fontFamily: primaryFontBold,
              ),
            ],
          )
      ),
    );
  }
}
