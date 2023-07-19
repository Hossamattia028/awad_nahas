import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/root_app/bloc/root_state.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc,RootState>(
      builder: (ctx,state){
        var bloc = RootBloc.get(ctx);
        int currentIndex = bloc.currentScreenIndex;
        return Container(
          width: 200,
          height: 50.h,
          padding: const EdgeInsets.only(top: 5),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemWidget(title: translate("app_bar.myorder"), imgPath: AppImages.logo, fn: ()=> bloc.add(const ChangeIndex(index: 0, title: "")),enabled: currentIndex==0,),

              const VDivider(),
              ItemWidget(title: translate("profile.notification"), imgPath: AppImages.logo, fn: ()=> bloc.add(const ChangeIndex(index: 1, title: "")),enabled: currentIndex==1,),

              const VDivider(),
              ItemWidget(title: translate("app_bar.profile"), imgPath: AppImages.logo, fn: ()=> bloc.add(const ChangeIndex(index: 2, title: "")),enabled: currentIndex==2,),
            ],
          ),
        );
      },
    );
  }
}


class ItemWidget extends StatelessWidget {
  final VoidCallback fn;
  final String title;
  final String imgPath;
  final bool enabled;
  const ItemWidget({Key? key,required this.title,required this.imgPath,required this.fn,required this.enabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fn,
      child: Column(
        children: [
          Image.asset(imgPath,height: 20.h,),
          //enabled?kPrimary:
          CustomText(text: title, color: Colors.black, fontSize: AppStyle.small.sp,fontFamily: primaryFontSemiBold,),
        ],
      ),
    );
  }
}


class VDivider extends StatelessWidget {
  const VDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      width: 1.3,
      height: 30.h,
      color: Colors.black,
    );
  }
}


