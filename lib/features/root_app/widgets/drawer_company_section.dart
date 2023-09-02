import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/strings/enum/drawer_enum.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/root_app/widgets/drawer_item_line.dart';
import 'package:awad_nahas/features/setting/presentation/screens/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class OurCompanySection extends StatelessWidget {
  final BuildContext ctx;
  const OurCompanySection({Key? key,required this.ctx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ()=> RootBloc.get(context).add(const ChangeDrawerViewEvent(drawerEnum: DrawerEnum.MAIN)),
          child: const Icon(Icons.close),
        ),
        ItemLineDrawer(
          title: translate("activity_setting.services"),
          fn: (){
            Scaffold.of(ctx).closeEndDrawer();
            RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
            Util.pushPage(WebViewScreen(title: translate("activity_setting.services"), url: ApiUrl.SERVICES), context);
          },
        ),
        ItemLineDrawer(
          title: translate("activity_setting.strategy"),
          fn: (){
            Scaffold.of(ctx).closeEndDrawer();
            RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
            Util.pushPage(WebViewScreen(title: translate("activity_setting.strategy"), url: ApiUrl.ESTRAIGIATNA), context);
          },
        ),
        ItemLineDrawer(
          title: translate("activity_setting.brands"),
          fn: (){
            Scaffold.of(ctx).closeEndDrawer();
            RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
            Util.pushPage(WebViewScreen(title: translate("activity_setting.brands"), url: ApiUrl.OUR_BRANDS), context);
          },
        ),
        ItemLineDrawer(
          title: translate("activity_setting.projects"),
          fn: (){
            Scaffold.of(ctx).closeEndDrawer();
            RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
            Util.pushPage(WebViewScreen(title: translate("activity_setting.projects"), url: ApiUrl.OUR_PROJECTS), context);
          },
        ),
      ],
    );
  }
}
