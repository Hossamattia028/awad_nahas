// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/core/utils/sms_api.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_state.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/reset_password.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/verification_code.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ChangePhoneSection extends StatelessWidget {
  const ChangePhoneSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DMUtil.getWC(),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w - 4,vertical: 10),
      child:  BlocBuilder<LocationsBloc,LocationsState>(
        builder: (ctx,state){
          var bloc = LocationsBloc.get(ctx);
          var address = bloc.billingAddress;
          String userPHone = "";
          if(address!=null)userPHone = address.phone;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: translate("profile.mobile"),
                    color: DMUtil.getDC(),
                    fontSize: AppStyle.average.sp,
                  ),
                  const SizedBox(height: 5,),
                  CustomText(
                    text: "$userPHone - 966",
                    color: DMUtil.getDC(),
                    fontWeight: FontWeight.w600,
                    fontSize: AppStyle.average.sp+3,
                  ),

                ],
              ),
              TextButton(
                onPressed: ()async{
                  String phone = "+966$userPHone";
                  if(Util.validatePhoneInput(phone, context)==false) return;
                  if(await SmsApi.sendOtp(provider:userPHone,isEmail: false)){
                    Util.pushPage(PinCodeVerificationScreen(data: {
                      'phone':userPHone,
                    },isChangePhone: true,), context);
                  }else{
                    SnackBarBuilder.showFeedBackMessage(context, translate("toast.field_empty"), Colors.red);
                  }
                },
                child: CustomText(
                  text: translate("profile.change_phone"),
                  color: DMUtil.getBlue(),
                  fontWeight: FontWeight.w600,
                  fontSize: AppStyle.small.sp,
                ),
              ),
            ],
          );
        },
      )
    );
  }

}
