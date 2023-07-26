import 'dart:io';

import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/locations/presentation/screens/add_location.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class AddNewLocationButton extends StatelessWidget {
  const AddNewLocationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Platform.isIOS?25:10),
      child: CustomButton(
        height: 40.h,
        width: double.infinity,
        circular: 15,
        widget: CustomText(
          color: Colors.white,
          fontSize: AppStyle.small.sp,
          fontWeight: FontWeight.w400,
          text: translate("map.add_location"),
        ),
        color: DMUtil.getRED(),
        onPressed: ()=> Util.pushPage(const AddNewLocationScreen(), context),
      ),
    );
  }
}
