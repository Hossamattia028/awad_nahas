// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/core/utils/sms_api.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_event.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_state.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/reset_password.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/verification_code.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';



class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController firstNameTextEditingController = TextEditingController();
  final TextEditingController lastNameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();
  final TextEditingController passTextEditingController = TextEditingController();

  late AccountBloc accountBloc;
  late LocationsBloc locationsBloc;

  @override
  void didChangeDependencies() {
    locationsBloc = LocationsBloc.get(context);
    accountBloc = AccountBloc.get(context);
    var user = accountBloc.currentUser;
    if(user!=null){
      firstNameTextEditingController.text = user.userName.toString().replaceAll("null", "");
      lastNameTextEditingController.text = user.userName.toString().replaceAll("null", "");
      emailTextEditingController.text = user.email.toString().replaceAll("null", "");
      if(locationsBloc.billingAddress!=null)phoneTextEditingController.text = locationsBloc.billingAddress!.phone;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc,AccountState>(
      listener: (ctx,state){
        if(state is UpdateProfileState) {
          if (state.response.isSuccess == true) {
            SnackBarBuilder.showFeedBackMessage(
                context, translate("toast.update_user_data"), Colors.green);
          }
          if (state.response.isFailed == true) {
            SnackBarBuilder.showFeedBackMessage(
                context, translate("toast.oops"), Colors.red);
          }
        }
      },
      listenWhen: (ctx,state){
        return state is UpdateProfileState;
      },
      child: Scaffold(
        backgroundColor: DMUtil.getWC(),
        appBar: GlobalAppBar(
          title: translate("profile.profile"),
          whiteLogo: true,
          leadingIcon: const BackArrowButton(),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: AppStyle.paddingFromTop.h,horizontal: AppStyle.paddingFromH.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: translate("profile.name"),
                color: DMUtil.getDC(),
                fontSize: AppStyle.average.sp,
              ),
              const SizedBox(width: 5,),
              CustomTextFromField(
                hintText: translate("signup.first_name"),
                labelText: "",
                hasBorder: true,
                smallPadding: true,
                cursorColor: kPrimary,
                radius: 10,
                textEditingController: firstNameTextEditingController,
                validator: (){},
                obscureText: false,
                isLabelError: false,
              ),
              const SizedBox(height: 15,),
              CustomText(
                text: translate("profile.email"),
                color: DMUtil.getDC(),
                fontSize: AppStyle.average.sp,
              ),
              const SizedBox(width: 5,),
              CustomTextFromField(
                  hintText: translate("profile.email"),
                  labelText: "",
                  cursorColor: kPrimary,
                  hasBorder: true,
                  smallPadding: true,
                  radius: 10,
                  textInputType: TextInputType.emailAddress,
                  textEditingController: emailTextEditingController,
                  validator: (){},
                  obscureText: false,
                  isLabelError: false),
              const SizedBox(height: 15,),

              CustomText(
                text: translate("profile.mobile"),
                color: DMUtil.getDC(),
                fontSize: AppStyle.average.sp,
              ),
              const SizedBox(width: 5,),
              Stack(
                alignment: Util.getLang()=="ar"?Alignment.centerLeft:Alignment.centerRight,
                children: [
                  Row(
                    children: [
                      CustomText(
                          text: "+966",
                          fontSize: AppStyle.small.sp,
                      ),
                      Expanded(
                        child: CustomTextFromField(
                          hintText: "502441695",
                          labelText: "",
                          cursorColor: kPrimary,
                          smallPadding: true,
                          hasBorder: true,
                          radius: 10,
                          textInputType: TextInputType.phone,
                          textEditingController: phoneTextEditingController,
                          validator: (){},
                          obscureText: false,
                          isLabelError: false,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: ()async{
                      String phone = "+966${phoneTextEditingController.text.trim()}";
                      if(validatePhoneInput(phone, context)==false) return;
                      if(await SmsApi.sendOtp(provider: phoneTextEditingController.text.trim(),isEmail: false)){
                        Util.pushPage(PinCodeVerificationScreen(data: {
                          'phone':phoneTextEditingController.text.trim(),
                        },isChangePhone: true,), context);
                      }else{
                        SnackBarBuilder.showFeedBackMessage(context, translate("toast.field_empty"), Colors.red);
                      }
                    },
                    child: CustomText(
                      text: translate("button.change"),
                      fontSize: AppStyle.small.sp,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12,),

              // CustomText(
              //   text: translate("signup.password"),
              //   color: DMUtil.getDC(),
              //   fontSize: AppStyle.average.sp,
              // ),
              // const SizedBox(width: 5,),
              // Stack(
              //   alignment: Util.getLang()=="ar"?Alignment.centerLeft:Alignment.centerRight,
              //   children: [
              //     CustomTextFromField(
              //       hintText: "************",
              //       labelText: "",
              //       cursorColor: kPrimary,
              //       hasBorder: true,
              //       radius: 10,
              //       smallPadding: true,
              //       textInputType: TextInputType.visiblePassword,
              //       textEditingController: passTextEditingController,
              //       validator: (){},
              //       obscureText: false,
              //       isLabelError: false,
              //     ),
              //     TextButton(
              //         onPressed: ()=> Util.pushPage(const ResetPassword(userLogin: "",goToLogin: false,), context),
              //         child: CustomText(
              //           text: translate("button.change"),
              //           fontSize: AppStyle.small.sp,
              //         ),
              //     ),
              //   ],
              // ),

              const SizedBox(height: 50,),
              BlocBuilder<AccountBloc,AccountState>(
                builder:(ctx,state){
                  AccountBloc bloc = AccountBloc.get(ctx);
                  // if(states==FetchStates.FAILED) return const Center(child: Text("an error occurred"),);
                  return Align(
                    child: CustomButton(
                        height: 40.h,
                        width: double.infinity,
                        circular: 10,
                        widget: state is UpdateProfileState && state.response.isLoad==true? const Center(child: CircularProgressIndicator(color: Colors.white,),):
                        CustomText(
                          color: Colors.white,
                          fontSize: AppStyle.average.sp,
                          fontFamily: primaryFontBold,
                          text: translate("profile.save_changes"),
                        ),
                        color: DMUtil.getRED(),
                        onPressed: () async {
                          // if(emailTextEditingController.text.trim().isNotEmpty&&firstNameTextEditingController.text.trim().isNotEmpty&&){
                            bloc.add(UpdateProfileEvent(user: {
                              "phone":phoneTextEditingController.text.trim(),
                              "email":emailTextEditingController.text.trim(),
                              "name":firstNameTextEditingController.text.trim(),
                            }));
                          // }else{
                          //   return SnackBarBuilder.showFeedBackMessage(context, translate("toast.field_empty"), Colors.red);
                          // }
                        }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearData(){
    firstNameTextEditingController.text = "";
    emailTextEditingController.text = "";
    phoneTextEditingController.text = "";
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
}
