import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/strings/enum/drawer_enum.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/root_app/widgets/drawer_item_line.dart';
import 'package:awad_nahas/features/setting/presentation/screens/web_view.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class OurPrivacySection extends StatelessWidget {
  final BuildContext ctx;
  const OurPrivacySection({Key? key,required this.ctx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomText(text: translate("drawer.polices"), fontSize: AppStyle.average.sp,color: DMUtil.getDC(),fontWeight: FontWeight.w600,),
            InkWell(
              onTap: ()=> RootBloc.get(context).add(const ChangeDrawerViewEvent(drawerEnum: DrawerEnum.MAIN)),
              child: const Icon(Icons.close),
            ),
          ],
        ),
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
