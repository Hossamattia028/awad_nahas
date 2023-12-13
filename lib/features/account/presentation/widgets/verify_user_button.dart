// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_state.dart';
import 'package:awad_nahas/features/account/presentation/screens/edit_profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';


class VerifyUserButton extends StatelessWidget {
  final VoidCallback fn;
  const VerifyUserButton({super.key,required this.fn});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc,AccountState>(
      listener: (ctx,state){
        if(state is UpdateProfileState) {
          if (state.response.isSuccess == true) {
            SnackBarBuilder.showFeedBackMessage(
                context, translate("toast.update_user_data"), Colors.green);
            Util.pushPageAndRemoveRoutes(const RootScreen(), context);
            Util.pushPage(const EditProfilePage(), context);
          }
          if (state.response.isFailed == true) {
            SnackBarBuilder.showFeedBackMessage(
                context, translate("toast.oops"), Colors.red);
          }
        }
      },
      listenWhen: (ctx,state){
        return state is UpdateProfileState;
      },
      child: MaterialButton(
        onPressed: fn,
        minWidth: double.infinity,
        height: 40.h,
        color: DMUtil.getRED(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: CustomText(
          text: translate("button.confirm"),
          color: Colors.white,
          fontSize: AppStyle.average.sp+2,
        ),
      ),
    );
  }
}
