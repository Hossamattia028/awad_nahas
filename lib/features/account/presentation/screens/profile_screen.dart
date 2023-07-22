import 'dart:io';
import 'package:awad_nahas/features/root_app/widgets/drawer_icon.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/presentation/widgets/account_after_auth.dart';
import 'package:awad_nahas/features/account/presentation/widgets/delete_account_widget.dart';
import 'package:awad_nahas/features/account/presentation/widgets/my_account_setting.dart';
import 'package:awad_nahas/features/account/presentation/widgets/setting_section.dart';
import 'package:awad_nahas/features/account/presentation/widgets/sign_out_widget.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: GlobalAppBar(
        justLogo: true,
        title: '',
        whiteLogo: true,
        backGroundColor: kPrimary,
        leadingIcon: DrawerIcon(ctx: context,),
      ),
      body: RefreshIndicator(
        onRefresh: () => _buildRefresh(context),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
                const AccountAuthCard(darkText: true,),
                const MyAccountSetting(),


              const SettingSectionWidget(),


              if(Util.checkUser())...[
                if(Platform.isIOS)...[
                  const SizedBox(height: 10,),
                  const DeleteAccountWidget(),
                ],
                const SizedBox(height: 20,),
                const SignOutWidget(),
              ],

              const SizedBox(height: 200,),

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
