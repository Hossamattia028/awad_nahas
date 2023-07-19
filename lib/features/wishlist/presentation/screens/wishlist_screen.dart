import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';



class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GlobalAppBar(
          title: translate("profile.wishlist"),
          justLogo: true,
          leadingIcon: GlobalWidgets.backArrowButton(()=> Navigator.of(context).pop(),kText1,Alignment.center,),
      ),
      body: const  WishListWidget(),
    );
  }
}
