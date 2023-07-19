import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/setting/presentation/screens/about_us_screen.dart';
import 'package:awad_nahas/features/setting/presentation/widgets/small_widgets.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class SettingSectionWidget extends StatelessWidget {
  const SettingSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: CustomText(
            text: translate("activity_setting.contact_us"),
            color: kSecondPrimary,
            fontSize: AppStyle.average.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10,),
        SettingLineOption(iconPath: AppImages.logo,title: translate("activity_setting.contact_us"),onTap: ()=> Util.pushPage(AboutUsScreen(title: translate("activity_setting.replacement")),context)),

        const SizedBox(height: 10,),
        Container(
          color: Colors.white,
          child: Column(
            children: [
              SettingLineOption(iconPath: AppImages.logo,title: translate("activity_setting.about_us"),onTap: ()=> Util.pushPage(AboutUsScreen(title: translate("activity_setting.about_us")), context),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const Divider(thickness: 1,),
              ),
              SettingLineOption(iconPath: AppImages.logo,title: translate("activity_setting.privacy"),onTap: ()=> Util.pushPage(AboutUsScreen(title: translate("activity_setting.privacy")), context),),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        SettingLineOption(iconPath: AppImages.logo,title: translate("button.change_language"),onTap: ()=> Util.changeLang(ctx: context)),

      ],
    );
  }
}
