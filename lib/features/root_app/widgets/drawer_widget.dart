import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/strings/enum/drawer_enum.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/root_app/bloc/root_state.dart';
import 'package:awad_nahas/features/root_app/widgets/drawer_company_section.dart';
import 'package:awad_nahas/features/root_app/widgets/drawer_item_line.dart';
import 'package:awad_nahas/features/root_app/widgets/main_drawer_section.dart';
import 'package:awad_nahas/features/setting/presentation/screens/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        child: BlocBuilder<RootBloc,RootState>(
          builder: (ctx,state){
            var bloc = RootBloc.get(ctx);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 20,),

                if(bloc.drawerEnum == DrawerEnum.OUR_COMPANY)...[
                  OurCompanySection(ctx: context),
                ]else if(bloc.drawerEnum == DrawerEnum.OUR_COMPANY)...[
                  InkWell(
                    onTap: ()=> bloc.add(const ChangeDrawerViewEvent(drawerEnum: DrawerEnum.MAIN)),
                    child: const Icon(Icons.close),
                  ),
                  ItemLineDrawer(
                    title: translate("activity_setting.projects"),
                    fn: (){
                      Scaffold.of(context).closeEndDrawer();
                      RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
                      Util.pushPage(WebViewScreen(title: translate("activity_setting.projects"), url: ApiUrl.OUR_PROJECTS), context);
                    },
                  ),
                ]else ...[
                  MainDrawerSection(ctx: context),
                ],
              ],
            );
          },
        )
      ),
    );
  }
}





// ItemLineDrawer(
//   title: translate("drawer.installment"),
//   fn: (){
//     Scaffold.of(context).closeEndDrawer();
//     RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
//   },
// ),
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
