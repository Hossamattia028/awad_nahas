// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_event.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/circle_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';
import 'package:awad_nahas/features/locations/presentation/screens/add_location.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class LocationCardWidget extends StatelessWidget {
  final LocationEntity locationEntity;
  final bool currentLocation;
  final bool isAdd;
  final bool isOrderPage;
  const LocationCardWidget({Key? key, required this.locationEntity,required this.currentLocation,this.isAdd = false,this.isOrderPage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var txt = locationEntity.type=="shipping"?translate("map.shipping_not_found"):translate("map.billing_not_found");
    return InkWell(
      onTap: ()=> LocationsBloc.get(context).add(UpdateCurrentLocationEvent(location: locationEntity)),
      child: Container(
        padding: isOrderPage ? EdgeInsets.zero: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        decoration: BoxDecoration(
          color: DMUtil.getWC(),
          // border: isOrderPage? Border.all(width: 0,color: Colors.transparent):Border.all(width: 1,color: currentLocation?DMUtil.getRED():DMUtil.getD2C()),
          borderRadius: BorderRadius.circular(4),
            boxShadow: [
              if(isOrderPage==false)
              BoxShadow(
                blurRadius: 1.0,
                offset: const Offset(0.05, 0.05),
                spreadRadius: 2.2,
                color: currentLocation? DMUtil.getRED().withOpacity(0.5) :DMUtil.getBackGround() ,
              )
            ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleDotsWidget(isEnabled: currentLocation ,),
            // Icon(Icons.location_on,color: DMUtil.getD2C(),),
            const SizedBox(width: 5,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: isOrderPage?270.w: 300.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text:isAdd ? txt : locationEntity.address1,
                        color: DMUtil.getDC(),
                        fontWeight: FontWeight.w600,
                        fontSize: AppStyle.average.sp-2,
                        maxLine: 3,
                      ),
                      InkWell(
                        onTap: () => Util.pushPage(AddNewLocationScreen(locationEntity: isAdd ? null : locationEntity,type: locationEntity.type,), context),
                        child: CustomText(
                          text: isAdd? translate("map.set_location") :translate("button.edit"),
                          color: DMUtil.getD2C(),
                          fontSize: AppStyle.average.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 7,),
                if(locationEntity.address1.isNotEmpty)
                SmallLineLocationData(
                  title: translate("profile.city"),
                  value: locationEntity.address1,
                ),
                const SizedBox(height: 5,),
                if(locationEntity.phone.isNotEmpty)
                SmallLineLocationData(
                  title: translate("profile.mobile"),
                  value: locationEntity.phone,
                ),
                const SizedBox(height: 5,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SmallLineLocationData extends StatelessWidget {
  final String? title;
  final String value;
  final bool smallCard;
  const SmallLineLocationData(
      {Key? key, this.title,
      required this.value,
      this.smallCard = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 230.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if(title!=null)
          SizedBox(
            // width: 80.w,
            child: CustomText(
              text: title.toString(),
              color: DMUtil.getDC(),
              fontWeight: FontWeight.w400,
              fontSize: AppStyle.small.sp,
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: CustomText(
              text: value,
              color: DMUtil.getD2C(),
              fontWeight: FontWeight.w500,
              fontSize: AppStyle.small.sp,
              isEllipsis: true,
            ),
          ),
        ],
      ),
    );
  }
}
