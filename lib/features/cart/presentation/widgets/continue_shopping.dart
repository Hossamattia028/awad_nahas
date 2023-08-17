import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/screens/check_out_screen.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';



class ContinueShoppingButton extends StatelessWidget {
  const ContinueShoppingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      height: 45.h,
      width: double.infinity,
      circular: 20,
      widget: CustomText(
        text: translate("cart.continue_shopping"),
        color: Colors.white,
        fontSize: AppStyle.average.sp,
        alignCenter: true,
      ),
      color: DMUtil.getRED(),
      onPressed: (){
        RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
        Util.pushPageAndRemoveRoutes(const RootScreen(), context);
      },
    );
  }
}
