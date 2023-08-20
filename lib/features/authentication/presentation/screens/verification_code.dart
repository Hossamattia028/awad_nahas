// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_event.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/reset_password.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:pin_code_fields/pin_code_fields.dart';



class PinCodeVerificationScreen extends StatefulWidget {
  final Map<String,dynamic> data;
  final bool isRegister;
  const PinCodeVerificationScreen({Key? key,required this.data,required this.isRegister}) : super(key: key);

  @override
  State<PinCodeVerificationScreen> createState() => _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer = TapGestureRecognizer();
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  late AuthBloc authBloc;
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    authBloc = AuthBloc.get(context);
    onTapRecognizer = TapGestureRecognizer()..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      key: scaffoldKey,
      appBar: GlobalAppBar(
        justLogo: false,
        leadingIcon: SizedBox(
          width: 300.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const BackArrowButton(),
              Expanded(
                flex: 2,
                child: CustomText(
                  text: 'OTP',
                  fontSize: AppStyle.large.sp,
                  fontFamily: primaryFontSemiBold,
                  color: DMUtil.getD2C(),
                  alignCenter: true,
                ),
              ),
            ],
          ),
        ),
        title: '',
      ),
      body: GestureDetector(
        onTap: () {},
        child:  SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,),
          child: Column(
            children: [

              SizedBox(height: AppStyle.paddingFromTop.h,),

              CustomText(
                text: translate("signup.write_code"),
                fontSize: AppStyle.small.sp,
                fontFamily: primaryFontSemiBold,
                color: DMUtil.getD2C(),
              ),
              CustomText(
                text: "${translate("signup.code_sent")} \n ${widget.data['phone'] ??  widget.data['email']}",
                fontSize: AppStyle.small.sp,
                color: DMUtil.getD2C(),
                alignCenter: true,
                fontFamily: primaryFontSemiBold,
              ),
              const SizedBox(height: 30,),
              Form(
                  key: formKey,
                  child: Directionality(
                    textDirection: SharedPref.preferences.getPreferenceString(Constants.userLang)=="ar"?TextDirection.ltr:TextDirection.ltr,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 4,
                          obscureText: false,
                          obscuringCharacter: '*',
                          animationType: AnimationType.slide,
                          validator: (v) {
                            if (v!.length < 4) {
                              return "";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            borderWidth: 0,
                            shape: PinCodeFieldShape.box,
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            fieldHeight: 46,
                            fieldWidth: 40,
                            activeColor:kSecondPrimary,
                            activeFillColor: kBackGround,
                            inactiveColor: Colors.white,
                            inactiveFillColor: kBackGround,
                            selectedFillColor:kBackGround,
                            disabledColor: Colors.white,
                          ),
                          // cursorColor: Colors.black,
                          animationDuration: const Duration(milliseconds: 300),
                          textStyle: const TextStyle(fontSize: 20, height: 1.6),
                          // backgroundColor: Colors.white,
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: kSecondPrimary,
                              blurRadius: 6,
                            )
                          ],
                          onCompleted: (v) {
                            debugPrint("Completed");
                          },
                          onChanged: (value) {
                            debugPrint(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            debugPrint("Allowing to paste $text");
                            return true;
                          },
                        )),
                  )
              ),
              Text(
                hasError ?  translate("signup.fill_all") : "",
                style: const TextStyle(
                    color: kPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 25,),
              BlocListener<AuthBloc,AuthState>(
                listener: (ctx,state){
                  var bloc = AuthBloc.get(ctx);
                  if(state is RegisterSuccessfullyState && state.response.isSuccess==true){
                    Util.getAllUserAppData(context: context);
                    SnackBarBuilder.showFeedBackMessage(context, bloc.resMsg, Colors.green);
                    Util.pushPageAndRemoveRoutes(const RootScreen(), context);
                  }else{
                    SnackBarBuilder.showFeedBackMessage(context, bloc.resMsg, Colors.red);
                  }
                },
                listenWhen: (ctx,state) => state is RegisterSuccessfullyState  || state is RegisterFailedState,
                child: BlocBuilder<AuthBloc,AuthState>(
                  builder: (ctx,state){
                    var bloc = AuthBloc.get(ctx);
                    return MaterialButton(
                      onPressed: ()async{
                        var otp = textEditingController.text.trim();
                        if(otp.isEmpty) {
                          SnackBarBuilder.showFeedBackMessage(context, translate("toast.field_empty"), Colors.red);
                          return;
                        }
                        if(await Util.verifyCode(otp)) {
                          if(widget.isRegister){
                            bloc.add(RegisterEvent(user: widget.data));
                          }else{
                            Util.pushPage(ResetPassword(userLogin: widget.data['phone'] ??  widget.data['email'],), context);
                          }
                        }else{
                          SnackBarBuilder.showFeedBackMessage(context, translate("toast.verification_code"), Colors.red);
                        }
                      },
                      minWidth: double.infinity,
                      height: 40.h,
                      color: DMUtil.getRED(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: state is RegisterLoadingState?
                      const CircularProgressIndicator(color: Colors.white,):
                      CustomText(
                        text: translate("button.confirm"),
                        color: Colors.white,
                        fontSize: AppStyle.average.sp+2,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16,),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: translate("signup.not_get_code"),
                    style: TextStyle(
                        fontFamily: primaryFontSemiBold,
                        color: DMUtil.getD2C(), fontSize: AppStyle.small.sp),
                    children: [
                      TextSpan(
                          text: " ${translate("signup.resend")}",
                          recognizer: onTapRecognizer,
                          style: TextStyle(
                              color: kPrimary,
                              fontFamily: primaryFontSemiBold,
                              fontSize: AppStyle.small.sp))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}