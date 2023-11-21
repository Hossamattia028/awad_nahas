
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:awad_nahas/features/shared_widgets/no_connection.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/notifications_utils.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _checkInternet()async{
    if(await Util.isConnected()==false){
      Util.pushPageAndRemoveRoutes(const NoConnectionScreen(), context);
      return;
    }
  }
  @override
  void didChangeDependencies() {
    _checkInternet();
    if(mounted)Util.getAllUserAppData(context: context,isSplash: true);
    Timer(const Duration(seconds: 4), () async{
      await NotificationsUtils.initialPushNotification();
      if(mounted)Util.pushPageAndRemoveRoutes(const RootScreen(), context);
    });
    super.didChangeDependencies();
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.splashGif),
          fit: BoxFit.fill
        )
      ),
      // child: Image.asset(AppImages.logo,width: 200.w,),
    );
  }
}

