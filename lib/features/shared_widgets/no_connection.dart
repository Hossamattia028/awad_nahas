
import 'package:flutter/material.dart';
import 'package:awad_nahas/splash.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

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
              const CustomText(
                text: "no internet connection",
                color: Colors.black54,
                fontSize: 20,
              ),
              IconButton(onPressed: ()=> Util.pushPageAndRemoveRoutes(const SplashScreen(), context), icon: const Icon(Icons.refresh,color: kPrimary,)),
            ],
          )
      ),
    );
  }
}
