
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/splash.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter_translate/flutter_translate.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: translate("toast.no_internet_connection"),
                color: DMUtil.getD2C(),
                fontSize: 20,
              ),
              IconButton(onPressed: ()=> Util.pushPageAndRemoveRoutes(const SplashScreen(), context), icon:  Icon(Icons.refresh,color: DMUtil.getRED(),)),
            ],
          )
      ),
    );
  }
}
