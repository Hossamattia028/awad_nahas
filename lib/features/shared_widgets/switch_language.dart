import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchLanguageWidget extends StatelessWidget {
  const SwitchLanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: ()=> Util.changeLang(ctx: context,isLogin: true,lang: "ar"),
          child: CustomText(
            text: "عربي",
            fontSize: AppStyle.average.sp,
            color: Util.getLang()=="ar"?DMUtil.getPC():DMUtil.getD2C(),
          ),
        ),
        TextButton(
          onPressed: ()=> Util.changeLang(ctx: context,isLogin: true,lang: "en_US"),
          child: CustomText(
            text: "English",
            fontSize: AppStyle.average.sp,
            color: Util.getLang()!="ar"?DMUtil.getPC():DMUtil.getD2C(),
          ),
        ),
      ],
    );
  }
}
