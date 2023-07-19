import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/presentation/screens/notifications/notifications_screen.dart';
import 'package:awad_nahas/features/order/presentation/screens/main_order_screen.dart';
import 'package:awad_nahas/features/root_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awad_nahas/features/account/presentation/screens/profile_screen.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_state.dart';
import 'package:awad_nahas/features/root_app/widgets/bottom_nav_bar.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc, RootState>(
      builder: (ctx, state) {
        var bloc = RootBloc.get(ctx);
        int index = bloc.currentScreenIndex;
        return Scaffold(
          bottomNavigationBar: const BottomNavBar(),
          endDrawer: const DrawerWidget(),
          backgroundColor: kWhite,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              if(!Util.checkUser())const SizedBox.shrink(),
              if (index == 0) ...[
                const MainOrderScreen(),
              ] else if (index == 1) ...[
                const NotificationsScreen()
              ] else if (index == 2) ...[
                const ProfileScreen()
              ] else ...[
                const SizedBox.shrink()
              ],
            ],
          ),
        );
      },
    );
  }
}
