import 'dart:io';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/account/presentation/widgets/account_after_auth.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/login.dart';
import 'package:awad_nahas/features/root_app/widgets/drawer_icon.dart';
import 'package:awad_nahas/features/setting/presentation/widgets/small_widgets.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/presentation/widgets/delete_account_widget.dart';
import 'package:awad_nahas/features/account/presentation/widgets/my_account_setting.dart';
import 'package:awad_nahas/features/account/presentation/widgets/setting_section.dart';
import 'package:awad_nahas/features/account/presentation/widgets/sign_out_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      appBar: GlobalAppBar(
        title: !Util.checkUser()?"":translate("profile.my_account"),
        leadingIcon: DrawerIcon(ctx: context,color: DMUtil.getDC(),),
      ),
      body: RefreshIndicator(
        onRefresh: () => _buildRefresh(context),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: AppStyle.paddingFromTop.h,horizontal: AppStyle.paddingFromH.w - 4),
          child: Column(
            children:  [
              const AccountAuthCard(),
              const SizedBox(height: 10,),

              if(Util.checkUser())...[
                const MyAccountSetting(),
              ]else...[
                SettingLineOption(title: translate("login.login"),onTap: ()=> Util.pushPage(const LoginScreen(), context),),
              ],

              const SizedBox(height: 10,),
              const SettingSectionWidget(),

              if(Util.checkUser())...[
                if(Platform.isIOS)...[
                  const SizedBox(height: 10,),
                  const DeleteAccountWidget(),
                ],
                const SizedBox(height: 20,),
                const SignOutWidget(),
              ],

              const SizedBox(height: 100,),

            ],
          ),
        ),
      )
    );
  }

  Future<void> _buildRefresh(BuildContext context) async {
    Util.getAllUserAppData(context: context);
  }
}
