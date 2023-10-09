import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/login.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/register.dart';
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
  final bool isDrawer;
  const AccountAuthCard({Key? key,this.darkText = false,this.primaryColor = false,this.isDrawer = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: DMUtil.getWC(),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (ctx, state) {
          var user = AccountBloc.get(ctx).currentUser;
          // if (user == null) return const SizedBox.shrink();
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if(user == null || Util.checkUser()==false)
              CircleAvatar(
                radius: 20.w,
                backgroundColor: DMUtil.getBCC(),
                child: Icon(CupertinoIcons.person,color: DMUtil.getD2C(),size: 20.w,),
              ),
              SizedBox(width: 10.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text:translate("profile.welcome"),
                    color: DMUtil.getD2C(),
                    fontSize: AppStyle.average.sp,
                  ),
                  const SizedBox(height: 5,),

                  // if(isDrawer && user == null)
                  // InkWell(
                  //   onTap: ()=> user==null? Util.pushPage(const LoginScreen(), context):debugPrint("exist user"),
                  //   child: CustomText(
                  //     text: user == null? translate("drawer.join_us"):user.userName.toString(),
                  //     color: user == null? DMUtil.getRED() : DMUtil.getD2C(),
                  //     fontSize: AppStyle.average.sp,
                  //   ),
                  // ),

                  if(user!=null && Util.checkUser())
                    CustomText(
                      text: user.userName.toString(),
                      color: DMUtil.getD2C(),
                      fontSize: AppStyle.average.sp+2,
                    ),

                  if(user == null || Util.checkUser()==false)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: ()=> Util.pushPage(const LoginScreen(), context),
                          child: CustomText(
                            text:  translate("login.login"),
                            color: DMUtil.getRED() ,
                            fontSize: AppStyle.average.sp,
                          ),
                        ),
                        CustomText(
                          text:  "   /  ",
                          color: DMUtil.getRED() ,
                          fontSize: AppStyle.average.sp,
                        ),
                        InkWell(
                          onTap: ()=> Util.pushPage(const RegisterScreen(), context),
                          child: CustomText(
                            text: translate("login.sing_up_now"),
                            color: DMUtil.getRED(),
                            fontSize: AppStyle.average.sp,
                          ),
                        ),
                      ],
                    )
                ],
              ),

            ],
          );
        },
      ),
    );
  }
}



class AccountAuthCardProfile extends StatelessWidget {
  const AccountAuthCardProfile({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: DMUtil.getWC(),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (ctx, state) {
          var user = AccountBloc.get(ctx).currentUser;
          // if (user == null) return const SizedBox.shrink();
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if(user == null)
                CircleAvatar(
                  radius: 20.w,
                  backgroundColor: DMUtil.getBCC(),
                  child: Icon(CupertinoIcons.person,color: DMUtil.getD2C(),size: 20.w,),
                ),
              SizedBox(width: 10.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        text:translate("profile.welcome"),
                        color: DMUtil.getD2C(),
                        fontSize: AppStyle.average.sp,
                      ),
                      const SizedBox(height: 5,),

                      if(user!=null && Util.checkUser())
                        CustomText(
                          text: user.userName.toString(),
                          color: DMUtil.getD2C(),
                          fontWeight: FontWeight.w600,
                          fontSize: AppStyle.average.sp+2,
                        ),
                    ],
                  ),
                  if(user!=null && Util.checkUser())...[
                    const SizedBox(height: 5,),
                    CustomText(
                      text: user.email.toString(),
                      color: DMUtil.getD2C(),
                      fontSize: AppStyle.small.sp+2,
                    ),
                  ],


                  if(user == null || Util.checkUser()==false)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: ()=> Util.pushPage(const LoginScreen(), context),
                          child: CustomText(
                            text:  translate("login.login"),
                            color: DMUtil.getRED() ,
                            fontSize: AppStyle.average.sp,
                          ),
                        ),
                        CustomText(
                          text:  "   /  ",
                          color: DMUtil.getRED() ,
                          fontSize: AppStyle.average.sp,
                        ),
                        InkWell(
                          onTap: ()=> Util.pushPage(const RegisterScreen(), context),
                          child: CustomText(
                            text: translate("login.sing_up_now"),
                            color: DMUtil.getRED(),
                            fontSize: AppStyle.average.sp,
                          ),
                        ),
                      ],
                    )
                ],
              ),

            ],
          );
        },
      ),
    );
  }
}
