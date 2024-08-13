// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/strings/enum/social_enum.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_event.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_state.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class AuthWithSocial extends StatelessWidget {
  final SocialEnum socialEnum;
  final String kind;
  const AuthWithSocial({super.key,required this.socialEnum,required this.kind});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc,AuthState>(
      listener: (ctx,state){
        var bloc = AuthBloc.get(ctx);
        if(state is SocialSuccessfullyState && state.response.isSuccess==true){
          Util.getAllUserAppData(context: context);
          SnackBarBuilder.showFeedBackMessage(context, bloc.resMsg, Colors.green);
          Util.pushPageAndRemoveRoutes(const RootScreen(), context);
        }else{
          SnackBarBuilder.showFeedBackMessage(context, bloc.resMsg, Colors.red);
        }
      },
      listenWhen: (ctx,state) => state is SocialSuccessfullyState  || state is SocialFailedState,
      child: InkWell(
        onTap: ()async{
          var bloc = AuthBloc.get(context);
          Map<String,String> userData =  {};
          if(socialEnum == SocialEnum.PHONE){
            bloc.add(const EnablePhoneRegisterButtonEvent());
            return;
          }else if(socialEnum == SocialEnum.GOOGLE){
             userData = await Util.googleSign();
          }else if(socialEnum == SocialEnum.FACEBOOK){
             userData = await Util.facebookLogin();
          }else if(socialEnum == SocialEnum.APPLE){
             userData = await Util.signInWithApple();
          }
          if(userData['email']== null || !userData['email'].toString().contains("@")){
            SnackBarBuilder.showFeedBackMessage(context, '${userData['email']} ${userData['error']??''}', Colors.red);
            return;
          }
          if(socialEnum == SocialEnum.PHONE)return;
          // SnackBarBuilder.showFeedBackMessage(context,userData['error']!=null ? userData['email'].toString() : '${userData['email']}   ${userData['firstName']} ${userData['lastName']}', Colors.green);
           _socialLogin(bloc, userData);
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
          margin: EdgeInsets.symmetric(vertical: 6.w),
          decoration: BoxDecoration(
              color: DMUtil.getWC(),
              border: Border.all(width: 0.5,color: DMUtil.getD2C()),
              borderRadius: const BorderRadius.all(Radius.circular(15))
          ),
          child:  BlocBuilder<AuthBloc,AuthState>(
              builder: (ctx,state) {
                var bloc = AuthBloc.get(ctx);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Expanded(
                      flex: 1,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if(socialEnum==SocialEnum.FACEBOOK)Image.asset(AppImages.facebook,width: 20.w,height: 22.h,fit: BoxFit.contain,),
                          if(socialEnum==SocialEnum.GOOGLE)Image.asset(AppImages.google,width: 20.w,height: 22.h,fit: BoxFit.contain,),
                          if(socialEnum==SocialEnum.APPLE)Image.asset(AppImages.apple,width: 20.w,height: 22.h,fit: BoxFit.contain,),

                          if(!bloc.registerByPhone)...[
                            if(socialEnum==SocialEnum.PHONE)Image.asset(AppImages.phone,width: 20.w,height: 22.h,fit: BoxFit.contain,),
                          ]else ...[
                            if(socialEnum==SocialEnum.PHONE)Icon(Icons.email_outlined,color: DMUtil.getPC(),),
                          ],

                        ],
                      ),
                    ),

                    // Spacer(flex: 1,),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(socialEnum==SocialEnum.FACEBOOK)CustomText(text: translate("$kind.continue_with_facebook"), fontSize: AppStyle.average.sp),
                          if(socialEnum==SocialEnum.GOOGLE)CustomText(text: translate("$kind.continue_with_google"), fontSize: AppStyle.average.sp),
                          if(socialEnum==SocialEnum.APPLE)CustomText(text: translate("$kind.continue_with_apple"), fontSize: AppStyle.average.sp),

                          if(!bloc.registerByPhone)...[
                            if(socialEnum==SocialEnum.PHONE)CustomText(text: translate("$kind.continue_with_phone"), fontSize: AppStyle.average.sp),
                          ]else ...[
                            if(socialEnum==SocialEnum.PHONE)CustomText(text: translate("$kind.continue_with_email"), fontSize: AppStyle.average.sp),
                          ],

                        ],
                      ),
                    )

                  ],
                );
              }
          ),
        ),
      ),
    );
  }

  _socialLogin(var bloc,Map<String,String> userData){
    bloc.add(SocialLoginEvent(user: {
      'email' : userData['email']??'',
      'first_name' : userData['firstName']??'',
      'last_name' : userData['lastName']??'',
      'password': "social"
    }));
  }
}
