// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_from_field_auth.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_state.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/verification_code.dart';
import 'package:awad_nahas/features/shared_widgets/align_child_by_row.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:awad_nahas/features/shared_widgets/logo_widget.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';


class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);
  static final TextEditingController phoneTextEditingController = TextEditingController();
  static final TextEditingController passTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: GlobalAppBar(
          justLogo: false,
          leadingIcon: GlobalWidgets.backArrowButton(()=>Navigator.of(context).pop(),kText2,Alignment.centerRight),
          title: '',
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.sp,),
          child:  Column(
            children: [
              SizedBox(height: AppStyle.paddingFromTop.h,),
              LogoWidget(width: 200.w,fit: BoxFit.contain,height: 90.h,),
              const SizedBox(height: 45,),
              AlignChildRow(
                child: CustomText(
                  text: translate("signup.reset_password"),
                  color: kText1,
                  fontFamily: primaryFontSemiBold,
                  fontSize: AppStyle.small.sp,
                ),
              ),
              const SizedBox(height: 5,),
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

              const SizedBox(height: 20,),
              BlocBuilder<AuthBloc,AuthState>(
                builder: (ctx,state){
                  // FetchStates state = AuthBloc.get(context).states;
                  // if(state==FetchStates.LOADING)return const Center(child: CircularProgressIndicator(color: kPrimary,),);
                  return MaterialButton(
                    onPressed: ()async{
                      String phone = phoneTextEditingController.text.trim();
                      if(phone.isNotEmpty){
                        var res = await Util.sendFirebaseVerifyCode(phone);
                        // if(){
                          Util.pushPage(PinCodeVerificationScreen(phone: phoneTextEditingController.text.trim(),), context);
                        // }
                      }else{
                        SnackBarBuilder.showFeedBackMessage(context, translate("toast.field_empty"), Colors.red);
                      }
                    },
                    minWidth: 100.w,
                    height: 34.h,
                    color: kPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CustomText(
                      text: translate("button.send"),
                      color: Colors.white,
                      fontFamily: primaryFontBold,
                      fontSize: AppStyle.average.sp,
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
    );
  }
}
