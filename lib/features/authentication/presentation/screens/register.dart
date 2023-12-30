// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:awad_nahas/core/strings/enum/social_enum.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/core/utils/sms_api.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/verification_code.dart';
import 'package:awad_nahas/features/authentication/presentation/widgets/already_have_account.dart';
import 'package:awad_nahas/features/authentication/presentation/widgets/auth_with_social.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_event.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static final TextEditingController emailTextEditingController = TextEditingController();
  static final TextEditingController firstNameTextEditingController = TextEditingController();
  static final TextEditingController secondNameTextEditingController = TextEditingController();
  static final TextEditingController phoneTextEditingController = TextEditingController();
  static final TextEditingController passwordTextEditingController = TextEditingController();
  static final TextEditingController ageTextEditingController = TextEditingController();
  static final TextEditingController cityTextEditingController = TextEditingController();
  static final TextEditingController addressTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DMUtil.getWC(),
        body: BlocListener<AuthBloc,AuthState>(
          listener: (ctx,state){
            // var bloc = AuthBloc.get(ctx);
            // if(state is RegisterSuccessfullyState && state.response.isSuccess==true){
            //     passwordTextEditingController.text = "";
            //     Util.getAllUserAppData(context: context);
            //     SnackBarBuilder.showFeedBackMessage(context, bloc.resMsg, Colors.green);
            //     Util.pushPageAndRemoveRoutes(const RootScreen(), context);
            // }else{
            //   SnackBarBuilder.showFeedBackMessage(context, bloc.resMsg, Colors.red);
            // }
          },
          listenWhen: (ctx,state) => state is RegisterSuccessfullyState  || state is RegisterFailedState,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppStyle.paddingFromTop.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w),
                  child: Row(
                    children: [
                      const BackArrowButton(),
                      SizedBox(width: 10.w,),
                      CustomText(
                        text: translate("signup.signup"),
                        color: DMUtil.getDC(),
                        fontWeight: FontWeight.w700,
                        fontSize: AppStyle.average.sp,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50.h,
                      width: 160.w,
                      child: CustomTextFromField(
                          hintText: translate("signup.first_name"),
                          labelText: "",
                          radius: 10,
                          hasBorder: true,
                          borderWidth: 1,
                          borderColor: DMUtil.getD2C(),
                          hintColor: kSecondPrimary,
                          textEditingController: firstNameTextEditingController,
                          validator: () {},
                          prefixIcon: null,
                          cursorColor: kPrimary,
                          suffixIcon: const SizedBox(),
                          obscureText: false,
                          isLabelError: false),
                    ),
                    SizedBox(
                      height: 50.h,
                      width: 160.w,
                      child: CustomTextFromField(
                          hintText: translate("signup.last_name"),
                          labelText: "",
                          radius: 10,
                          hasBorder: true,
                          borderWidth: 1,
                          borderColor: DMUtil.getD2C(),
                          hintColor: kSecondPrimary,
                          textEditingController: secondNameTextEditingController,
                          validator: () {},
                          prefixIcon: null,
                          cursorColor: kPrimary,
                          suffixIcon: const SizedBox(),
                          obscureText: false,
                          isLabelError: false),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFromField(
                        textAlign: Util.getLang()=="ar"?TextAlign.left:TextAlign.right,
                        height: 50,
                        hintText: "${translate("signup.phone")} 502441695",
                        radius: 10,
                        textEditingController: phoneTextEditingController,
                        validator: () {},
                        hintColor: kSecondPrimary,
                        textInputType: TextInputType.phone,
                        prefixIcon: null,
                        cursorColor: kPrimary,
                        suffixIcon: null,
                        // suffixIcon: Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 7),
                        //   child: Icon(Icons.phone,color: DMUtil.getD2C(),size: 20.w,),
                        // ),
                        obscureText: false,
                        isLabelError: false,
                        hasBorder: true,
                        borderWidth: 1,
                        borderColor: DMUtil.getD2C(),
                        labelText:"",
                      ),
                    ),
                    Container(
                      height: 50.h,
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     border: Border.all(width: 0,color: DMUtil.getD2C())
                      // ),
                      alignment: Alignment.center,
                      child: CustomText(
                        text: " 966+ ",
                        fontSize: AppStyle.small.sp,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
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
                  suffixIcon:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Icon(Icons.email_outlined,color: DMUtil.getD2C(),size: 20.w,),
                  ),
                  obscureText: false,
                  isLabelError: false,
                  hasBorder: true,
                  borderWidth: 1,
                  borderColor: DMUtil.getD2C(),
                  labelText: '',
                ),

                const SizedBox(height: 20,),
                BlocBuilder<AuthBloc,AuthState>(
                  builder: (ctx,state){
                    var bloc = AuthBloc.get(ctx);
                    bool showPassword = bloc.showPassword;
                    return CustomTextFromField(
                        hasBorder: true,
                        borderWidth: 1,
                        borderColor: DMUtil.getD2C(),
                        labelText: '',
                        height: 50,
                        hintText: translate("signup.password"),
                        radius: 10,
                        hintColor: kSecondPrimary,
                        // onChanged: (val)=> bloc.add(EnableAuthButtonEvent(enable: validateForm(bloc.registerByPhone))),
                        // onFieldSubmitted: (val)=> bloc.add(EnableAuthButtonEvent(enable: validateForm(bloc.registerByPhone))),
                        textEditingController: passwordTextEditingController,
                        cursorColor: kPrimary,
                        validator: () {},
                        prefixIcon: null,
                        obscureText: !showPassword,
                        suffixIcon: InkWell(
                          onTap: () => ctx.read<AuthBloc>().add(const ChangePasswordEvent()),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Icon(
                              showPassword==true
                                  ? CupertinoIcons.eye
                                  : CupertinoIcons.eye_slash,
                              color: DMUtil.getDC(),
                              size: 20.w,
                            ),
                          )
                        ),
                        isLabelError: false,
                    );
                  },
                ),
                const SizedBox(
                  height: 35,
                ),

                BlocBuilder<AuthBloc,AuthState>(
                  builder: (ctx,state){
                    var bloc = AuthBloc.get(ctx);
                    return MaterialButton(
                      onPressed: ()async{
                        SnackBarBuilder.showFeedBackMessage(context, translate("toast.wait"), Colors.green);
                        var phone = "+966${phoneTextEditingController.text.trim()}";
                        var email = emailTextEditingController.text.trim();
                        if(validatePhoneInput(phone, context)==false) return;

                        if(validateForm(context: context) && await SmsApi.sendOtp(provider: bloc.registerByPhone?phone:email,isEmail: !bloc.registerByPhone)){
                          Util.pushPage(PinCodeVerificationScreen(data: {
                            'email':email,
                            'name':"${firstNameTextEditingController.text.trim()} ${secondNameTextEditingController.text.trim()}",
                            'user_login': phoneTextEditingController.text.trim() ,
                            'phone':phone,
                            'password':passwordTextEditingController.text.trim(),
                          },isRegister: true,), context);
                        }else{
                          SnackBarBuilder.showFeedBackMessage(context, translate("toast.field_empty"), Colors.red);
                        }
                      },
                      minWidth: double.infinity,
                      height: 40.h,
                      color: DMUtil.getRED(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:
                      // state is RegisterLoadingState?
                      // const CircularProgressIndicator(color: Colors.white,):
                      CustomText(
                        text: translate("signup.signup"),
                        color: Colors.white,
                        fontSize: AppStyle.average.sp-1,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15,),
                // const AuthWithSocial(socialEnum: SocialEnum.PHONE),
                const AuthWithSocial(socialEnum: SocialEnum.GOOGLE,kind: "signup",),
                const AuthWithSocial(socialEnum: SocialEnum.FACEBOOK,kind: "signup",),
                if(Platform.isIOS)const AuthWithSocial(socialEnum: SocialEnum.APPLE,kind: "signup",),
                const SizedBox(height: 25,),
                const AlreadyHaveAnAccountWidget(),
                const SizedBox(height: 30,),
              ],
            ),
          )
        )
    );
  }
  bool validatePhoneInput(String phone,BuildContext context){
    if(phone.isNotEmpty){
      String? txt = Util.validatePhone(phone);
      if(txt!=null){
        SnackBarBuilder.showFeedBackMessage(context, txt, DMUtil.getRED());
        return false;
      }
    }
    return true;
  }

  validateForm({BuildContext? context}) {
    if(emailTextEditingController.text.isNotEmpty && !emailTextEditingController.text.contains("@")){
      if(context!=null)SnackBarBuilder.showFeedBackMessage(context, translate("toast.email_invalid"), Colors.red);
      return false;
    }
    if (phoneTextEditingController.text.isNotEmpty &&
        emailTextEditingController.text.isNotEmpty &&
        firstNameTextEditingController.text.isNotEmpty &&
        secondNameTextEditingController.text.isNotEmpty &&
        passwordTextEditingController.text.isNotEmpty) return true;

  }
}
