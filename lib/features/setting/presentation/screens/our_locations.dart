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
import 'package:url_launcher/url_launcher.dart';

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
                var cl = "invalid";
                if (item.hours != null) {
                  var closed = (item.hours!.last).split(',');
                    cl = closed[1];
                }
                return Card(
                  elevation: 2,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: item.address1,
                            color: DMUtil.getDC(),
                            fontSize: AppStyle.average.sp+1
                        ),
                        const SizedBox(height: 5,),
                        CustomText(
                            text: item.address2,
                            color: DMUtil.getD2C(),
                            fontSize: AppStyle.small.sp
                        ),
                        if(item.hours != null &&  item.hours!.isNotEmpty)
                        CustomText(
                            text: "${translate("activity_setting.open_until")} $cl",
                            color: DMUtil.getRED(),
                            fontSize: AppStyle.small.sp
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
                            onPressed: (){
                              Util.openMapApp(item.lat.toString(), item.long.toString());
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx,state)=> const SizedBox(height: 10,),
              itemCount: list.length,
          );
        },
      ),
    );
  }
}
