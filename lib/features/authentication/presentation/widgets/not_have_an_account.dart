import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class NotHaveAnAccountWidget extends StatelessWidget {
  const NotHaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text:
        "${translate("login.dont_have_anaccount")}  ",
        children: [
          TextSpan(
            text: translate("signup.signup"),
            style: TextStyle(
              color: DMUtil.getPC(),
              fontWeight: FontWeight.w500,
              fontSize: AppStyle.average.sp,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Util.pushPage(const RegisterScreen(), context),
          )
        ],
        style: TextStyle(
          color: DMUtil.getD2C(),
          fontFamily: primaryFontReg,
          fontSize: AppStyle.small.sp
        ),
      ),
    );
  }
}
