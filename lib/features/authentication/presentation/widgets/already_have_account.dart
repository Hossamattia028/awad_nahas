import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class AlreadyHaveAnAccountWidget extends StatelessWidget {
  const AlreadyHaveAnAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: "${translate("signup.already_have_account")}  ",
          children: [
            TextSpan(
              text: translate("login.app_bar"),
              style: TextStyle(
                color: DMUtil.getPC(),
                fontWeight: FontWeight.w500,
                fontSize: AppStyle.average.sp,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Util.pushPage(const LoginScreen(), context),
            )
          ],
          style: TextStyle(
            color: DMUtil.getD2C(),
          ),
        ),
      ),
    );
  }
}
