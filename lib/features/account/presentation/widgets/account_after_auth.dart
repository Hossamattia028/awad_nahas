import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class AccountAuthCard extends StatelessWidget {
  final bool darkText;
  final bool primaryColor;
  const AccountAuthCard({Key? key,this.darkText = false,this.primaryColor = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;
    if(darkText)color=Colors.black;
    if(primaryColor)color=kPrimary;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (ctx, state) {
          var user = AccountBloc.get(ctx).currentUser;
          if (user == null) return const SizedBox.shrink();
          return Column(
            children: [
              CircleAvatar(
                radius: 40.h,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Image.asset(
                    AppImages.logo,
                    height: 40.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              CustomText(
                text: "${translate("profile.welcome")} ${user.userName}",
                color: color,
                fontFamily: primaryFontSemiBold,
                fontSize: AppStyle.average.sp,
              ),
              CustomText(
                text: user.email.toString(),
                color: color,
                fontFamily: primaryFontSemiBold,
                fontSize: AppStyle.small.sp-3,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
