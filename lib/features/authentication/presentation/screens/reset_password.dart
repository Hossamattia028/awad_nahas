import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_event.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_state.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/login.dart';
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
import 'package:awad_nahas/features/shared_widgets/align_child_by_row.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter_translate/flutter_translate.dart';


class ResetPassword extends StatelessWidget {
  final String phone;
  const ResetPassword({Key? key,required this.phone}) : super(key: key);
  static final TextEditingController passTextEditingController = TextEditingController();
  static final TextEditingController passEnsureTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: GlobalAppBar(
          justLogo: false,
          leadingIcon: GlobalWidgets.backArrowButton(()=>Navigator.of(context).pop(),kText2,Alignment.centerRight),
          title: '',
        ),
        body: BlocListener<AccountBloc,AccountState>(
          listenWhen: (context,state)=> state is ChangeUserPasswordState ,
          listener: (ctx,state){
            if(state is ChangeUserPasswordState){
              if(state.response.isSuccess==true){
                passTextEditingController.text = "";
                Util.pushPage(const LoginScreen(), context);
                SnackBarBuilder.showFeedBackMessage(context, state.response.msg.toString(), Colors.green);
              }else if(state.response.isFailed==true){
                SnackBarBuilder.showFeedBackMessage(context, state.response.msg.toString(), Colors.red);
              }
            }
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,),
            child:  Column(
              children: [
                SizedBox(height: AppStyle.paddingFromTop.h,),

                const LogoWidget(width: 180,fit: BoxFit.contain,height: 90,),

                const SizedBox(height: 40,),

                AlignChildRow(
                  isStart: true,
                  child: CustomText(
                      text: translate("login.enter_new_password"),
                      color: Colors.black,
                      fontSize: AppStyle.average.sp,
                      fontFamily: primaryFontSemiBold,
                  ),
                ),
                const SizedBox(height: 10,),
                BlocBuilder<AuthBloc,AuthState>(
                  builder: (ctx,state){
                    var bloc = AuthBloc.get(ctx);
                    bool showPassword = bloc.showPassword;
                    return CustomTextFromFieldAuth(
                        hintText: translate("login.your_password"),
                        radius: 1,
                        hintColor: kSecondPrimary,
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
                        isLabelError: false
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<AuthBloc,AuthState>(
                  builder: (ctx,state){
                    var bloc = AuthBloc.get(ctx);
                    bool showPassword = bloc.showPassword;
                    return CustomTextFromFieldAuth(
                        hintText: translate("login.re_type_password"),
                        radius: 1,
                        hintColor: kSecondPrimary,
                        textEditingController: passEnsureTextEditingController,
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

                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<AccountBloc,AccountState>(
                  builder: (ctx,state){
                    var bloc = AccountBloc.get(ctx);
                    return CustomButton(
                        height: 34.h,
                        width: 100.w,
                        circular: 15,
                        widget: state is ChangeUserPasswordState && state.response.isLoad==true?
                        const CircularProgressIndicator(color: Colors.white,):
                        CustomText(
                          text: translate("button.confirm"),
                          color: kWhite,
                          fontSize: AppStyle.average.sp,
                          fontFamily: primaryFontBold,
                          alignCenter: true,
                        ),
                        color: kPrimary,
                        onPressed: (){
                          if(!checkIfTheSame())return SnackBarBuilder.showFeedBackMessage(context, translate("signup.confirm_password_error"), Colors.red);
                          if(validateForm()){
                            bloc.add(ChangeUserPasswordEvent(data: {
                              "phone": phone,
                              "password": passTextEditingController.text.trim(),
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


  checkIfTheSame(){
    return passTextEditingController.text.trim()==passEnsureTextEditingController.text.trim();
  }
  validateForm(){
    if(passTextEditingController.text.trim().isNotEmpty&&passEnsureTextEditingController.text.trim().isNotEmpty)return true;
    return false;
  }
}
