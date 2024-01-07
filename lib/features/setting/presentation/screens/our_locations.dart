import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_state.dart';
import 'package:awad_nahas/features/shared_widgets/align_child_by_row.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class OurLocationsScreen extends StatelessWidget {
  const OurLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      appBar: GlobalAppBar(
        title: translate("drawer.locations"),
        leadingIcon: const BackArrowButton(),
      ),
      body: BlocBuilder<RootBloc,RootState>(
        builder: (ctx,state){
          var bloc = RootBloc.get(ctx);
          var list = bloc.ourLocations;
          if(list.isEmpty)return const SizedBox.shrink();
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(10),
              itemBuilder: (ctx,index){
                var item = list[index];
                String title = item.address1;
                if(item.address1.contains("Miel") && Util.getLang()=="ar"){
                  title = "معرض ميلي";
                }
                if(Util.getLang()!="ar"){
                  if(item.address1.contains("الرياض"))title = "Riyadh Showroom";
                  if(item.address1.contains("رياض 2"))title = "Riyadh Showroom 2";
                  if(item.address1.contains("الخبر"))title = "Khobar Showroom";
                  if(item.address1.contains("ميلي"))title = "Miele Gallery";
                  if(item.address1.contains("معرض المدينة"))title = "Madina Road";
                }
                if(!title.contains("معرض") && Util.getLang()=="ar"){
                  title = "  معرض $title " ;
                }
                return Card(
                  elevation: 4,
                  color: DMUtil.getWC(),
                  shape: RoundedRectangleBorder(
                      side: DMUtil.currentThemeIsDark() ? const BorderSide(color: Colors.white) : BorderSide.none,
                      borderRadius: const BorderRadius.all(Radius.circular(5))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: title,
                          color: DMUtil.getDC(),
                          fontSize: AppStyle.average.sp+1,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "${translate("activity_setting.all_days")} ${translate("activity_setting.from")} 9 ${translate("activity_setting.am")} ${translate("activity_setting.to")} 11 ${translate("activity_setting.pm")}",
                                  color: DMUtil.getD2C(),
                                  fontSize: AppStyle.small.sp ,
                                ),
                                const SizedBox(height: 5,),
                                Row(
                                  children: [
                                    CustomText(
                                        text: "${translate("activity_setting.time_on_friday")} ",
                                        color: DMUtil.getRED(),
                                        fontSize: AppStyle.small.sp-1
                                    ),
                                    CustomText(
                                        text: " ${translate("activity_setting.from")} 3 ${translate("activity_setting.pm")} ${translate("activity_setting.to")} 11 ${translate("activity_setting.pm")}",
                                        color: DMUtil.getD2C(),
                                        fontSize: AppStyle.small.sp-1
                                    ),
                                  ],
                                )
                              ],
                            ),
                            AlignChildRow(
                              isStart: false,
                              child: CustomButton(
                                circular: 10,
                                height: 30.h,
                                width: 100.w,
                                widget: CustomText(
                                  text: translate("map.sides"),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppStyle.small.sp,
                                ),
                                color: DMUtil.getRED(),
                                onPressed: ()=> Util.openMapApp(item.lat.toString(), item.long.toString()),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx,state)=> SizedBox(height: 12.w,),
              itemCount: list.length,
          );
        },
      ),
    );
  }
}
