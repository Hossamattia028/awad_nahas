import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
        return BottomNavigationBar(
          onTap: (index)=> bloc.add(ChangeIndex(index: index, title: "")),
          currentIndex: currentIndex,
          backgroundColor: DMUtil.getWC(),
          selectedItemColor: DMUtil.getRED(),
          unselectedItemColor: DMUtil.getD2C(),
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(icon: SvgPicture.asset(AppImages.homeSelected, colorFilter: ColorFilter.mode(currentIndex==0?DMUtil.getRED():DMUtil.getD2C(), BlendMode.srcIn),),label: translate("app_bar.home"),backgroundColor: DMUtil.getWC()),
            BottomNavigationBarItem(icon: SvgPicture.asset(AppImages.categorySelected, colorFilter: ColorFilter.mode(currentIndex==1?DMUtil.getRED():DMUtil.getD2C(), BlendMode.srcIn),),label: translate("app_bar.categories"),backgroundColor: DMUtil.getWC()),
            BottomNavigationBarItem(icon: SvgPicture.asset(AppImages.cartSelected, colorFilter: ColorFilter.mode(currentIndex==2?DMUtil.getRED():DMUtil.getD2C(), BlendMode.srcIn),) ,label: translate("app_bar.cart"),backgroundColor: DMUtil.getWC()),
            BottomNavigationBarItem(icon: SvgPicture.asset(AppImages.accountSelected, colorFilter: ColorFilter.mode(currentIndex==3?DMUtil.getRED():DMUtil.getD2C(), BlendMode.srcIn),) ,label: translate("app_bar.profile"),backgroundColor: DMUtil.getWC()),
          ],
        );
      },
    );
  }
}



