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

class OurCompanySection extends StatelessWidget {
  final BuildContext ctx;
  const OurCompanySection({Key? key,required this.ctx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomText(text: translate("drawer.our_company"), fontSize: AppStyle.average.sp,color: DMUtil.getDC(),fontWeight: FontWeight.w600,),
            InkWell(
              onTap: ()=> RootBloc.get(context).add(const ChangeDrawerViewEvent(drawerEnum: DrawerEnum.MAIN)),
              child: Icon(Icons.close,size: 20.w,),
            ),
          ],
        ),
        SizedBox(height: 50.h,),

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
