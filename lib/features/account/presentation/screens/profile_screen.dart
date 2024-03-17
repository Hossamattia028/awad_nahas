import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/account/presentation/widgets/account_after_auth.dart';
import 'package:awad_nahas/features/root_app/widgets/drawer_icon.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/presentation/widgets/my_account_setting.dart';
import 'package:awad_nahas/features/account/presentation/widgets/setting_section.dart';
import 'package:awad_nahas/features/account/presentation/widgets/sign_out_widget.dart';
import 'package:flutter_translate/flutter_translate.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getBackGround(),
      appBar: GlobalAppBar(
        backGroundColor: DMUtil.getWC(),
        title: !Util.checkUser()?"":translate("profile.my_account"),
        leadingIcon: DrawerIcon(ctx: context,color: DMUtil.getDC(),),
      ),
      body: RefreshIndicator(
        onRefresh: () => _buildRefresh(context),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children:  [
              const AccountAuthCardProfile(),
              const SizedBox(height: 13,),

              if(Util.checkUser())...[
                const MyAccountSetting(),
              ],

              const SettingSectionWidget(),

              if(Util.checkUser())...[
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
