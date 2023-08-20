import 'package:flutter/material.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SwitchLanguageWidget extends StatelessWidget {
  const SwitchLanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: ()=> Util.changeLang(ctx: context,isLogin: true),
          child: CustomText(
            text: translate("language.name.en"),
            fontSize: AppStyle.average.sp,
            color: Util.getLang()!="ar"?kPrimary:kPrimaryBlack,
          ),
        ),
        TextButton(
          onPressed: ()=> Util.changeLang(ctx: context,isLogin: true),
          child: CustomText(
            text: translate("language.name.ar"),
            fontSize: AppStyle.average.sp,
            color: Util.getLang()=="ar"?kPrimary:kPrimaryBlack,
          ),
        ),
      ],
    );
  }
}
