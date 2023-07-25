import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/screens/cart_screen.dart';
import 'package:awad_nahas/features/categories/presentation/screens/categories_screen.dart';
import 'package:awad_nahas/features/categories/presentation/screens/our_brand.dart';
import 'package:awad_nahas/features/home/presentation/screens/home.dart';
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
          drawer: const DrawerWidget(),
          backgroundColor: kWhite,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              if(!Util.checkUser())const SizedBox.shrink(),
              if (index == 0) ...[
                const HomeScreen(),
              ] else if (index == 1) ...[
                const CategoriesScreen()
              ] else if (index == 2) ...[
                const CartScreen()
              ] else ...[
                const ProfileScreen()
              ],
            ],
          ),
        );
      },
    );
  }
}
