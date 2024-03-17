import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchLanguageWidget extends StatelessWidget {
  final bool isLogin;
  final bool isUpdate;
  const SwitchLanguageWidget({super.key,this.isLogin = true,this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: ()=> Util.changeLang(ctx: context,isLogin: isLogin,lang: "ar",isUpdate: isUpdate),
          child: CustomText(
            text: "عربي",
            fontSize: AppStyle.average.sp,
            color: Util.getLang()=="ar"?DMUtil.getPC():DMUtil.getD2C(),
          ),
        ),
        TextButton(
          onPressed: ()=> Util.changeLang(ctx: context,isLogin: isLogin,lang: "en_US",isUpdate: isUpdate),
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
