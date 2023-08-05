
// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_event.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/login.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/home/presentation/screens/home.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_event.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/notifications_utils.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    // AccountBloc.get(context).add(const FetchAllUsersDataEvent());
    CategoriesBloc.get(context).add(const FetchAllCategoriesEvent());
    Util.getAllUserAppData(context: context,isSplash: true);
    Timer(const Duration(seconds: 2), () async{
      await NotificationsUtils.initialPushNotification();
      // if(Util.checkUser()){
        Util.pushPageAndRemoveRoutes(const RootScreen(), context);
      // }else{
      //   Util.pushPageAndRemoveRoutes(const LoginScreen(), context);
      // }
    });
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      // decoration: const BoxDecoration(
      //   color: Colors.white,
      //   image:  DecorationImage(
      //     image: AssetImage(AppImages.logoGif),
      //     fit: BoxFit.contain
      //   )
      // ),
      child: Image.asset(AppImages.logo,width: 200.w,),

    );
  }
}

