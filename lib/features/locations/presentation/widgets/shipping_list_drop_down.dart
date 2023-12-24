import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_event.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_state.dart';

class ShippingListWidget extends StatelessWidget {
  final bool isMaintenance;
  const ShippingListWidget({Key? key,this.isMaintenance = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc,LocationsState>(
      builder: (ctx,state){
        var bloc = LocationsBloc.get(ctx);
        List<String> list = Util.getLang()=="ar"?bloc.shippingListAr:bloc.shippingListEn;
        if(list.isEmpty)return const SizedBox.shrink();
        if(bloc.currentShippingCity.trim()=="")bloc.currentShippingCity = list[0].toString().trim();
        return Container(
          height: 40.w,
          decoration: BoxDecoration(
            border: isMaintenance? Border.all(width: 1,color: DMUtil.getOpacity()) : null,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: isMaintenance? DMUtil.getWC() : DMUtil.getBackGround(),
            boxShadow: DMUtil.currentThemeIsDark()?  const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0, // soften the shadow
                spreadRadius: 0.7, //extend the shadow
                offset: Offset(
                  0.01, // Move to right 10  horizontally
                  0.01, // Move to bottom 10 Vertically
                ),
              )
            ]:const [],
          ),
          child: DropdownButton(
            isExpanded: true,
            padding: EdgeInsets.zero,
            dropdownColor: DMUtil.getWC(),
            alignment: Alignment.center,
            underline: const SizedBox.shrink(),
            style: TextStyle(color: DMUtil.getDC(), fontSize: AppStyle.small.sp,),
            hint: Row(
              children: [
                const SizedBox(width: 10,),
                Icon(Icons.location_on_outlined,color: DMUtil.getD2C().withOpacity(0.7),size: AppStyle.average.w,),
                const SizedBox(width: 5,),
                CustomText(
                  text: bloc.currentShippingCity==""?translate("profile.city"):bloc.currentShippingCity,
                  color: DMUtil.getDC(),
                  fontSize: AppStyle.small.sp,
                  isEllipsis: true,
                ),
              ],
            ),
            onChanged: (val)=> bloc.add(UpdateShippingCityEvent(city: val.toString().trim())),
            icon: Icon(Icons.keyboard_arrow_down_outlined,color: DMUtil.getDC(),),
            items: list.map((e) => DropdownMenuItem(
              value: e,
              child: Row(
                children: [
                  const SizedBox(width: 10,),
                  Icon(Icons.location_on_outlined,color: DMUtil.getD2C().withOpacity(0.7),size: AppStyle.average.w,),
                  const SizedBox(width: 5,),
                  CustomText(
                    text: e,
                    color: DMUtil.getDC(),
                    fontSize: AppStyle.small.sp,
                    isEllipsis: true,
                  ),
                ],
              ),
            )).toList(),
            value: bloc.currentShippingCity,
          ),
        );
      },
    );
  }

}
