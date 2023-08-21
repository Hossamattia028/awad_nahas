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
  const AuthWithSocial({Key? key,required this.socialEnum}) : super(key: key);

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
          if(socialEnum == SocialEnum.PHONE){
            bloc.add(const EnablePhoneRegisterButtonEvent());
          }else if(socialEnum == SocialEnum.GOOGLE){
            String email = await Util.googleSign();
            _socialLogin(bloc, email);
          }else if(socialEnum == SocialEnum.FACEBOOK){
            String email = await Util.facebookLogin();
            // SnackBarBuilder.showFeedBackMessage(context, email, Colors.green);
            _socialLogin(bloc, email);
          }

        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 7.h),
          margin: const EdgeInsets.symmetric(vertical: 7),
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
                          if(socialEnum==SocialEnum.FACEBOOK)CustomText(text: translate("login.continue_with_facebook"), fontSize: AppStyle.average.sp),
                          if(socialEnum==SocialEnum.GOOGLE)CustomText(text: translate("login.continue_with_google"), fontSize: AppStyle.average.sp),

                          if(!bloc.registerByPhone)...[
                            if(socialEnum==SocialEnum.PHONE)CustomText(text: translate("login.continue_with_phone"), fontSize: AppStyle.average.sp),
                          ]else ...[
                            if(socialEnum==SocialEnum.PHONE)CustomText(text: translate("login.continue_with_email"), fontSize: AppStyle.average.sp),
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

  _socialLogin(var bloc,String email){
    bloc.add(SocialLoginEvent(user: {
      'email' : email,
      'password': email
    }));
  }
}
