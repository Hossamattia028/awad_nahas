import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';



class ContinueShoppingButton extends StatelessWidget {
  final bool navigateRoot;
  const ContinueShoppingButton({Key? key,this.navigateRoot = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      height: 37.h,
      width: double.infinity,
      circular: 6,
      widget: CustomText(
        text: translate("cart.continue_shopping"),
        color: DMUtil.getRED(),
        fontSize: AppStyle.average.sp,
        fontWeight: FontWeight.w600,
        alignCenter: true,
      ),
      color: DMUtil.getWC(),
      sideColor: DMUtil.getRED(),
      onPressed: ()=> navigateRoot ? {
        RootBloc.get(context).add(const ChangeIndex(index: 0, title: "")) ,
        Util.pushPage(const RootScreen(), context)
      } : Navigator.of(context).pop(),
    );
  }
}


