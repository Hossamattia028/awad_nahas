import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          selectedItemColor: DMUtil.getPC(),
          unselectedItemColor: DMUtil.getD2C(),
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.home_filled),label: translate("app_bar.home"),),
            BottomNavigationBarItem(icon: const Icon(Icons.dashboard_outlined),label: translate("app_bar.categories"),),
            BottomNavigationBarItem(icon: const Icon(Icons.shopping_cart_outlined),label: translate("app_bar.cart"),),
            BottomNavigationBarItem(icon: const Icon(CupertinoIcons.person),label: translate("app_bar.profile"),),
          ],
        );
      },
    );
  }
}



