// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/strings/enum/social_enum.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/sms_api.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/verification_code.dart';
import 'package:awad_nahas/features/authentication/presentation/widgets/auth_with_social.dart';
import 'package:awad_nahas/features/authentication/presentation/widgets/not_have_an_account.dart';
import 'package:awad_nahas/features/authentication/presentation/widgets/remember_me.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:awad_nahas/features/shared_widgets/logo_widget.dart';
import 'package:awad_nahas/features/shared_widgets/switch_language.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_event.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_state.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/forget_password.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
import 'package:awad_nahas/features/shared_widgets/align_child_by_row.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter_translate/flutter_translate.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static final TextEditingController emailTextEditingController = TextEditingController();
  static final TextEditingController phoneTextEditingController = TextEditingController();
  static final TextEditingController passTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DMUtil.getWC(),
        body: BlocListener<AuthBloc,AuthState>(
          listenWhen: (context,state)=> state is LogInSuccessfullyState || state is LogInFailedState ,
          listener: (ctx,state){
            var bloc = AuthBloc.get(ctx);
            if(state is LogInSuccessfullyState && state.response.isSuccess==true){
                passTextEditingController.text = "";
                Util.getAllUserAppData(context: context);
                SnackBarBuilder.showFeedBackMessage(context, bloc.resMsg, Colors.green);
                Util.pushPageAndRemoveRoutes(const RootScreen(), context);
              }else{
                SnackBarBuilder.showFeedBackMessage(context, bloc.resMsg, Colors.red);
              }
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,),
            child:  Column(
              children: [
                SizedBox(height: AppStyle.paddingFromTop.h,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AlignChildRow(child: BackArrowButton(),),
                    SwitchLanguageWidget(),
                  ],
                ),
                const LogoWidget(width: 180,fit: BoxFit.contain,height: 90,),

                const SizedBox(height: 10,),
                AlignChildRow(
                  isStart: true,
                  child: CustomText(
                      text: translate("login.app_bar"),
                      color: DMUtil.getDC(),
                      fontSize: AppStyle.average.sp,
                      fontFamily: primaryFontSemiBold,
                  ),
                ),
                const SizedBox(height: 10,),
                BlocBuilder<AuthBloc,AuthState>(
                  builder: (ctx,state){
                    var bloc = AuthBloc.get(ctx);
                    bool registerByPhone = bloc.registerByPhone;
                    return registerByPhone?
                    CustomTextFromField(
                      height: 50,
                      hintText: "502441695",
                      radius: 10,
                      textEditingController: phoneTextEditingController,
                      validator: () {},
                      hintColor: kSecondPrimary,
                      textInputType: TextInputType.phone,
                      prefixIcon: null,
                      cursorColor: kPrimary,
                      suffixIcon:  Icon(Icons.phone,color: DMUtil.getD2C(),),
                      obscureText: false,
                      isLabelError: false,
                      hasBorder: true,
                      borderWidth: 1,
                      borderColor: DMUtil.getD2C(),
                      labelText: translate("signup.phone"),):
                    CustomTextFromField(
                      height: 50,
                      hintText: translate("signup.email"),
                      radius: 10,
                      textEditingController: emailTextEditingController,
                      validator: () {},
                      hintColor: kSecondPrimary,
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: null,
                      cursorColor: kPrimary,
                      suffixIcon:  Icon(Icons.email_outlined,color: DMUtil.getD2C(),),
                      obscureText: false,
                      isLabelError: false,
                      hasBorder: true,
                      borderWidth: 1,
                      borderColor: DMUtil.getD2C(),
                      labelText: '',);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<AuthBloc,AuthState>(
                  builder: (ctx,state){
                    var bloc = AuthBloc.get(ctx);
                    bool showPassword = bloc.showPassword;
                    if(bloc.registerByPhone==true)return const SizedBox.shrink();
                    return CustomTextFromField(
                        hasBorder: true,
                        borderWidth: 1,
                        borderColor: DMUtil.getD2C(),
                        labelText: '',
                        height: 50,
                        hintText: translate("signup.password"),
                        radius: 10,
                        hintColor: kSecondPrimary,
                        onChanged: (val)=> bloc.add(EnableAuthButtonEvent(enable: validateForm(bloc.registerByPhone))),
                        onFieldSubmitted: (val)=> bloc.add(EnableAuthButtonEvent(enable: validateForm(bloc.registerByPhone))),
                        textEditingController: passTextEditingController,
                        cursorColor: kPrimary,
                        validator: () {},
                        prefixIcon: null,
                        obscureText: !showPassword,
                        suffixIcon: IconButton(
                          onPressed: () => ctx.read<AuthBloc>().add(const ChangePasswordEvent()),
                          icon: Icon(
                            showPassword==true
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                            color: DMUtil.getD2C(),
                          ),
                        ),
                        isLabelError: false);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const RememberMeWidget(),
                    InkWell(
                      onTap: ()=> Util.pushPage(const ForgetPasswordScreen(), context),
                      child: CustomText(
                          text: translate("login.forget_pass"),
                          color: DMUtil.getDC(),
                          fontFamily: primaryFontSemiBold,
                          fontSize: AppStyle.small.sp,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                BlocBuilder<AuthBloc,AuthState>(
                  builder: (ctx,state){
                    var bloc = AuthBloc.get(ctx);
                    if(state is LogInLoadingState)return CircularProgressIndicator(backgroundColor: DMUtil.getPC(),);
                    return CustomButton(
                        height: 45.h,
                        width: double.infinity,
                        widget: CustomText(
                          text: translate("login.app_bar"),
                          color: Colors.white,
                          fontSize: AppStyle.average.sp,
                          fontFamily: primaryFontBold,
                          alignCenter: true,
                        ),
                        color: DMUtil.getRED(),
                        onPressed: ()async{
                          if(bloc.registerByPhone){
                            var phone = "+966${phoneTextEditingController.text.trim()}";
                            if(validatePhoneInput(bloc.registerByPhone, phone, context)==false) return;
                            if(await SmsApi.sendOtp(provider: phone,isEmail: false)){
                              Util.pushPage(PinCodeVerificationScreen(data: {
                                'user_login': phone,
                                'phone':phone,
                                'password':"otp"
                              },isLogin: true,isRegister: false,), context);
                            }
                            return;
                          }
                          if(validateForm(bloc.registerByPhone)){
                            bloc.add(LogInEvent(user: {
                                if(bloc.registerByPhone)'phone':phoneTextEditingController.text.trim(),
                                if(!bloc.registerByPhone)'email':emailTextEditingController.text.trim(),
                                'password':passTextEditingController.text.trim(),
                              }));
                          }else{
                            SnackBarBuilder.showFeedBackMessage(context, translate("toast.field_empty"), Colors.red);
                          }
                        },
                    );
                  },
                ),
                const SizedBox(height: 15,),
                const AuthWithSocial(socialEnum: SocialEnum.PHONE),
                const AuthWithSocial(socialEnum: SocialEnum.GOOGLE),
                const AuthWithSocial(socialEnum: SocialEnum.FACEBOOK),
                const NotHaveAnAccountWidget(),
                const SizedBox(height: 30,),
              ],
            ),
          ),
        )
    );
  }

  bool validatePhoneInput(bool registerByPhone,String phone,BuildContext context){
    if(registerByPhone&&phone.isNotEmpty){
      String? txt = Util.validatePhone(phone);
      if(txt!=null){
        SnackBarBuilder.showFeedBackMessage(context, txt, DMUtil.getRED());
        return false;
      }
    }
    return true;
  }


  validateForm(bool checkPhone){
    if(!checkPhone) {
      if(emailTextEditingController.text.isEmpty || !emailTextEditingController.text.contains("@")){
        return false;
      }
    }else{
      if(phoneTextEditingController.text.isEmpty) return false;
    }
    if(passTextEditingController.text.isEmpty)return false;
    return true;
  }
}
