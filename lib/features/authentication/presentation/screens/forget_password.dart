// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/sms_api.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_state.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/verification_code.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';


class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});
  static final TextEditingController emailTextEditingController = TextEditingController();
  static final TextEditingController phoneTextEditingController = TextEditingController();
  static final TextEditingController passTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DMUtil.getWC(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppStyle.paddingFromTop.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const BackArrowButton(),
                  const SizedBox(width: 10,),
                  CustomText(
                    text: translate("login.forget_pass_"),
                    color: DMUtil.getDC(),
                    fontFamily: primaryFontSemiBold,
                    fontSize: AppStyle.large.sp,
                  ),
                ],
              ),
              SizedBox(height: 20.w,),
              BlocBuilder<AuthBloc,AuthState>(
                builder: (ctx,state){
                  var bloc = AuthBloc.get(ctx);
                  bool registerByPhone = bloc.registerByPhone;
                  return registerByPhone?
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFromField(
                          textAlign: Util.getLang()=="ar"?TextAlign.left:TextAlign.right,
                          height: 50,
                          hintText: "502441695",
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
                          labelText: translate("signup.phone"),),
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
                  ):Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: translate("login.email"),
                        color: DMUtil.getDC(),
                        fontFamily: primaryFontSemiBold,
                        fontSize: AppStyle.average.sp,
                      ),
                      CustomTextFromField(
                          hasBorder: true,
                          borderWidth: 1,
                          borderColor: DMUtil.getD2C(),
                          labelText: '',
                          height: 50,
                          radius: 10,
                          hintText: translate("signup.email"),
                          textEditingController: emailTextEditingController,
                          validator: () {},
                          hintColor: kSecondPrimary,
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: null,
                          cursorColor: kPrimary,
                          suffixIcon:  null,
                          obscureText: false,
                          isLabelError: false),
                    ],
                  );
                },
              ),


              SizedBox(height: 20.w,),
              BlocBuilder<AuthBloc,AuthState>(
                builder: (ctx,state){
                  var bloc = AuthBloc.get(ctx);
                  // FetchStates state = AuthBloc.get(context).states;
                  // if(state==FetchStates.LOADING)return const Center(child: CircularProgressIndicator(color: kPrimary,),);
                  return MaterialButton(
                    onPressed: ()async{
                      String email = emailTextEditingController.text.trim();
                      var phone = "+966${phoneTextEditingController.text.trim()}";
                      if((email.isNotEmpty && bloc.registerByPhone==false) || (phone.isNotEmpty && bloc.registerByPhone==true)){
                        if(await SmsApi.sendOtp(provider: bloc.registerByPhone? phone : email,isEmail: !bloc.registerByPhone)){
                              Util.pushPage(PinCodeVerificationScreen(data: {
                                'user_login': bloc.registerByPhone? phoneTextEditingController.text.trim() : email,
                                if(bloc.registerByPhone)"phone":phoneTextEditingController.text.trim(),
                                if(!bloc.registerByPhone)"email":email,
                              },isRegister: false,), context);
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
                    child: CustomText(
                      text: translate("button.next"),
                      color:  Colors.white,
                      fontFamily: primaryFontBold,
                      fontSize: AppStyle.average.sp,
                    ),
                  );
                },
              ),

              const SizedBox(height: 30,),

            ],
          ),
        )
    );
  }
}
