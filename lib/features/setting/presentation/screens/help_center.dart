import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/setting/presentation/widgets/contact_us_widget.dart';
import 'package:awad_nahas/features/setting/presentation/widgets/faqs_list.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';


class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>  with TickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 2);
    super.initState();
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DMUtil.getWC(),
        appBar: GlobalAppBar(
          title: translate("drawer.help_center"),
          leadingIcon: const BackArrowButton(),
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SizedBox(
                height: 40.h,
                child: TabBar(
                  controller: tabController,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 10.w),
                  indicator: ShapeDecoration(
                      color: DMUtil.getRED(),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )
                  ),
                  unselectedLabelColor: DMUtil.getDC(),
                  indicatorColor: DMUtil.getPC(),
                  labelColor: DMUtil.getWC(),
                  isScrollable: true,
                  labelStyle: TextStyle(color: DMUtil.getPC(),fontSize: AppStyle.small.sp+1,fontFamily: primaryFontReg,fontWeight: FontWeight.w500),
                  tabs: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.w) + const EdgeInsets.only(top: 3),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(width: 1,color: DMUtil.getRED())
                      ),
                      child: Tab(text: translate("drawer.faqs"),),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.w) + const EdgeInsets.only(top: 3),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1,color: DMUtil.getRED())
                      ),
                      child: Tab(text: translate("activity_setting.call_us"),),
                    ),

                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: AppStyle.paddingFromTop.h+40),
                child: TabBarView(
                  controller: tabController,
                  children:  const [
                    FaqsListWidget(),
                    ContactUsWidget(),
                  ],
                )
            ),
          ],
        )
    );
  }
}


