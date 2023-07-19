import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/features/authentication/presentation/widgets/remember_me.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_from_field_auth.dart';
import 'package:awad_nahas/features/shared_widgets/logo_widget.dart';
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
  static final TextEditingController phoneTextEditingController = TextEditingController();
  static final TextEditingController passTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: const GlobalAppBar(
          justLogo: false,
          // leadingIcon: GlobalWidgets.backArrowButton(()=>Navigator.of(context).pop(),kText2,Alignment.centerRight),
          title: '',
        ),
        body: BlocListener<AuthBloc,AuthState>(
          listenWhen: (context,state)=> state is LogInSuccessfullyState || state is LogInFailedState ,
          listener: (ctx,state){
            var bloc = AuthBloc.get(ctx);
            if(state is LogInSuccessfullyState && state.response.isSuccess==true){
                passTextEditingController.text = "";
                Util.getAllUserAppData(context: context);
                Util.pushPageAndRemoveRoutes(const RootScreen(), context);
                SnackBarBuilder.showFeedBackMessage(context, bloc.resMsg, Colors.green);
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

                const LogoWidget(width: 180,fit: BoxFit.contain,height: 90,),


                const SizedBox(
                  height: 40,
                ),
                AlignChildRow(
                  isStart: true,
                  child: CustomText(
                      text: translate("login.app_bar"),
                      color: Colors.black,
                      fontSize: AppStyle.average.sp,
                      fontFamily: primaryFontSemiBold,
                  ),
                ),
                const SizedBox(height: 10,),
                CustomTextFromFieldAuth(
                    hintText: translate("signup.phone"),
                    radius: 1,
                    textEditingController: phoneTextEditingController,
                    validator: () {},
                    hintColor: kSecondPrimary,
                    textInputType: TextInputType.phone,
                    prefixIcon: Image.asset(AppImages.phone,width: 22.w,),
                    cursorColor: kPrimary,
                    suffixIcon:  null,
                    obscureText: false,
                    isLabelError: false),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<AuthBloc,AuthState>(
                  builder: (ctx,state){
                    var bloc = AuthBloc.get(ctx);
                    bool showPassword = bloc.showPassword;
                    return CustomTextFromFieldAuth(
                        hintText: translate("signup.password"),
                        radius: 1,
                        hintColor: kSecondPrimary,
                        onChanged: (val)=> bloc.add(EnableAuthButtonEvent(enable: validateForm())),
                        onFieldSubmitted: (val)=> bloc.add(EnableAuthButtonEvent(enable: validateForm())),
                        textEditingController: passTextEditingController,
                        cursorColor: kPrimary,
                        validator: () {},
                        prefixIcon: Image.asset(AppImages.lock,width: 22.w,),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const RememberMeWidget(),
                    InkWell(
                      onTap: ()=> Util.pushPage(const ForgetPasswordScreen(), context),
                      child: CustomText(
                          text: translate("login.forget_pass"),
                          color: Colors.black,
                          fontFamily: primaryFontSemiBold,
                          fontSize: AppStyle.small.sp,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<AuthBloc,AuthState>(
                  builder: (ctx,state){
                    if(state is LogInLoadingState)return const CircularProgressIndicator(backgroundColor: kPrimary,);
                    return CustomButton(
                        height: 34.h,
                        width: 105.w,
                        widget: CustomText(
                          text: translate("login.app_bar"),
                          color: kWhite,
                          fontSize: AppStyle.average.sp,
                          fontFamily: primaryFontBold,
                          alignCenter: true,
                        ),
                        color: kPrimary,
                        onPressed: (){
                          if(validateForm()){
                              AuthBloc.get(context).add(LogInEvent(user: {
                                'phone':phoneTextEditingController.text.toString().trim(),
                                'password':passTextEditingController.text.toString().trim(),
                              }));
                          }else{
                            SnackBarBuilder.showFeedBackMessage(context, translate("toast.field_empty"), Colors.red);
                          }
                        },
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        )
    );
  }


  validateForm(){
    if(phoneTextEditingController.text.isNotEmpty&&
        passTextEditingController.text.isNotEmpty)return true;
    return false;
  }
}
