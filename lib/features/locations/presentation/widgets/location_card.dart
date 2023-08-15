// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
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
  const LocationCardWidget({Key? key, required this.locationEntity,required this.currentLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      decoration: BoxDecoration(
        color: DMUtil.getWC(),
        border: Border.all(width: 1,color: currentLocation?DMUtil.getRED():DMUtil.getD2C()),
        borderRadius: BorderRadius.circular(4),
          boxShadow: [
            if(currentLocation)
            BoxShadow(
              blurRadius: 1.0,
              offset: const Offset(0.05, 0.05),
              spreadRadius: 2.2,
              color: DMUtil.getRED().withOpacity(0.3),
            )
          ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleDotsWidget(isEnabled: currentLocation,),
          const SizedBox(width: 5,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 290.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: locationEntity.address1,
                      color: DMUtil.getDC(),
                      fontSize: AppStyle.average.sp,
                      maxLine: 3,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => Util.pushPage(AddNewLocationScreen(locationEntity: locationEntity,), context),
                          child: CustomText(
                            text: translate("button.edit"),
                            color: DMUtil.getDC(),
                            fontSize: AppStyle.average.sp,
                          ),
                        ),
                        // const SizedBox(width: 10,),
                        // InkWell(
                        //   onTap: () async {
                        //     final res = await CustomDialogs.sureToDelete(context);
                        //     if (res == 'ok') LocationsBloc.get(context).add(RemoveLocationEvent(id: locationEntity.id));
                        //   },
                        //   child: Row(
                        //     children: [
                        //       const Icon(
                        //         Icons.delete,
                        //         color: kText1,
                        //         size: 15,
                        //       ),
                        //       CustomText(
                        //         text: translate("button.remove"),
                        //         color: Colors.black,
                        //         fontSize: AppStyle.small.sp,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 7,),
              SmallLineLocationData(
                title: translate("profile.city"),
                value: locationEntity.address1,
              ),
              const SizedBox(height: 5,),
              SmallLineLocationData(
                title: translate("profile.mobile"),
                value: locationEntity.phone,
              ),
              const SizedBox(height: 5,),
            ],
          ),
        ],
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
      width: 100.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(title!=null)
          SizedBox(
            width: 40.w,
            child: CustomText(
              text: title.toString(),
              color: DMUtil.getDC(),
              fontWeight: FontWeight.w400,
              fontSize: AppStyle.small.sp,
            ),
          ),

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
