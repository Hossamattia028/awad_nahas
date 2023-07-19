// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_event.dart';
import 'package:awad_nahas/features/locations/presentation/screens/add_location.dart';
import 'package:awad_nahas/features/shared_widgets/custom_dialogs.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class LocationCardWidget extends StatelessWidget {
  final LocationEntity locationEntity;
  const LocationCardWidget({Key? key, required this.locationEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1,color: kSecondPrimary),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.my_location_outlined,
                    color: kRed,
                    size: 17,
                  ),
                  const SizedBox(width: 5,),
                  CustomText(
                    text: locationEntity.type,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: AppStyle.small.sp,
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => Util.pushPage(
                        AddNewLocationScreen(
                          locationEntity: locationEntity,
                        ),
                        context),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.edit_note,
                          color: kText1,
                          size: 17,
                        ),
                        CustomText(
                          text: translate("button.edit"),
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: AppStyle.verySmall.sp,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      final res = await CustomDialogs.sureToDelete(context);
                      if (res == 'ok') LocationsBloc.get(context).add(RemoveLocationEvent(id: locationEntity.id));
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete,
                          color: kText1,
                          size: 15,
                        ),
                        CustomText(
                          text: translate("button.remove"),
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: AppStyle.verySmall.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            color: kSecondPrimary,
          ),
          SmallLineLocationData(
            title: translate("map.full_name"),
            value: Util.getName(),
          ),
          const SizedBox(
            height: 7,
          ),
          SmallLineLocationData(
            title: translate("profile.address"),
            value: locationEntity.address,
          ),
          const SizedBox(
            height: 7,
          ),
          SmallLineLocationData(
            title: translate("profile.mobile"),
            value: locationEntity.phone,
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}

class SmallLineLocationData extends StatelessWidget {
  final String title;
  final String value;
  final bool smallCard;
  const SmallLineLocationData(
      {Key? key,
      required this.title,
      required this.value,
      this.smallCard = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.w,
          child: CustomText(
            text: title,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: AppStyle.small.sp - 2,
          ),
        ),

        Expanded(
          child: CustomText(
            text: value,
            color: kText1,
            fontWeight: FontWeight.w500,
            fontSize: AppStyle.verySmall.sp,
            isEllipsis: true,
          ),
        ),
      ],
    );
  }
}
