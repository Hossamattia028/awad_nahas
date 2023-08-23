import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_event.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_state.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/setting/presentation/widgets/small_widgets.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class SettingSectionWidget extends StatelessWidget {
  const SettingSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(height: 5,),
        // CustomText(
        //   text: translate("activity_setting.contact_us"),
        //   color: DMUtil.getDC(),
        //   fontSize: AppStyle.average.sp,
        // ),
        // SettingLineOption(title: translate("activity_setting.contact_us"),onTap: ()=> Util.pushPage(AboutUsScreen(title: translate("activity_setting.replacement")),context)),
        //
        // Container(
        //   color: Colors.white,
        //   child: Column(
        //     children: [
        //       SettingLineOption(title: translate("activity_setting.about_us"),onTap: ()=> Util.pushPage(AboutUsScreen(title: translate("activity_setting.about_us")), context),),
        //       SettingLineOption(title: translate("activity_setting.privacy"),onTap: ()=> Util.pushPage(AboutUsScreen(title: translate("activity_setting.privacy")), context),),
        //     ],
        //   ),
        // ),
        const SizedBox(height: 5,),
        CustomText(
          text: translate("activity_setting.app_bar"),
          color: DMUtil.getDC(),
          fontSize: AppStyle.average.sp,
        ),
        SettingLineOption(
          title: translate("button.change_language"),
          onTap: ()=> Util.changeLang(ctx: context),
        ),
        SettingLineOption(
          title: translate("profile.notification"),
          widget: BlocBuilder<AccountBloc,AccountState>(
            builder: (ctx,state){
              var bloc = AccountBloc.get(ctx);
              var isEnabled = bloc.isEnabledNotification;
              return SizedBox(
                height: 25.h,
                child: Switch(
                    value: isEnabled,
                    activeColor: DMUtil.getRED(),
                    onChanged: (val)=> bloc.add(const ChangeNotificationModeEvent()),
                ),
              );
            },
          ),
        ),

        SettingLineOption(
          title: translate("activity_setting.dark_mode"),
          widget: SizedBox(
            height: 25.h,
            child: Switch(
              value: DMUtil.currentThemeIsDark(),
              activeColor: DMUtil.getRED(),
              onChanged: (val){
                SharedPref().setPreferencesString(Constants.userTheme, DMUtil.currentThemeIsDark()?"light":"dark");
                RootBloc.get(context).add(const ChangeIndex(index: 4, title: ""));
                Util.pushPageAndRemoveRoutes(const RootScreen(), context);
              }),
          ),
        ),

        const SizedBox(height: 15,),
        CustomText(
          text: translate("drawer.help_center"),
          color: DMUtil.getDC(),
          fontSize: AppStyle.average.sp,
        ),
        SettingLineOption(title: translate("drawer.help_center"),onTap: (){}),

      ],
    );
  }
}
