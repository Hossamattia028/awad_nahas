import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_event.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class RememberMeWidget extends StatelessWidget {
  const RememberMeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc,AuthState>(
      builder: (ctx,state){
        var bloc = AuthBloc.get(ctx);
        return InkWell(
          onTap: () => bloc.add(const RememberMeEvent()),
          child: Row(
            children: [
              Checkbox(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))
                ),
                value: bloc.rememberMe,
                checkColor: DMUtil.getWC(),
                activeColor: kPrimary,
                side: const BorderSide(color: kText2),
                onChanged: (val)=> bloc.add(const RememberMeEvent()),
              ),
              CustomText(
                  text: translate("login.remember_me"),
                  color: Colors.black,
                  fontFamily: primaryFontSemiBold,
                  fontSize: AppStyle.small.sp),
            ],
          ),
        );
      },
    );
  }
}
