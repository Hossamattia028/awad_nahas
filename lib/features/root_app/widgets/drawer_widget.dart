import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/presentation/screens/edit_profile_screen.dart';
import 'package:awad_nahas/features/account/presentation/widgets/account_after_auth.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/setting/presentation/screens/about_us_screen.dart';
import 'package:awad_nahas/features/shared_widgets/custom_dialogs.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: 200.w,
      shape: RoundedRectangleBorder(
        borderRadius: Util.getLang()=="ar"? const BorderRadius.only(bottomRight: Radius.circular(25)) : const BorderRadius.only(bottomLeft: Radius.circular(25))
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: AppStyle.paddingFromTop.h+20),
        child: Column(
          children: [
            const AccountAuthCard(darkText: true,),
            const SizedBox(height: 20,),
            ItemLineDrawer(
              title: translate("app_bar.profile"),
              fn: (){
                Scaffold.of(context).closeEndDrawer();
                RootBloc.get(context).add(const ChangeIndex(index: 2, title: ""));
              },
            ),



            ItemLineDrawer(
              title: translate("profile.notification"),
              fn: (){
                Scaffold.of(context).closeEndDrawer();
                RootBloc.get(context).add(const ChangeIndex(index: 1, title: ""));
              },
            ),

            ItemLineDrawer(
              title: translate("app_bar.myorder"),
              fn: (){
                Scaffold.of(context).closeEndDrawer();
                RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
              },
            ),

            ItemLineDrawer(
              title: translate("profile.account_setting"),
              fn: (){
                Scaffold.of(context).closeEndDrawer();
                RootBloc.get(context).add(const ChangeIndex(index: 2, title: ""));
                Util.pushPage(const EditProfilePage(), context);
              },
            ),

            ItemLineDrawer(
              title: translate("activity_setting.about_us"),
              fn: (){
                Scaffold.of(context).closeEndDrawer();
                RootBloc.get(context).add(const ChangeIndex(index: 2, title: ""));
                Util.pushPage(const AboutUsScreen(title: ""), context);
              },
            ),

            const SizedBox(height: 10,),
            ItemLineDrawer(
              title: translate("button.change_language"),
              fn: (){
                Scaffold.of(context).closeEndDrawer();
                Util.changeLang(ctx: context,);
              },
            ),


            if(Util.checkUser())
            ItemLineDrawer(
              title: translate("activity_setting.sign_out"),
              icon: const Icon(Icons.logout,size: 22,),
              fn: (){
                Scaffold.of(context).closeEndDrawer();
                CustomDialogs.signOut(context);
              },
            ),

          ],
        ),
      ),
    );
  }
}

class ItemLineDrawer extends StatelessWidget {
  final String title;
  final VoidCallback fn;
  final Widget? icon;
  const ItemLineDrawer({Key? key,required this.title,required this.fn,this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fn,
      child: Column(
        children: [
          const SizedBox(height: 2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: title,
                color: kPrimary,
                fontSize: AppStyle.small.sp+2,
                fontFamily: primaryFontSemiBold,
              ),
              if(icon!=null)...[
                const SizedBox(width: 5,),
                icon!
              ],
            ],
          ),
          const SizedBox(height: 3,),
          const Divider(thickness: 1,color: Colors.black45,),
        ],
      ),
    );
  }
}
