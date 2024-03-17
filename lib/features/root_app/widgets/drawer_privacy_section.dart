import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/root_app/widgets/close_window_icon.dart';
import 'package:awad_nahas/features/root_app/widgets/drawer_item_line.dart';
import 'package:awad_nahas/features/setting/presentation/screens/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class OurPrivacySection extends StatelessWidget {
  final BuildContext ctx;
  const OurPrivacySection({super.key,required this.ctx});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CloseWindowIcon(title: translate("drawer.polices")),
        SizedBox(height: 50.h,),


        ItemLineDrawer(
          title: translate("activity_setting.privacy"),
          fn: (){
            Scaffold.of(ctx).closeEndDrawer();
            RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
            Util.pushPage(WebViewScreen(title: translate("activity_setting.privacy"), url: ApiUrl.PRIVACY), context);
          },
        ),
        ItemLineDrawer(
          title: translate("activity_setting.payments"),
          fn: (){
            Scaffold.of(ctx).closeEndDrawer();
            RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
            Util.pushPage(WebViewScreen(title: translate("activity_setting.payments"), url: ApiUrl.PAYMENT_GATEWAYS), context);
          },
        ),
        ItemLineDrawer(
          title: translate("activity_setting.terms_condition"),
          fn: (){
            Scaffold.of(ctx).closeEndDrawer();
            RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
            Util.pushPage(WebViewScreen(title: translate("activity_setting.terms_condition"), url: ApiUrl.TERMS_CONDITIONS), context);
          },
        ),
        ItemLineDrawer(
          title: translate("activity_setting.replacement"),
          fn: (){
            Scaffold.of(ctx).closeEndDrawer();
            RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
            Util.pushPage(WebViewScreen(title: translate("activity_setting.replacement"), url: ApiUrl.REPLACEMENT), context);
          },
        ),
        ItemLineDrawer(
          title: translate("activity_setting.warrantyـpolicy"),
          fn: (){
            Scaffold.of(ctx).closeEndDrawer();
            RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
            Util.pushPage(WebViewScreen(title: translate("activity_setting.warrantyـpolicy"), url: ApiUrl.ENSURE), context);
          },
        ),
        ItemLineDrawer(
          title: translate("activity_setting.delivery_policy"),
          fn: (){
            Scaffold.of(ctx).closeEndDrawer();
            RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
            Util.pushPage(WebViewScreen(title: translate("activity_setting.delivery_policy"), url: ApiUrl.DELIVERY), context);
          },
        ),
      ],
    );
  }
}
