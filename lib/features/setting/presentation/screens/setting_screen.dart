import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GlobalAppBar(
          title: translate("activity_setting.app_bar"),
          leadingIcon:  const BackArrowButton(),
          icon: null,),
      body:  const SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: const [

          ],
        ),
      ),
    );
  }


}
