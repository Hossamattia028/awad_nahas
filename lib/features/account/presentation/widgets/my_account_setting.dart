import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/presentation/screens/edit_profile_screen.dart';
import 'package:awad_nahas/features/setting/presentation/widgets/small_widgets.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class MyAccountSetting extends StatelessWidget {
  const MyAccountSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: CustomText(
            text: translate("profile.my_account"),
            color: kSecondPrimary,
            fontSize: AppStyle.average.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10,),

        SettingLineOption(iconPath: AppImages.logo,title: translate("profile.edit"),onTap: ()=> Util.pushPage(const EditProfilePage(), context),),

      ],
    );
  }
}
