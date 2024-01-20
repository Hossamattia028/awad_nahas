import 'package:awad_nahas/core/strings/enum/drawer_enum.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CloseWindowIcon extends StatelessWidget {
  final String title;
  const CloseWindowIcon({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomText(text: title, fontSize: AppStyle.average.sp,color: DMUtil.getDC(),fontWeight: FontWeight.w600,),
        InkWell(
          onTap: ()=> RootBloc.get(context).add(const ChangeDrawerViewEvent(drawerEnum: DrawerEnum.MAIN)),
          child: Icon(Icons.close,size: 20.w,color: DMUtil.getD2C(),),
        ),
      ],
    );
  }
}
