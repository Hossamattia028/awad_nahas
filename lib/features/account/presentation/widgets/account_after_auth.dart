import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_state.dart';

class AccountAuthCard extends StatelessWidget {
  final bool darkText;
  final bool primaryColor;
  const AccountAuthCard({Key? key,this.darkText = false,this.primaryColor = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Color color = Colors.white;
    // if(darkText)color=Colors.black;
    // if(primaryColor)color=kPrimary;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (ctx, state) {
          // var user = AccountBloc.get(ctx).currentUser;
          // if (user == null) return const SizedBox.shrink();
          return Column(
            children: [
              CircleAvatar(
                radius: 50.h,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Image.asset(
                    AppImages.logo,
                    height: 50.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // CustomText(
              //   text: "${translate("profile.welcome")} ${user.userName}",
              //   color: color,
              //   fontFamily: primaryFontSemiBold,
              //   fontSize: AppStyle.average.sp,
              // ),
              // CustomText(
              //   text: user.email.toString(),
              //   color: color,
              //   fontFamily: primaryFontSemiBold,
              //   fontSize: AppStyle.small.sp-3,
              // ),
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
