import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/login.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_state.dart';
import 'package:flutter_translate/flutter_translate.dart';

class AccountAuthCard extends StatelessWidget {
  final bool darkText;
  final bool primaryColor;
  const AccountAuthCard({Key? key,this.darkText = false,this.primaryColor = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (ctx, state) {
          var user = AccountBloc.get(ctx).currentUser;
          // if (user == null) return const SizedBox.shrink();
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.h,
                backgroundColor: DMUtil.getBCC(),
                child: Icon(CupertinoIcons.person,color: DMUtil.getD2C(),),
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text:translate("profile.welcome"),
                    color: DMUtil.getD2C(),
                    fontSize: AppStyle.average.sp,
                  ),
                  InkWell(
                    onTap: ()=> user==null? Util.pushPage(const LoginScreen(), context):debugPrint("exist user"),
                    child: CustomText(
                      text: user == null? translate("drawer.join_us"):user.userName.toString(),
                      color: user == null? DMUtil.getRED() : DMUtil.getD2C(),
                      fontSize: AppStyle.average.sp,
                    ),
                  ),
                ],
              ),

            ],
          );
        },
      ),
    );
  }
}
