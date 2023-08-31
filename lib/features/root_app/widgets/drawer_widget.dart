import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/presentation/widgets/account_after_auth.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/setting/presentation/screens/our_locations.dart';
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
      backgroundColor: DMUtil.getWC(),
      width: 230.w,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: AppStyle.paddingFromTop.h+20),
        child: Column(
          children: [
            // CustomText(
            //     text: translate("drawer.menu"),
            //     fontSize: AppStyle.large.sp,
            // ),
            const SizedBox(height: 20,),
            const AccountAuthCard(darkText: true,isDrawer: true,),
            const SizedBox(height: 40,),
            ItemLineDrawer(
              title: translate("drawer.our_company"),
              fn: (){
                Scaffold.of(context).closeEndDrawer();
                RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
              },
            ),
            ItemLineDrawer(
              title: translate("drawer.locations"),
              fn: (){
                Scaffold.of(context).closeEndDrawer();
                Util.pushPage(const OurLocationsScreen(), context);
              },
            ),
            ItemLineDrawer(
              title: translate("drawer.polices"),
              fn: (){
                Scaffold.of(context).closeEndDrawer();
                RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
              },
            ),
            // ItemLineDrawer(
            //   title: translate("drawer.installment"),
            //   fn: (){
            //     Scaffold.of(context).closeEndDrawer();
            //     RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
            //   },
            // ),
            ItemLineDrawer(
              title: translate("drawer.help_center"),
              fn: (){
                Scaffold.of(context).closeEndDrawer();
                RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
              },
            ),
            ItemLineDrawer(
              title: translate("drawer.maintaenance_request"),
              fn: (){
                Scaffold.of(context).closeEndDrawer();
                RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
              },
            ),
            // ItemLineDrawer(
            //   title: translate("app_bar.profile"),
            //   fn: (){
            //     Scaffold.of(context).closeEndDrawer();
            //     RootBloc.get(context).add(const ChangeIndex(index: 2, title: ""));
            //   },
            // ),
            //
            // ItemLineDrawer(
            //   title: translate("profile.notification"),
            //   fn: (){
            //     Scaffold.of(context).closeEndDrawer();
            //     RootBloc.get(context).add(const ChangeIndex(index: 1, title: ""));
            //   },
            // ),
            //
            // ItemLineDrawer(
            //   title: translate("app_bar.myorder"),
            //   fn: (){
            //     Scaffold.of(context).closeEndDrawer();
            //     RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
            //   },
            // ),
            //
            // ItemLineDrawer(
            //   title: translate("profile.account_setting"),
            //   fn: (){
            //     Scaffold.of(context).closeEndDrawer();
            //     RootBloc.get(context).add(const ChangeIndex(index: 2, title: ""));
            //     Util.pushPage(const EditProfilePage(), context);
            //   },
            // ),
            //
            // ItemLineDrawer(
            //   title: translate("activity_setting.about_us"),
            //   fn: (){
            //     Scaffold.of(context).closeEndDrawer();
            //     RootBloc.get(context).add(const ChangeIndex(index: 2, title: ""));
            //     Util.pushPage(const AboutUsScreen(title: ""), context);
            //   },
            // ),
            //
            // const SizedBox(height: 10,),
            // ItemLineDrawer(
            //   title: translate("button.change_language"),
            //   fn: (){
            //     Scaffold.of(context).closeEndDrawer();
            //     Util.changeLang(ctx: context,);
            //   },
            // ),


            if(Util.checkUser())
            ItemLineDrawer(
              title: translate("activity_setting.sign_out"),
              icon: Icon(Icons.logout,size: 22,color: DMUtil.getD2C().withOpacity(0.7),),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 15,),
              Expanded(
                child: CustomText(
                  text: title,
                  color:DMUtil.getDC(),
                  fontWeight: FontWeight.w600,
                  fontSize: AppStyle.small.sp+2,
                ),
              ),
              icon ?? Icon(Icons.arrow_forward_ios,color: DMUtil.getD2C().withOpacity(0.7),size: 15.w,),
              const SizedBox(width: 20,),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: const Divider(height: 50,),
          ),


        ],
      ),
    );
  }
}
