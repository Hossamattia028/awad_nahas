import 'package:awad_nahas/core/strings/enum/social_enum.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/login.dart';
import 'package:awad_nahas/features/authentication/presentation/widgets/auth_with_social.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_event.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_state.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
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
        backgroundColor: Colors.white,
        body: BlocListener<AuthBloc,AuthState>(
          listener: (ctx,state){
            var bloc = AuthBloc.get(ctx);
            if(state is RegisterSuccessfullyState){
              // if(state.response.state==FetchStates.SUCCESSFULLY){
                passwordTextEditingController.text = "";
                Util.getAllUserAppData(context: context);
                SnackBarBuilder.showFeedBackMessage(context, bloc.resMsg, Colors.green);
                Util.pushPage(const RootScreen(), context);
              // }else{
                SnackBarBuilder.showFeedBackMessage(context, bloc.resMsg, Colors.red);
              // }
            }
          },
          listenWhen: (ctx,state) => state is RegisterSuccessfullyState  || state is RegisterFailedState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppStyle.paddingFromTop.h,),
              Row(
                children: [
                  const BackArrowButton(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: CustomText(
                      text: translate("signup.signup"),
                      color: kText1,
                      fontWeight: FontWeight.w700,
                      fontSize: AppStyle.average.sp,
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    CustomTextFromField(
                      height: 50,
                      hintText: translate("signup.email"),
                      radius: 10,
                      textEditingController: emailTextEditingController,
                      validator: () {},
                      hintColor: kSecondPrimary,
                      textInputType: TextInputType.phone,
                      prefixIcon: null,
                      cursorColor: kPrimary,
                      suffixIcon:  null,
                      obscureText: false,
                      isLabelError: false,
                      hasBorder: true,
                      borderWidth: 1,
                      borderColor: DMUtil.getD2C(),
                      labelText: '',),
                    const SizedBox(height: 15,),
                    CustomTextFromField(
                      height: 50,
                      hintText: translate("signup.phone"),
                      radius: 10,
                      textEditingController: phoneTextEditingController,
                      validator: () {},
                      hintColor: kSecondPrimary,
                      textInputType: TextInputType.phone,
                      prefixIcon: null,
                      cursorColor: kPrimary,
                      suffixIcon:  null,
                      obscureText: false,
                      isLabelError: false,
                      hasBorder: true,
                      borderWidth: 1,
                      borderColor: DMUtil.getD2C(),
                      labelText: '',),
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
                            onChanged: (val)=> bloc.add(EnableAuthButtonEvent(enable: validateForm())),
                            onFieldSubmitted: (val)=> bloc.add(EnableAuthButtonEvent(enable: validateForm())),
                            textEditingController: passwordTextEditingController,
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
                                color: kText2,
                              ),
                            ),
                            isLabelError: false);
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),

                    BlocBuilder<AuthBloc,AuthState>(
                      builder: (ctx,state){
                        return MaterialButton(
                          onPressed: (){
                            if(validateForm()){
                              if(emailTextEditingController.text.contains("@")){
                                AuthBloc.get(context).add(RegisterEvent(user: {
                                  'email':emailTextEditingController.text.toString().trim(),
                                  'name':firstNameTextEditingController.text.toString().trim(),
                                  'user_login':emailTextEditingController.text.toString().trim(),
                                  'phone':phoneTextEditingController.text.toString().trim(),
                                  'password':passwordTextEditingController.text.toString().trim(),
                                }));
                              }else{
                                SnackBarBuilder.showFeedBackMessage(context, translate("toast.email_invalid"), Colors.red);
                              }
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
                          CustomText(
                            text: translate("signup.signup"),
                            color:  DMUtil.getWC(),
                            fontWeight: FontWeight.w500,
                            fontSize: AppStyle.average.sp,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15,),
                    const AuthWithSocial(socialEnum: SocialEnum.PHONE),
                    const AuthWithSocial(socialEnum: SocialEnum.GOOGLE),
                    const AuthWithSocial(socialEnum: SocialEnum.FACEBOOK),
                    const SizedBox(height: 25,),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: "${translate("signup.already_have_account")}  ",
                          children: [
                            TextSpan(
                              text: translate("login.app_bar"),
                              style: TextStyle(
                                color: DMUtil.getPC(),
                                fontWeight: FontWeight.w500,
                                fontSize: AppStyle.average.sp,
                                fontFamily: primaryFontReg,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Util.pushPage(const LoginScreen(), context),
                            )
                          ],
                          style: TextStyle(
                            color: DMUtil.getD2C(),
                            fontFamily: primaryFontReg,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                  ],),
              ),
            ],
          )
        )
    );
  }

  validateForm(){
    if(firstNameTextEditingController.text.isNotEmpty&&
        emailTextEditingController.text.isNotEmpty&&
        phoneTextEditingController.text.isNotEmpty&&
        passwordTextEditingController.text.isNotEmpty)return true;
    return false;
  }
}

// AuthBloc.get(context).add(SendVerifyEmailEvent(email: emailTextEditingController.text.trim()));
// Util.pushPage(PinCodeVerificationScreen(userModel: UserModel(username: fullNameTextEditingController.text.trim(),
//     email: emailTextEditingController.text.trim(),password: passwordTextEditingController.text.trim(),
//     phone:phoneTextEditingController.text.trim(),city: cityTextEditingController.text.trim(),
//     age: ageTextEditingController.text.trim(),address: addressTextEditingController.text.trim()),), context);
