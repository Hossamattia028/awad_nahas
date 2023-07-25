import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_event.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_state.dart';
import 'package:awad_nahas/features/account/presentation/widgets/profile_image.dart';
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
  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();


  late AccountBloc accountBloc;
  @override
  void didChangeDependencies() {
    accountBloc = AccountBloc.get(context);
    var user = accountBloc.currentUser;
    if(user!=null){
      nameTextEditingController.text = user.userName.toString().replaceAll("null", "");
      emailTextEditingController.text = user.email.toString().replaceAll("null", "");
      phoneTextEditingController.text = user.phoneNumber.toString().replaceAll("null", "");
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
        backgroundColor: kWhite,
        appBar: const GlobalAppBar(
          justLogo: true,
          title: '',
          whiteLogo: true,
          backGroundColor: kPrimary,
          leadingIcon: BackArrowButton(),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: translate("profile.account_setting"),
                color: Colors.black,
                fontSize: AppStyle.large.sp-2,
                fontFamily: primaryFontBold,
              ),
              const SizedBox(height: 20,),
              const ProfileImage(),

              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 55.w,
                    child: CustomText(
                      text: translate("profile.name"),
                      color: Colors.black,
                      fontSize: AppStyle.average.sp-1,
                      fontFamily: primaryFontBold,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: CustomTextFromField(
                        hintText: translate("profile.name"),
                        labelText: "",
                        hasBorder: false,
                        smallPadding: true,
                        cursorColor: kPrimary,
                        radius: 10,
                        textEditingController: nameTextEditingController,
                        validator: (){},
                        obscureText: false,
                        isLabelError: false),
                  ),
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 55.w,
                    child: CustomText(
                      text: translate("profile.email"),
                      color: Colors.black,
                      fontSize: AppStyle.average.sp-1,
                      fontFamily: primaryFontBold,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: CustomTextFromField(
                        hintText: translate("profile.email"),
                        labelText: "",
                        cursorColor: kPrimary,
                        hasBorder: false,
                        smallPadding: true,
                        radius: 10,
                        textInputType: TextInputType.emailAddress,
                        textEditingController: emailTextEditingController,
                        validator: (){},
                        obscureText: false,
                        isLabelError: false),
                  ),
                ],
              ),
              const SizedBox(height: 12,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 55.w,
                    child: CustomText(
                      text: translate("profile.mobile"),
                      color: Colors.black,
                      fontSize: AppStyle.average.sp-1,
                      fontFamily: primaryFontBold,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: CustomTextFromField(
                        hintText: translate("profile.mobile"),
                        labelText: "",
                        cursorColor: kPrimary,
                        smallPadding: true,
                        hasBorder: false,
                        radius: 10,
                        textInputType: TextInputType.phone,
                        textEditingController: phoneTextEditingController,
                        validator: (){},
                        obscureText: false,
                        isLabelError: false),
                  ),
                ],
              ),
              const SizedBox(height: 12,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 55.w,
                    child: CustomText(
                      text: translate("signup.password"),
                      color: Colors.black,
                      fontSize: AppStyle.average.sp-1,
                      fontFamily: primaryFontBold,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: Column(
                      children: [
                        CustomTextFromField(
                          hintText: translate("signup.password"),
                          labelText: "",
                          cursorColor: kPrimary,
                          hasBorder: false,
                          radius: 10,
                          smallPadding: true,
                          textInputType: TextInputType.phone,
                          textEditingController: phoneTextEditingController,
                          validator: (){},
                          obscureText: false,
                          isLabelError: false,
                        ),
                        const SizedBox(height: 5,),
                        CustomTextFromField(
                            hintText: translate("signup.toast_sure"),
                            labelText: "",
                            cursorColor: kPrimary,
                            hasBorder: false,
                            smallPadding: true,
                            radius: 10,
                            textInputType: TextInputType.phone,
                            textEditingController: phoneTextEditingController,
                            validator: (){},
                            obscureText: false,
                            isLabelError: false),

                      ],
                    )
                  ),
                ],
              ),

              const SizedBox(height: 50,),
              BlocBuilder<AccountBloc,AccountState>(
                builder:(ctx,state){
                  AccountBloc bloc = AccountBloc.get(ctx);
                  // if(states==FetchStates.FAILED) return const Center(child: Text("an error occurred"),);
                  return CustomButton(
                      height: 32.h,
                      width: 130.w,
                      circular: 10,
                      widget: state is UpdateProfileState && state.response.isLoad==true? const Center(child: CircularProgressIndicator(color: Colors.white,),):
                      CustomText(
                        color: Colors.white,
                        fontSize: AppStyle.average.sp,
                        fontFamily: primaryFontBold,
                        text: translate("profile.save_changes"),
                      ),
                      color: kPrimary,
                      onPressed: () async {
                        if(emailTextEditingController.text.trim().isNotEmpty&&nameTextEditingController.text.trim().isNotEmpty&&phoneTextEditingController.text.trim().isNotEmpty){
                          bloc.add(UpdateProfileEvent(user: {
                            "phone":phoneTextEditingController.text.trim(),
                            "email":emailTextEditingController.text.trim(),
                            "name":nameTextEditingController.text.trim(),
                          }));
                        }else{
                          return SnackBarBuilder.showFeedBackMessage(context, translate("toast.field_empty"), Colors.red);
                        }
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearData(){
    nameTextEditingController.text = "";
    emailTextEditingController.text = "";
    phoneTextEditingController.text = "";
  }
}
