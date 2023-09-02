import 'package:awad_nahas/core/strings/enum/drawer_enum.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/presentation/widgets/account_after_auth.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/root_app/widgets/drawer_item_line.dart';
import 'package:awad_nahas/features/setting/presentation/screens/help_center.dart';
import 'package:awad_nahas/features/setting/presentation/screens/maintenance.dart';
import 'package:awad_nahas/features/setting/presentation/screens/our_locations.dart';
import 'package:awad_nahas/features/shared_widgets/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';


class MainDrawerSection extends StatelessWidget {
  final BuildContext ctx;
  const MainDrawerSection({Key? key,required this.ctx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AccountAuthCard(darkText: true,isDrawer: true,),
        const SizedBox(height: 40,),
        ItemLineDrawer(
          title: translate("drawer.our_company"),
          fn: (){
            Scaffold.of(ctx).closeEndDrawer();
            RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
            RootBloc.get(context).add(const ChangeDrawerViewEvent(drawerEnum: DrawerEnum.OUR_COMPANY));
          },
        ),
        ItemLineDrawer(
          title: translate("drawer.locations"),
          fn: (){
            Scaffold.of(ctx).closeEndDrawer();
            Util.pushPage(const OurLocationsScreen(), context);
          },
        ),
        ItemLineDrawer(
          title: translate("drawer.polices"),
          fn: (){
            Scaffold.of(ctx).closeEndDrawer();
            RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
            RootBloc.get(context).add(const ChangeDrawerViewEvent(drawerEnum: DrawerEnum.PRIVACY));
          },
        ),

        ItemLineDrawer(
          title: translate("drawer.help_center"),
          fn: (){
            Scaffold.of(ctx).closeEndDrawer();
            RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
            Util.pushPage(const HelpCenterScreen(), context);
          },
        ),
        if(Util.checkUser())...[
          ItemLineDrawer(
            title: translate("drawer.maintaenance_request"),
            fn: (){
              Scaffold.of(ctx).closeEndDrawer();
              RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
              Util.pushPage(const MaintenanceScreen(), context);
            },
          ),
          ItemLineDrawer(
            title: translate("activity_setting.sign_out"),
            icon: Icon(Icons.logout,size: 22,color: DMUtil.getD2C().withOpacity(0.7),),
            fn: (){
              Scaffold.of(ctx).closeEndDrawer();
              CustomDialogs.signOut(context);
            },
          ),
        ],
      ],
    );
  }
}
