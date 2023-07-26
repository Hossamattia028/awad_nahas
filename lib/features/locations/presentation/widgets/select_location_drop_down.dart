import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_event.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_state.dart';

class SelectLocations extends StatelessWidget {
  const SelectLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc,LocationsState>(
      builder: (ctx,state){
        var bloc = LocationsBloc.get(ctx);
        var list = bloc.userLocationsList;
        if(list.isEmpty)return const SizedBox.shrink();
        return DropdownButton(
          isExpanded: true,
          dropdownColor: DMUtil.getWC(),
          alignment: Alignment.center,
          underline: const SizedBox.shrink(),
          style: TextStyle(color: DMUtil.getDC(), fontSize: 12.sp,),
          hint: Row(
            children: [
              Icon(Icons.location_on_outlined,color: DMUtil.getDC(),),
              const SizedBox(width: 10,),
              CustomText(
                text: "${translate("store.deliver_to")} Mohammed",
                color: DMUtil.getDC(),
                fontSize: AppStyle.average.sp,
              ),
            ],
          ),
          onChanged:(val) => bloc.add(UpdateCurrentLocationEvent(locationEntity: val!)),
          icon: Icon(Icons.keyboard_arrow_down_outlined,color: DMUtil.getDC(),),
          items: list.map((e) => DropdownMenuItem(
            value: e,
            child: Row(
              children: [
                Icon(Icons.location_on_outlined,color: DMUtil.getDC(),),
                const SizedBox(width: 10,),
                CustomText(
                  text: "${translate("store.deliver_to")} ",
                  color: DMUtil.getDC(),
                  fontSize: AppStyle.average.sp,
                ),
              ],
            ),
          )).toList(),
          value: bloc.currentCheckOutLocation,
        );
      },
    );
  }

}
