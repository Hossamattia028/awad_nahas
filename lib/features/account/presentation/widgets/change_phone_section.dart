// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_state.dart';
import 'package:awad_nahas/features/account/presentation/screens/change_phone.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ChangePhoneSection extends StatelessWidget {
  const ChangePhoneSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DMUtil.getWC(),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w - 4,vertical: 10),
      child:  BlocBuilder<AccountBloc,AccountState>(
        builder: (ctx,state){
          var bloc = AccountBloc.get(ctx);
          var user = bloc.currentUser;
          String userPHone = "";
          if(user!=null)userPHone = user.phoneNumber.toString();
          if(userPHone.startsWith("0"))userPHone = userPHone.substring(1).toString();
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
                    fontSize: AppStyle.average.sp,
                  ),
                ],
              ),

              const SizedBox(height: 15,),
              InkWell(
                onTap: ()=> Util.pushPage(const ChangePhone(), context),
                child: CustomText(
                  text: translate("profile.change_phone"),
                  color: DMUtil.getBlue(),
                  fontWeight: FontWeight.w600,
                  fontSize: AppStyle.small.sp-1,
                ),
              ),
            ],
          );
        },
      )
    );
  }

}
